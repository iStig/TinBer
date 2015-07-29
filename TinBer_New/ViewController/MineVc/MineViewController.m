//
//  MineViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "MineViewController.h"
#import "PersonalViewController.h"

#import "JMNotificationCenter.h"
#import "FMRadioPusher.h"
#import "FMRadioReminder.h"
#import "ReminderViewCell.h"
static NSString *kcell = @"cell";
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,JMSwitchPushDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *event;

@end

@implementation MineViewController


- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
     //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.event = @"jx5C6lxdiHJ9sbz";
    FMRadioReminder *reminder =  [FMRadioReminder radioReminderWithEventID:self.event eventName:@"酷暑难耐，幸运一刻送冰凉" radioName:@"广东电台音乐之声" radioNumber:@"FM99.3" push:YES];
    
    
    NSDate *date1 = [[NSDate date] dateByAddingTimeInterval:10.f];
    NSString *pushID1 = [self stringFromDate:date1];
    //数据库增加推送2
    [FMRadioPusher radioReminderWithPushID:pushID1 pushStartTime:date1 pushNotification:YES fmRadioReminder:reminder];
    //加入本地推送
    [[JMNotificationCenter sharedInstance] addLocalNotificationWithFireDate:date1 activityId:pushID1 activityTitle:reminder.radioName];
    
    
    NSDate *date2 = [[NSDate date] dateByAddingTimeInterval:20.f];
    NSString *pushID2 = [self stringFromDate:date2];
    //数据库增加推送2
    [FMRadioPusher radioReminderWithPushID:pushID2 pushStartTime:date2 pushNotification:YES fmRadioReminder:reminder];
    //加入本地推送
    [[JMNotificationCenter sharedInstance] addLocalNotificationWithFireDate:date2 activityId:pushID2 activityTitle:reminder.radioName];
    

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[ReminderViewCell nib] forCellReuseIdentifier:kcell];

    [self.view addSubview:self.tableView];
}
#pragma mark - JMSwitchPushDelegate
- (void)touchSwith:(BOOL)isOpen cell:(UITableViewCell *)cell{
   NSLog(@"%d",isOpen);
    NSIndexPath *indexPath =  [self.tableView indexPathForCell:cell];
    FMRadioReminder *entity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //刷新coredata数据
    [entity updateReminderPush:entity push:isOpen];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReminderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcell forIndexPath:indexPath];
     cell.delegate = self;
    
    FMRadioReminder *reminder = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.eventName.text = reminder.eventName;
    cell.radioName.text = [NSString stringWithFormat:@"%@ %@",reminder.radioName,reminder.radioNumber];
    cell.pushSwitch.on = [reminder.isPush boolValue];
    NSLog(@"%d___%d",[reminder.isPush boolValue],cell.pushSwitch.on );
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PersonalViewController *v = [[PersonalViewController alloc] init];
    v.reminder = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:v animated:YES];
}

#pragma mark - NSFetchResultsControllerDelegate

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"FMRadioReminder" inManagedObjectContext:JMManagedObjectContext];

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventID = %@",self.event];
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"isPush" ascending:NO];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        [fetchRequest setFetchLimit:5];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:predicate];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:JMManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
        _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        
        if (![_fetchedResultsController performFetch:&error]) {
            NSLog(@"%@: Error fetching message: %@ %@",[self class],error,[error userInfo]);
        }
    }
    
    return _fetchedResultsController;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];//在newIndexPath处插入行
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];//在indexPath处删除行
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeMove://移动行
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];//先删除旧的indexPath处的行
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];//再插入到newIndexPath处
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
    
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName {
    NSLog(@"%@",sectionName);
    return sectionName;
}


//#pragma mark - JMNotification
//- (void)addLocalNotification {
//    [[JMNotificationCenter sharedInstance] addLocalNotificationWithFireDate:[[NSDate date] dateByAddingTimeInterval:10.f] activityId:@"1" activityTitle:@""];
//}
//
//- (void)removeLocalNotification {
//    [[JMNotificationCenter sharedInstance] removeNotificationWithActivityID:@"1"];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

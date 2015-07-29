//
//  PersonalViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "PersonalViewController.h"
#import "JMNotificationCenter.h"
#import "FMRadioPusher.h"
#import "FMRadioReminder.h"
#import "ReminderViewCell.h"
static NSString *kcell = @"cell";

@interface PersonalViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,JMSwitchPushDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *event;


@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
      FMRadioPusher *entity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.reminder updatePusher:entity reminder:self.reminder push:isOpen];
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReminderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcell forIndexPath:indexPath];
    cell.delegate = self;
    
    FMRadioPusher *entity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.eventName.text = [entity.pushStartTime description];
    cell.radioName.text = entity.pushID;
    cell.pushSwitch.on = [entity.isPushNotification boolValue];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - NSFetchResultsControllerDelegate

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"FMRadioPusher" inManagedObjectContext:JMManagedObjectContext];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fmRadioReminder = %@",self.reminder];
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"isPushNotification" ascending:NO];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        [fetchRequest setFetchLimit:100];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

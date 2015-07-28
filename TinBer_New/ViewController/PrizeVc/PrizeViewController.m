//
//  PrizeViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "PrizeViewController.h"
#import "JMNotificationCenter.h"
#import "FMRadioChannel.h"
#import "FMRadioEvent.h"

static NSString *kTableViewCellIdentifier = @"TableViewCell";

@interface PrizeViewController ()<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UIView *headView;
@end

@implementation PrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopTitle:@"兑换中心"];
    // Do any additional setup after loading the view.
    
    FMRadioChannel *channel = [self addChannel:@"rLJGyHeW9CjGkvR"];
    [self addEvent:@"jx5C6lxdiHJ9sbz"
          eventURL:@"http://www.tinberfm.com/a/el/jx5C6lxdiHJ9sbz.html"
       offlineDate:[self stringToDate:@"2015-09-12 14:59"]
           channel:channel];
    
    
    
    [self addEvent:@"mSlPVT7keG2Q8S5"
          eventURL:@"http://www.tinberfm.com/a/el/mSlPVT7keG2Q8S5.html"
       offlineDate:[self stringToDate:@"2015-09-12 15:59"]
           channel:channel];
    
    [self addEvent:@"Tu35L7VqnUysQvx"
          eventURL:@"http://www.tinberfm.com/a/el/Tu35L7VqnUysQvx.html"
       offlineDate:[self stringToDate:@"2015-09-12 16:59"]
           channel:channel];
    
    [self addEvent:@"6UnDJ0vH1JRUZv2"
          eventURL:@"http://www.tinberfm.com/a/el/6UnDJ0vH1JRUZv2.html"
       offlineDate:[self stringToDate:@"2015-09-12 17:59"]
           channel:channel];
    
    
    
    [self addEvent:@"jx5C6lxdiHJ9sbz"
          eventURL:@"http://www.tinberfm.com/a/el/jx5C6lxdiHJ9sbz.html"
       offlineDate:[self stringToDate:@"2015-09-12 19:59"]
           channel:channel];
    
    
    [self.view addSubview:self.tableView];
    
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 100, 30);
        [btn setTitle:@"变更操作" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.center = _headView.center;
        [btn addTarget:self action:@selector(updata:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:btn];
    }
    return _headView;
}

- (void)updata:(id)sender {
    [self addEvent:[NSString stringWithFormat:@"lxdiHJ9sbz%d",arc4random()%10000]
          eventURL:@"http://www.tinberfm.com/a/el/jx5C6lxdiHJ9sbz.html"
       offlineDate:[self stringToDate:@"2015-09-12 21:59"]
           channel:[self addChannel:@"rLJGyHeW9CjGkvR"]];
    
}

#pragma mark - JMCoreData
- (NSDate *)stringToDate:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *value = [dateFormatter dateFromString:date];
    return value;
}

- (FMRadioChannel *)addChannel:(NSString *)channelID {
    FMRadioChannel *channel = [FMRadioChannel radioChannelWithRadioID:channelID];
    return channel;
}

- (FMRadioEvent *)addEvent:(NSString *)eventID
                  eventURL:(NSString *)url
               offlineDate:(NSDate *)date
                   channel:(FMRadioChannel *)channel {
    
    FMRadioEvent *event = [FMRadioEvent radioEventWithEventID:eventID
                                                      channel:channel
                                                     eventURL:url
                                                  offlineDate:date];
    return event;
}


#pragma mark - JMNotification
- (void)addLocalNotification {
    [[JMNotificationCenter sharedInstance] addLocalNotificationWithFireDate:[NSDate date] activityId:1 activityTitle:@"hello"];
}

- (void)removeLocalNotification {
    [[JMNotificationCenter sharedInstance] removeNotificationWithActivityID:1];
}


#pragma mark - UITableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kTableViewCellIdentifier];
    }
    
    FMRadioEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = event.eventID;
    cell.detailTextLabel.text =[event.offlineDateTime description];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}


#pragma mark - NSFetchResultsControllerDelegate

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"FMRadioEvent" inManagedObjectContext:JMManagedObjectContext];
        
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"offlineDateTime" ascending:NO];//时间降序
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fmRadioChannel = %@",[self addChannel:@"rLJGyHeW9CjGkvR"]];
        
        NSArray *sortDescriptors = @[sort];
        
        [fetchRequest setFetchLimit:5];
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:sortDescriptors];
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
            //            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];//更新行
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

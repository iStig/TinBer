//
//  FMRadioReminder.m
//  
//
//  Created by iStig on 15/7/24.
//
//

#import "FMRadioReminder.h"
#import "FMRadioPusher.h"
#import "JMNotificationCenter.h"


@implementation FMRadioReminder

@dynamic eventID;
@dynamic isPush;
@dynamic eventName;
@dynamic radioName;
@dynamic radioNumber;
@dynamic fmRadioPushers;


+ (FMRadioReminder *)radioReminderWithEventID:(NSString *)eventID
                                    eventName:(NSString *)eventName
                                    radioName:(NSString *)radioName
                                  radioNumber:(NSString *)radioNumber
                                         push:(BOOL)isPush
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self)  inManagedObjectContext:JMManagedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventID = %@",eventID];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSArray *list = [JMManagedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (!list.count) {//不存在添加 并且返回
        FMRadioReminder *reminder = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:JMManagedObjectContext];
        reminder.eventID = eventID;
        reminder.eventName = eventName;
        reminder.radioName = radioName;
        reminder.radioNumber = radioNumber;
        reminder.isPush = @(isPush);
        [[JMCoreDataManager sharedCoreDataManager] saveContext];
        return reminder;
    }else {//存在返回
        return [list objectAtIndex:0];
    }
}


- (void)updateReminderPush:(FMRadioReminder *)reminder push:(BOOL)isPush {
     reminder.isPush = @(isPush);
    
    for(FMRadioPusher * pusher in reminder.fmRadioPushers) {
        pusher.isPushNotification = @(isPush);
        
        if (isPush) {
            [[JMNotificationCenter sharedInstance] addLocalNotificationWithFireDate:pusher.pushStartTime activityId:pusher.pushID activityTitle:reminder.radioName];
        }else{
            [[JMNotificationCenter sharedInstance] removeNotificationWithActivityID:pusher.pushID];
        }
    }
      [[JMCoreDataManager sharedCoreDataManager] saveContext];
}


- (void)updatePusher:(FMRadioPusher *)pusher reminder:(FMRadioReminder *)reminder push:(BOOL)isPush {
    pusher.isPushNotification = @(isPush);
    
    if (isPush) {
        [[JMNotificationCenter sharedInstance] addLocalNotificationWithFireDate:pusher.pushStartTime activityId:pusher.pushID activityTitle:reminder.radioName];
    }else{
        [[JMNotificationCenter sharedInstance] removeNotificationWithActivityID:pusher.pushID];
    }
    
   [[JMCoreDataManager sharedCoreDataManager] saveContext];
//    [self enumeratePusher:reminder];
   
 
}

- (void)enumeratePusher:(FMRadioReminder *)reminder {
   static BOOL push = false;
   static NSInteger i = 0 ;
  [reminder.fmRadioPushers enumerateObjectsUsingBlock:^(FMRadioPusher *obj, BOOL *stop) {
     if (i == 0) {
         push = [obj.isPushNotification boolValue];
         NSLog(@"%d",push);
     }
      
     BOOL newPush = [obj.isPushNotification boolValue];
            NSLog(@"%d",newPush);
     if (newPush == push) {
         
     }else {
         push = newPush;
         return ;
     }
     
     i ++;
 }];
    
    [[JMCoreDataManager sharedCoreDataManager] saveContext];
 

}

@end

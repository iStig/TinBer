//
//  FMRadioPusher.m
//  
//
//  Created by iStig on 15/7/24.
//
//

#import "FMRadioPusher.h"
#import "FMRadioReminder.h"


@implementation FMRadioPusher

@dynamic pushID;
@dynamic pushStartTime;
@dynamic fmRadioReminder;
@dynamic isPushNotification;

static FMRadioPusher *sharedInstance = nil;

+ (FMRadioPusher *)radioReminderWithPushID:(NSString *)pushID
                             pushStartTime:(NSDate *)date
                          pushNotification:(BOOL)isPushNotification
                           fmRadioReminder:(FMRadioReminder *)reminder {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:JMManagedObjectContext];
    [fetchRequest setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pushID = %@ && fmRadioReminder = %@ ",pushID,reminder];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [JMManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!fetchedObjects.count) {
    
        FMRadioPusher *pusher = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:JMManagedObjectContext];
        pusher.pushID =pushID;
        pusher.pushStartTime = date;
        pusher.fmRadioReminder = reminder;
        pusher.isPushNotification = @(isPushNotification);
        [[JMCoreDataManager sharedCoreDataManager] saveContext];
        
        return pusher;
    }else {
        return [fetchedObjects objectAtIndex:0];
    }
}






@end

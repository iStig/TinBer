//
//  FMRadioPusher.h
//  
//
//  Created by iStig on 15/7/24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JMCoreDataManager.h"

@class FMRadioReminder;

@interface FMRadioPusher : NSManagedObject

@property (nonatomic, retain) NSString * pushID;
@property (nonatomic, retain) NSDate * pushStartTime;
@property (nonatomic, retain) NSNumber * isPushNotification;
@property (nonatomic, retain) FMRadioReminder *fmRadioReminder;


+ (FMRadioPusher *)radioReminderWithPushID:(NSString *)pushID
                             pushStartTime:(NSDate *)date
                          pushNotification:(BOOL)isPushNotification
                           fmRadioReminder:(FMRadioReminder *)reminder;


@end

//
//  FMRadioReminder.h
//  
//
//  Created by iStig on 15/7/24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JMCoreDataManager.h"
@class FMRadioPusher;

@interface FMRadioReminder : NSManagedObject

@property (nonatomic, retain) NSString * eventID;
@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, retain) NSString * radioName;
@property (nonatomic, retain) NSString * radioNumber;
@property (nonatomic, retain) NSNumber * isPush;
@property (nonatomic, retain) NSSet *fmRadioPushers;

+ (FMRadioReminder *)radioReminderWithEventID:(NSString *)eventID
                                    eventName:(NSString *)eventName
                                    radioName:(NSString *)radioName
                                  radioNumber:(NSString *)radioNumber
                                         push:(BOOL)isPush;

- (void)updateReminderPush:(FMRadioReminder *)reminder push:(BOOL)isPush;

- (void)updatePusher:(FMRadioPusher *)pusher reminder:(FMRadioReminder *)reminder push:(BOOL)isPush ;

@end



//@interface FMRadioReminder (CoreDataGeneratedAccessors)
//
//- (void)addFmRadioPushersObject:(FMRadioPusher *)value;
//- (void)removeFmRadioPushersObject:(FMRadioPusher *)value;
//- (void)addFmRadioPushers:(NSSet *)values;
//- (void)removeFmRadioPushers:(NSSet *)values;
//
//@end

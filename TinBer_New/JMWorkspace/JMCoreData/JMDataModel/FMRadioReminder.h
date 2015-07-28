//
//  FMRadioReminder.h
//  
//
//  Created by iStig on 15/7/24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FMRadioPusher;

@interface FMRadioReminder : NSManagedObject

@property (nonatomic, retain) NSString * eventID;
@property (nonatomic, retain) NSString * eventName;
@property (nonatomic, retain) NSString * radioName;
@property (nonatomic, retain) NSString * radioNumber;
@property (nonatomic, retain) NSSet *fmRadioPushers;
@end

@interface FMRadioReminder (CoreDataGeneratedAccessors)

- (void)addFmRadioPushersObject:(FMRadioPusher *)value;
- (void)removeFmRadioPushersObject:(FMRadioPusher *)value;
- (void)addFmRadioPushers:(NSSet *)values;
- (void)removeFmRadioPushers:(NSSet *)values;

@end

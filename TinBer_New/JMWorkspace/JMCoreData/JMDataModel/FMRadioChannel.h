//
//  FMRadioChannel.h
//  
//
//  Created by iStig on 15/7/24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "JMCoreDataManager.h"

@class FMRadioEvent;

@interface FMRadioChannel : NSManagedObject

@property (nonatomic, retain) NSString * radioID;
@property (nonatomic, retain) NSSet *fmRadioEvents;

+ (FMRadioChannel *)radioChannelWithRadioID:(NSString *)radioID;

@end

@interface FMRadioChannel (CoreDataGeneratedAccessors)

- (void)addFmRadioEventsObject:(FMRadioEvent *)value;
- (void)removeFmRadioEventsObject:(FMRadioEvent *)value;
- (void)addFmRadioEvents:(NSSet *)values;
- (void)removeFmRadioEvents:(NSSet *)values;

@end

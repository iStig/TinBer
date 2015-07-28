//
//  FMRadioEvent.h
//  
//
//  Created by iStig on 15/7/24.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FMRadioChannel;

@interface FMRadioEvent : NSManagedObject

@property (nonatomic, retain) NSString * eventID;
@property (nonatomic, retain) NSString * eventURL;
@property (nonatomic, retain) NSDate * offlineDateTime;
@property (nonatomic, retain) FMRadioChannel *fmRadioChannel;


+ (FMRadioEvent *)radioEventWithEventID:(NSString *)eventID
                                channel:(FMRadioChannel *)channel
                               eventURL:(NSString *)url
                            offlineDate:(NSDate *)date;

@end

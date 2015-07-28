//
//  FMRadioEvent.m
//  
//
//  Created by iStig on 15/7/24.
//
//

#import "FMRadioEvent.h"
#import "FMRadioChannel.h"


@implementation FMRadioEvent

@dynamic eventID;
@dynamic eventURL;
@dynamic offlineDateTime;
@dynamic fmRadioChannel;

+ (FMRadioEvent *)radioEventWithEventID:(NSString *)eventID
                                channel:(FMRadioChannel *)channel
                               eventURL:(NSString *)url
                            offlineDate:(NSDate *)date {

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:JMManagedObjectContext];
    [fetchRequest setEntity:entity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventID = %@ && fmRadioChannel = %@",eventID,channel];
    [fetchRequest setPredicate:predicate];

    NSError *error = nil;
    NSArray *fetchedObjects = [JMManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!fetchedObjects.count) {//添加新event数据
        FMRadioEvent *event = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self)  inManagedObjectContext:JMManagedObjectContext];
        event.eventID = eventID;
        event.fmRadioChannel = channel;
        event.eventURL = url;
        event.offlineDateTime = date;
        
        [[JMCoreDataManager sharedCoreDataManager] saveContext];
        return event;
    }else {
        FMRadioEvent *event = fetchedObjects[0];
        if ([event.offlineDateTime compare:date] == NSOrderedSame) {//当时间相同 暂不做处理
            NSLog(@"offline date is same");
        }else {//当下线时间不同 升级时间
            event.offlineDateTime = date;
        }
        return event;
    }
}
@end

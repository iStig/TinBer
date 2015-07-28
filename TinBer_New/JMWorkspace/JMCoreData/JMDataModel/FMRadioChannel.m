//
//  FMRadioChannel.m
//  
//
//  Created by iStig on 15/7/24.
//
//

#import "FMRadioChannel.h"
#import "FMRadioEvent.h"


@implementation FMRadioChannel

@dynamic radioID;
@dynamic fmRadioEvents;

+ (FMRadioChannel *)radioChannelWithRadioID:(NSString *)radioID {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *channelEntity = [NSEntityDescription entityForName:NSStringFromClass(self)  inManagedObjectContext:JMManagedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"radioID = %@",radioID];
    
    [fetchRequest setEntity:channelEntity];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSArray *list = [JMManagedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (!list.count) {//不存在添加 并且返回
        FMRadioChannel *channel = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:JMManagedObjectContext];
        channel.radioID = radioID;
        [[JMCoreDataManager sharedCoreDataManager] saveContext];
        
        return channel;
    }else {//存在返回
        return [list objectAtIndex:0];
    }
}



@end

//
//  JMNotificationCenter.m
//  TinBer_New
//
//  Created by iStig on 15/7/18.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMNotificationCenter.h"

@implementation JMNotificationCenter

+ (instancetype)sharedInstance {
    static JMNotificationCenter *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)addLocalNotificationWithFireDate:(NSDate *)date activityId:(NSInteger)aid activityTitle:(NSString *)title {
    
    NSDate *time = [NSDate dateWithTimeIntervalSinceNow:10.f];
    NSComparisonResult result = [time compare:date];
    
    if (result == NSOrderedDescending) {
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [date dateByAddingTimeInterval:10.f];
        notification.applicationIconBadgeNumber = 1;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = title;
        notification.repeatInterval = NSCalendarUnitDay;
        notification.userInfo = @{@"id":@(aid)};
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}
- (void)removeNotificationWithActivityID:(NSInteger)aid {
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *localNotifications = [application scheduledLocalNotifications];

    [localNotifications enumerateObjectsUsingBlock:^(UILocalNotification *obj, NSUInteger idx, BOOL *stop) {
        NSInteger activityId = [[obj.userInfo objectForKey:@"id"] intValue];
        if (aid == activityId) {
            [application cancelLocalNotification:obj];
            NSLog(@"取消推送 ID:%@",@(activityId));
            return ;
        }
    }];
       NSLog(@"没检索到要撤销的推送");
}
@end

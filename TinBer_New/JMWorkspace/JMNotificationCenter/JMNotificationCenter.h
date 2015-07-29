//
//  JMNotificationCenter.h
//  TinBer_New
//
//  Created by iStig on 15/7/18.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMNotificationCenter : NSObject
+ (instancetype)sharedInstance;
- (void)addLocalNotificationWithFireDate:(NSDate *)date activityId:(NSString *)aid activityTitle:(NSString *)title;
- (void)removeNotificationWithActivityID:(NSString *)aid;
@end

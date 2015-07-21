//
//  AppDelegate+JMNotificationCenter.m
//  TinBer_New
//
//  Created by iStig on 15/7/18.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "AppDelegate+JMNotificationCenter.h"

@implementation AppDelegate (JMNotificationCenter)
- (void)registerLocalNotificationPush {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:
                                                                             UIUserNotificationTypeAlert|
                                                                             UIUserNotificationTypeBadge|
                                                                             UIUserNotificationTypeSound
                                                                             categories:nil]];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
                                                                              UIRemoteNotificationTypeAlert|
                                                                              UIRemoteNotificationTypeSound];
    }
}
@end

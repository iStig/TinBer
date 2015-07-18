//
//  UIWindow+JMGlobalShake.m
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "UIWindow+JMGlobalShake.h"

NSString *const kUIEventMotionShakeNotification = @"kUIEventMotionShakeNotification";

@implementation UIWindow (JMGlobalShake)

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kUIEventMotionShakeNotification object:self];
    }
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
}

@end

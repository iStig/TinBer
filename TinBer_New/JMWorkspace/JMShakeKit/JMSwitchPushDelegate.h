//
//  SwitchPushDelegate.h
//  TinBer_New
//
//  Created by iStig on 15/7/30.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JMSwitchPushDelegate <NSObject>
- (void)touchSwith:(BOOL)isOpen cell:(UITableViewCell *)cell;
@end

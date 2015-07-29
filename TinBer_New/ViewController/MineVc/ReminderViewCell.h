//
//  ReminderViewCell.h
//  TinBer_New
//
//  Created by iStig on 15/7/30.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMSwitchPushDelegate.h"
@interface ReminderViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *radioName;
@property (weak, nonatomic) IBOutlet UISwitch *pushSwitch;
@property (nonatomic, assign) id <JMSwitchPushDelegate> delegate;
+ (UINib *)nib;
- (IBAction)switchPush:(UISwitch *)sender;
@end

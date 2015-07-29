//
//  ReminderViewCell.m
//  TinBer_New
//
//  Created by iStig on 15/7/30.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "ReminderViewCell.h"

@implementation ReminderViewCell

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)switchPush:(UISwitch *)sender  {
    if ([self.delegate respondsToSelector:@selector(touchSwith:cell:)]) {
        [self.delegate touchSwith:sender.on cell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

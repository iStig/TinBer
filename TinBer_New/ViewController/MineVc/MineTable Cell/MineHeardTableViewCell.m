//
//  MineHeardTableViewCell.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "MineHeardTableViewCell.h"

@implementation MineHeardTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [[_ImageHeard layer]setCornerRadius:25];
    [[_ImageHeard layer]setMasksToBounds:YES];
    [[_ImageHeard layer]setBorderColor:[[UIColor clearColor] CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

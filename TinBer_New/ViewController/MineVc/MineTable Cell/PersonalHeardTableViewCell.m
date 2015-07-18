//
//  PersonalHeardTableViewCell.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "PersonalHeardTableViewCell.h"

@implementation PersonalHeardTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [[_ImagePhoto layer]setCornerRadius:35];
    [[_ImagePhoto layer]setMasksToBounds:YES];
    [[_ImagePhoto layer]setBorderColor:[[UIColor clearColor] CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

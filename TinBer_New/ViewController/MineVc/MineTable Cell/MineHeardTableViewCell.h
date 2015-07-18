//
//  MineHeardTableViewCell.h
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageHeard;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnQiandao;
@property (weak, nonatomic) IBOutlet UIButton *btnHeard;

@end

//
//  JMShakeInfoView.m
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMShakeInfoView.h"
@interface JMShakeInfoView ()
@property (nonatomic, strong) UILabel *infoLab;
@end
@implementation JMShakeInfoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 132, 69)];
        _infoLab.center = self.center;
        _infoLab.text = @"现在猛摇手机大奖等你来拿";
        _infoLab.font = [UIFont systemFontOfSize:22];
        _infoLab.numberOfLines = 2;
        [self addSubview:_infoLab];
        
        self.contentImageV.image = [UIImage imageNamed:@"jm_img_shake_content"];
    }
    return self;
}


@end

//
//  JMShakeNotWinning.m
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMShakeNotWinning.h"
@interface JMShakeNotWinning()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UIButton *eventBtn;
@end
@implementation JMShakeNotWinning

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = self.headImageV.frame;
        
        CGFloat adjustHeight = CGRectGetMaxY(rect);
        adjustHeight =  adjustHeight + 45;
        
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, adjustHeight,self.frame.size.width, 30)];
        
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"您未中奖";
        _titleLab.font = [UIFont systemFontOfSize:22];
        [self addSubview:_titleLab];
        
        adjustHeight =  adjustHeight + _titleLab.frame.size.height;
        _infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, adjustHeight,self.frame.size.width, 30)];
        _infoLab.textAlignment = NSTextAlignmentCenter;
        _infoLab.text = @"不要气馁,继续点击按钮,摇中大奖";
        _infoLab.font = [UIFont systemFontOfSize:16];
        _infoLab.textColor = [UIColor grayColor];
        [self addSubview:_infoLab];
        
        _eventBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _eventBtn.frame = CGRectMake(0, 0, 234, 44);
        _eventBtn.center = CGPointMake(self.center.x, frame.size.height - 23- 22);
        [_eventBtn setTitle:@"再接再厉" forState:UIControlStateNormal];
        [_eventBtn setTitleColor:kShakeRedColor forState:UIControlStateNormal];
        [_eventBtn setBackgroundImage:[UIImage imageNamed:@"jm_img_shake_btn"] forState:UIControlStateNormal];
        [_eventBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_eventBtn];
        
    }
    return self;
}

- (void)sure {
    if ([self.delegate respondsToSelector:@selector(didPressButtonEvent:)]&&self.delegate) {
        [self.delegate didPressButtonEvent:JMShakeResultType_NotWinning];
    }
}

@end

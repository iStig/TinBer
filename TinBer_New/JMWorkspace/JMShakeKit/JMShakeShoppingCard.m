//
//  JMShakeShoppingCard.m
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMShakeShoppingCard.h"
@interface JMShakeShoppingCard()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UIButton *eventBtn;
@end
@implementation JMShakeShoppingCard

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = self.headImageV.frame;
        
        CGFloat adjustHeight = CGRectGetMaxY(rect);
        adjustHeight =  adjustHeight + 19;
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, adjustHeight,self.frame.size.width, 30)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"恭喜中奖!!";
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor grayColor];
        [self addSubview:_titleLab];
        
        adjustHeight =  adjustHeight + _titleLab.frame.size.height + 23;
        
        _infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,132, 69)];
        _infoLab.text = @"30元\n京东购物卡";
        _infoLab.textAlignment =  NSTextAlignmentCenter;
        _infoLab.center = CGPointMake(self.center.x,adjustHeight + 12);
        _infoLab.font = [UIFont systemFontOfSize:22];
        _infoLab.textColor = [UIColor grayColor];
        _infoLab.numberOfLines = 2;
        [self addSubview:_infoLab];
        
        _eventBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _eventBtn.frame = CGRectMake(0, 0, 234, 44);
        _eventBtn.center = CGPointMake(self.center.x, frame.size.height - 23 - 22);
        [_eventBtn setTitle:@"立即领取" forState:UIControlStateNormal];
        [_eventBtn setTitleColor:kShakeRedColor forState:UIControlStateNormal];
        [_eventBtn setBackgroundImage:[UIImage imageNamed:@"jm_img_shake_btn"] forState:UIControlStateNormal];
        [_eventBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_eventBtn];
        
    }
    return self;
}

- (void)sure {
    
}

@end

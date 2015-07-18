//
//  JMShakeOutBaseView.m
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMShakeOutBaseView.h"
@interface JMShakeOutBaseView()
@end
@implementation JMShakeOutBaseView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.contentImageV.image = [UIImage imageNamed:@"jm_img_shake_default"];
        [self addSubview:self.contentImageV];
        
        self.headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.headImageV.image = [UIImage imageNamed:@"jm_img_shake_head"];
        self.headImageV.center = CGPointMake(frame.size.width/2, 100/6);
        [self addSubview:self.headImageV];
    }
    return self;
}

- (void)dismiss {
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

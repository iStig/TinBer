//
//  JMShakeBackView.m
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMShakeBackView.h"
#define kAnimationDuration 0.3f

@interface JMShakeBackView()
@property (nonatomic, assign) BOOL isShake;
@property (nonatomic, strong) JMShakeInfoView *infoView;
@property (nonatomic, strong) JMShakeGoldCoins *goldView;
@property (nonatomic, strong) JMShakeNotWinning *notWinView;
@property (nonatomic, strong) JMShakeShoppingCard *shopCardView;
@end
@implementation JMShakeBackView

#pragma lifecycle
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        _isShake = YES;
        [self addInfoView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma private
- (void)addInfoView {
    self.infoView = [[JMShakeInfoView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    self.infoView.center = self.center;
    [self addSubview:self.infoView];
}


- (void)addGoldCoinsView {
    self.goldView = [[JMShakeGoldCoins alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    self.goldView.center = self.center;
    [self addSubview:self.goldView];
}

- (void)addNotWinningView {
    self.notWinView = [[JMShakeNotWinning alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    self.notWinView.center = self.center;
    [self addSubview:self.notWinView];
}

- (void)addShoppingCardView {
    self.shopCardView = [[JMShakeShoppingCard alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    self.shopCardView.center = self.center;
    [self addSubview:self.shopCardView];
}

#pragma UIEvent
- (void)shake:(NSNotification *)sender {
    NSLog(@"%@",sender.object);
    if (_isShake) {
        [self.infoView dismiss];
        _isShake = NO;
        
//        JMShakeResultType type = arc4random()%4;
        JMShakeResultType type = 2;
        switch (type) {
            case JMShakeResultType_GoldCoins:
                [self addGoldCoinsView];
                break;
            case JMShakeResultType_ShoppingCard:
                [self addNotWinningView];
                break;
            case JMShakeResultType_NotWinning:
                [self addShoppingCardView];
                break;
                
            default:
                break;
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.infoView.frame, pt)) {
        [self dismiss];
    }
}

#pragma public
- (void)dismiss {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show {
    [((AppDelegate *)[UIApplication sharedApplication].delegate).window addSubview:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shake:) name:kUIEventMotionShakeNotification object:nil];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.alpha = 1;
    }];
}

@end

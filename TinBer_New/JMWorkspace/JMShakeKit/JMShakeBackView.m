//
//  JMShakeBackView.m
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMShakeBackView.h"
#define kAnimationDuration 0.3f

@interface JMShakeBackView()<JMButtonEventDelegate>
@property (nonatomic, assign) BOOL isShake;
@property (nonatomic, strong) JMShakeInfoView *infoView;
@property (nonatomic, strong) JMShakeGoldCoins *goldView;
@property (nonatomic, strong) JMShakeNotWinning *notWinView;
@property (nonatomic, strong) JMShakeShoppingCard *shopCardView;
@end
@implementation JMShakeBackView

#pragma mark lifecycle
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

#pragma mark private
- (void)addInfoView {
    self.infoView = [[JMShakeInfoView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    self.infoView.center = self.center;
    [self addSubview:self.infoView];
}


- (void)addGoldCoinsView {
    if (self.goldView) {
        self.goldView = nil;
    }
    
    self.goldView = [[JMShakeGoldCoins alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    self.goldView.center = self.center;
    self.goldView.delegate = self;
    [self addSubview:self.goldView];
}

- (void)addNotWinningView {
    if (self.notWinView) {
        self.notWinView = nil;
    }
    
    self.notWinView = [[JMShakeNotWinning alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    self.notWinView.center = self.center;
    self.notWinView.delegate = self;
    [self addSubview:self.notWinView];
}

- (void)addShoppingCardView {
    if (self.shopCardView) {
        self.shopCardView = nil;
    }
    self.shopCardView = [[JMShakeShoppingCard alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
    self.shopCardView.center = self.center;
    self.shopCardView.delegate = self;
    [self addSubview:self.shopCardView];
}

#pragma mark JMButtonEventDelegate
- (void)didPressButtonEvent:(JMShakeResultType)type {
    NSLog(@"dismiss :%@",[@(type) stringValue]);
    [self dismiss];
    switch (type) {
        case JMShakeResultType_GoldCoins:

            break;
        case JMShakeResultType_ShoppingCard:

            break;
        case JMShakeResultType_NotWinning:

            break;
            
        default:
            break;
    }

}


#pragma mark UIEvent
- (void)shake:(NSNotification *)sender {
//    NSLog(@"%@",sender.object);
    if (_isShake) {
        [self.infoView dismiss];
        _isShake = NO;
        
        JMShakeResultType type = arc4random()%3;
        NSLog(@"pop :%@",[@(type) stringValue]);

        switch (type) {
            case JMShakeResultType_GoldCoins:
                [self addGoldCoinsView];
                break;
            case JMShakeResultType_ShoppingCard:
                [self addShoppingCardView];
                break;
            case JMShakeResultType_NotWinning:
                [self addNotWinningView];
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

#pragma mark public
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

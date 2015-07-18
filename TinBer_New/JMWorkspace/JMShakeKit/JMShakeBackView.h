//
//  JMShakeBackView.h
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWindow+JMGlobalShake.h"
#import "AppDelegate.h"
#import "JMShakeInfoView.h"
#import "JMShakeGoldCoins.h"
#import "JMShakeNotWinning.h"
#import "JMShakeShoppingCard.h"

typedef NS_ENUM(NSUInteger, JMShakeResultType) {
    JMShakeResultType_GoldCoins = 0,
    JMShakeResultType_ShoppingCard = 1,
    JMShakeResultType_NotWinning = 2,
};

@protocol JMShakeViewDelegate <NSObject>
- (void)show;
- (void)dismiss;
@end

@interface JMShakeBackView : UIView <JMShakeViewDelegate>
- (void)show;
- (void)dismiss;
@end

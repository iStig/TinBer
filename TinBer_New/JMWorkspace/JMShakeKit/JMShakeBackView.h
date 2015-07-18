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


@protocol JMShakeViewDelegate <NSObject>
- (void)show;
- (void)dismiss;
@end

@interface JMShakeBackView : UIView <JMShakeViewDelegate>
- (void)show;
- (void)dismiss;
@end

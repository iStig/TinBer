//
//  JMButtonEventDelegate.h
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JMShakeResultType) {
    JMShakeResultType_GoldCoins = 0,
    JMShakeResultType_ShoppingCard = 1,
    JMShakeResultType_NotWinning = 2,
};

@protocol JMButtonEventDelegate <NSObject>
@optional
- (void)didPressButtonEvent:(JMShakeResultType)type;
@end

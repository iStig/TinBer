//
//  JMShakeOutBaseView.h
//  TinBer_New
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMButtonEventDelegate.h"
#define kShakeRedColor [UIColor colorWithRed:249.f/255.f green:69.f/255.f blue:61.f/255.f alpha:1]


@interface JMShakeOutBaseView : UIView<JMButtonEventDelegate>
@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UIImageView *contentImageV;
@property (nonatomic, assign) id <JMButtonEventDelegate> delegate;

- (void)didPressButtonEvent:(JMShakeResultType)type;
- (void)dismiss;
@end

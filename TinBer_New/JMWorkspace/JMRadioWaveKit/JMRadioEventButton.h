//
//  JMRadioEventButton.h
//  TinBer_New
//
//  Created by iStig on 15/7/12.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMRadioEventButtonDelegate.h"

@interface JMRadioEventButton : UIView<JMRadioEventButtonDelegate>
@property (nonatomic, assign) id <JMRadioEventButtonDelegate> delegate;
+ (instancetype)eventView;
@end

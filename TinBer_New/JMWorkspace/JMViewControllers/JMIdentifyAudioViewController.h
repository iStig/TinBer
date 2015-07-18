//
//  JMIdentifyAudioViewController.h
//  TinBer_New
//
//  Created by iStig on 15/7/11.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMRadioEventButtonDelegate.h"
typedef void (^JMRadioEventBlock)(JMRadioEventType);
@interface JMIdentifyAudioViewController : UIViewController
- (instancetype)initWithPopIdentifyAudioViewController:(JMRadioEventBlock)aBlock;

@end

//
//  JMRadioEventButtonDelegate.h
//  TinBer_New
//
//  Created by iStig on 15/7/12.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSUInteger,JMRadioEventType){
    JMRadioEventType_Sure,
    JMRadioEventType_Cancle,
    JMRadioEventType_Close,
};

@protocol JMRadioEventButtonDelegate <NSObject>
@optional
- (void)didPressRadioEventButton:(JMRadioEventType)type;
@end

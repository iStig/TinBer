//
//  JMRadioEventButton.m
//  TinBer_New
//
//  Created by iStig on 15/7/12.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMRadioEventButton.h"
@interface JMRadioEventButton ()
@property (nonatomic, weak) IBOutlet UIButton *cancleBtn;
@property (nonatomic, weak) IBOutlet UIButton *sureBtn;
- (IBAction)canle:(id)sender;
- (IBAction)sure:(id)sender;
@end
@implementation JMRadioEventButton

+ (instancetype)eventView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)canle:(id)sender {
    if([self.delegate respondsToSelector:@selector(didPressRadioEventButton:)]&&self.delegate){
        [self.delegate didPressRadioEventButton:JMRadioEventType_Cancle];
    }
}
- (IBAction)sure:(id)sender {
    if([self.delegate respondsToSelector:@selector(didPressRadioEventButton:)]&&self.delegate){
        [self.delegate didPressRadioEventButton:JMRadioEventType_Sure];
    }
}

@end

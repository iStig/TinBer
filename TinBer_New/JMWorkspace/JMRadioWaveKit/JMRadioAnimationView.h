//
//  JMRadioAnimationView.h
//  SXWaveAnimate
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 Sankuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMRadioAnimationView : UIView
@property (nonatomic, weak) IBOutlet UIImageView *outsideCounterClockwise;
@property (nonatomic, weak) IBOutlet UIImageView *outsideClockwise;
@property (nonatomic, weak) IBOutlet UIImageView *insideCycle;
@property (nonatomic, weak) IBOutlet UIView *waveView;
@property (nonatomic, strong) UIImageView *waveImg;

+ (instancetype)WaveView;
- (void)startAnimation;
@end

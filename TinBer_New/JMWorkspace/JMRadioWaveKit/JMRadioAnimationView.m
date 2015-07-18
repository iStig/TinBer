//
//  JMRadioAnimationView.m
//  SXWaveAnimate
//
//  Created by iStig on 15/7/10.
//  Copyright (c) 2015年 Sankuai. All rights reserved.
//

#import "JMRadioAnimationView.h"
#define kCycleAnimationTimeInteral 3.f
static  NSString *const rotationOutsideAnimationKey = @"rotationOutsideAnimation";
static  NSString *const unrotationOutsideAnimationKey = @"unrotationOutsideAnimation";
static  NSString *const rotationInsideAnimationKey = @"rotationInsideAnimation";
static  NSString *const scrollSlidingAnimationKey = @"scrollSlidingAnimation";

@implementation JMRadioAnimationView

- (void)awakeFromNib {
    self.outsideClockwise.alpha = 0.5f;
    self.outsideCounterClockwise.alpha = 0.5f;
    self.waveView.clipsToBounds = YES;
    self.waveView.layer.cornerRadius = self.waveView.frame.size.width/2;
    
    self.waveImg = [[UIImageView alloc] init];
    self.waveImg.image = [UIImage imageNamed:@"jm_radio_wave"];
    self.waveImg.frame = CGRectMake(0, 0, 636, 163);
    self.waveView.alpha = 0.7f;
    [self.waveView addSubview:self.waveImg];
}

+ (instancetype)WaveView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)startAnimation {
    
    //旋转内侧小圆  顺时针
    CABasicAnimation *transformRotationInside = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    transformRotationInside.byValue = [NSNumber numberWithDouble:(2*M_PI)];
    transformRotationInside.duration = kCycleAnimationTimeInteral;
    transformRotationInside.repeatCount = MAXFLOAT;
    //transformRotationInside.speed = 2;
    [self.insideCycle.layer addAnimation:transformRotationInside forKey:rotationInsideAnimationKey];
    
    //旋转外侧侧大圆  逆时针
    CABasicAnimation *transformRotationOutsideCounter = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    transformRotationOutsideCounter.byValue = [NSNumber numberWithDouble:(-2*M_PI)];
    transformRotationOutsideCounter.duration = kCycleAnimationTimeInteral;
    transformRotationOutsideCounter.repeatCount = MAXFLOAT;
    [self.outsideCounterClockwise.layer addAnimation:transformRotationOutsideCounter forKey:unrotationOutsideAnimationKey];

    //旋转外侧侧大圆  顺时针
    CABasicAnimation *transformRotationOutside = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    transformRotationOutside.byValue = [NSNumber numberWithDouble:(2*M_PI)];
    transformRotationOutside.duration = kCycleAnimationTimeInteral;
    transformRotationOutside.repeatCount = MAXFLOAT;
    [self.outsideClockwise.layer addAnimation:transformRotationOutside forKey:rotationOutsideAnimationKey];
    
    
    NSLog(@"%@",[NSNumber numberWithFloat:self.waveImg.layer.position.x]);
    CAKeyframeAnimation * moveAction = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    moveAction.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-146],[NSNumber numberWithFloat:self.waveImg.layer.position.x],nil];
    moveAction.duration = 8;
    //moveAction.autoreverses = YES;
    moveAction.repeatCount = MAXFLOAT;
    [self.waveImg.layer addAnimation:moveAction forKey:scrollSlidingAnimationKey];

    
}

@end

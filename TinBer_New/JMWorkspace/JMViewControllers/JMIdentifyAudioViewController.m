//
//  JMIdentifyAudioViewController.m
//  TinBer_New
//
//  Created by iStig on 15/7/11.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMIdentifyAudioViewController.h"
#import "JMRadioAnimationView.h"
#import "JMRadioEventButton.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define ANIMATEDURATIONLONG 1.5f
#define ANIMATEDURATION 0.5f
#define ANIMATEDAMPING  0.7f
@interface JMIdentifyAudioViewController ()<JMRadioEventButtonDelegate>
@property(nonatomic,strong)UIVisualEffectView *blurView;
@property (nonatomic, strong) UIImageView *backGroundImageView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) JMRadioAnimationView *radioAnimationView;
@property (nonatomic, strong) JMRadioEventButton *eventButton;
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, copy) JMRadioEventBlock eventBlock;
@end

@implementation JMIdentifyAudioViewController {
    UIViewController *_applicationTopViewController;
    int _previousModalPresentationStyle;
}

#pragma mark Public
- (instancetype)initWithPopIdentifyAudioViewController:(JMRadioEventBlock)aBlock{
    self = [super init];
    if (self) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            self.modalPresentationStyle = UIModalPresentationCustom;
            self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            
        }else{
            _applicationTopViewController = [self topviewController];
            _previousModalPresentationStyle = _applicationTopViewController.modalPresentationStyle;
            _applicationTopViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
            self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        }
        self.eventBlock = aBlock;
    }
    return self;
}

#pragma Helper method
- (UIViewController *)topviewController
{
    UIViewController *topviewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topviewController.presentedViewController) {
        topviewController = topviewController.presentedViewController;
    }
    return topviewController;
}

#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackGroundImageView];
    [self setupCloseButton];
    [self setupInfoLab];
    [self setupEventButton];
    [self setupRadioAnimationView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
        [UIView animateWithDuration:ANIMATEDURATIONLONG delay:0.0 usingSpringWithDamping:ANIMATEDAMPING initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.closeButton.hidden = NO;
            self.backGroundImageView.alpha = 1.0f;
            self.radioAnimationView.center = CGPointMake(self.view.center.x,125 + self.radioAnimationView.frame.size.height/2);
            self.closeButton.center = CGPointMake(self.view.center.x, [UIScreen mainScreen].bounds.size.height - 18 - self.closeButton.frame.size.height/2);
            self.infoLab.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.radioAnimationView.frame) + 22 + self.infoLab.frame.size.height/2);
            self.eventButton.center = CGPointMake(self.view.center.x,CGRectGetMaxY(self.infoLab.frame) + 15 + self.eventButton.frame.size.height/2);
        } completion:^(BOOL finished) {
            [self.radioAnimationView startAnimation];
        }];
}


#pragma mark Private Method
- (void)setupInfoLab {
    self.infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 69)];
    self.infoLab.text = @"正在识别您周围播放的电台节目,小呗将进入自动识别,您是否同意?";
    self.infoLab.textColor = [UIColor whiteColor];
    self.infoLab.font = [UIFont systemFontOfSize:16];
    self.infoLab.center = CGPointMake(self.view.center.x, [UIScreen mainScreen].bounds.size.height + self.infoLab.frame.size.height/2);
    self.infoLab.numberOfLines = 2;
    [self.view addSubview:self.infoLab];
}

- (void)setupEventButton {
    self.eventButton = [JMRadioEventButton eventView];
    self.eventButton.center = CGPointMake(self.view.center.x,[UIScreen mainScreen].bounds.size.height + self.eventButton.frame.size.height/2);
    self.eventButton.delegate = self;
    [self.view addSubview:self.eventButton];
}
- (void)setupRadioAnimationView {
    self.radioAnimationView = [JMRadioAnimationView WaveView];
    self.radioAnimationView.center = CGPointMake(self.view.center.x,[UIScreen mainScreen].bounds.size.height + self.radioAnimationView.frame.size.height/2);
    [self.view addSubview:self.radioAnimationView];
}

- (void)setupBackGroundImageView {
    self.backGroundImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backGroundImageView.alpha = 0.0f;
    self.backGroundImageView.userInteractionEnabled = YES;
    self.backGroundImageView.image = [UIImage imageNamed:@"jm_radio_background"];
    [self.view addSubview:self.backGroundImageView];
}

- (void)setupCloseButton {
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(0, 0, 39, 39);
    self.closeButton.hidden = YES;
    self.closeButton.center = CGPointMake(self.view.center.x, [UIScreen mainScreen].bounds.size.height + self.closeButton.frame.size.height/2);
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"jm_radio_btn_close"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
}


#pragma mark UIEvent
- (void)close {
    [self didPressRadioEventButton:JMRadioEventType_Close];
}

- (void)dismiss {
    [UIView animateWithDuration:ANIMATEDURATIONLONG delay:0.0f usingSpringWithDamping:ANIMATEDAMPING initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.radioAnimationView.center = CGPointMake(self.view.center.x,[UIScreen mainScreen].bounds.size.height - self.radioAnimationView.frame.size.height/10);
          CGAffineTransform transform = CGAffineTransformMakeScale(0.3f, 0.3f);
        self.radioAnimationView.transform = transform;
        self.closeButton.center = CGPointMake(self.view.center.x, [UIScreen mainScreen].bounds.size.height + self.closeButton.frame.size.height/2);
        self.infoLab.center = CGPointMake(self.view.center.x, [UIScreen mainScreen].bounds.size.height + self.infoLab.frame.size.height/2);
        self.eventButton.center = CGPointMake(self.view.center.x,[UIScreen mainScreen].bounds.size.height + self.eventButton.frame.size.height/2);
        self.backGroundImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (SYSTEM_VERSION_LESS_THAN(@"8.0")){
                _applicationTopViewController.modalPresentationStyle = _previousModalPresentationStyle;
            }
        }];
    }];
}

#pragma mark JMRadioEventButtonDelegate
- (void)didPressRadioEventButton:(JMRadioEventType)type {
    NSLog(@"%lu",(unsigned long)type);
    self.eventBlock(type);
    [self dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

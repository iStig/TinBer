//
//  ActiviesHomeViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "ActiviesHomeViewController.h"
#import "JMScrollView.h"
#import "JMAnimationNumberView.h"

@interface ActiviesHomeViewController()
@property (nonatomic, strong) JMAnimationNumberView  *animationNumber;
@property (nonatomic, assign) NSInteger number;
@end

@implementation ActiviesHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
}



- (void)createScrollView {
    NSArray *imageNameArray = @[@"image0.png",@"image1.png",@"image2.png",@"image3.png",@"image2.png"];
    JMScrollView *v = [JMScrollView layoutScrollView:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) WithImages:imageNameArray];
    [self.view addSubview:v];

    _number = 5;
    _animationNumber = [JMAnimationNumberView layoutNumberView];
    _animationNumber.number = [@(_number) stringValue];
    _animationNumber.center = CGPointMake(self.view.center.x, CGRectGetMaxY(_animationNumber.frame)+150);
    [self.view addSubview:_animationNumber];
    
    
    [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(changeValue) userInfo:nil repeats:YES];
}

- (void)changeValue {
    _number = _number*2;
    _animationNumber.number = [@(_number) stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

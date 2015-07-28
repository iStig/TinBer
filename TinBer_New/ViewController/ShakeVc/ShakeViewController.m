//
//  ShakeViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "ShakeViewController.h"
#import "JMShakeBackView.h"
#import "JMCoreDataManager.h"

@interface ShakeViewController ()
@property (nonatomic, strong) UIButton *attendImmediately;
@property (nonatomic, strong) JMShakeBackView *backView;
@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopTitle:@"摇一摇"];
    [self setupAttendButton];
}

- (void)setupAttendButton {
    _attendImmediately = [UIButton buttonWithType:UIButtonTypeCustom];
    _attendImmediately.frame = CGRectMake(0, 0, 375/2, 110/2);
   [_attendImmediately setBackgroundImage:[UIImage imageNamed:@"jm_btn_attend"] forState:UIControlStateNormal];
    _attendImmediately.center = self.view.center;
    [_attendImmediately addTarget:self action:@selector(attend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_attendImmediately];
}

- (void)attend:(UIButton *)sender {
    if (self.backView) {
        self.backView = nil;
    }
    self.backView = [[JMShakeBackView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.backView show];
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

//
//  ListenViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "ListenViewController.h"
#import "JMIdentifyAudioViewController.h"

@interface ListenViewController ()
@property (nonatomic, strong) UIButton *attendImmediately;
@end

@implementation ListenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    JMIdentifyAudioViewController *v = [[JMIdentifyAudioViewController alloc] initWithPopIdentifyAudioViewController:^(JMRadioEventType type){
        switch (type) {
            case JMRadioEventType_Sure:
                
                break;
            case JMRadioEventType_Cancle:
                
                break;
            case JMRadioEventType_Close:
                
                break;
                
            default:
                break;
        }
    }];
    [self presentViewController:v animated:NO completion:nil];
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

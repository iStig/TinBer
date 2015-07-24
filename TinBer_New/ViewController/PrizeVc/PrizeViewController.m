//
//  PrizeViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "PrizeViewController.h"
#import "JMNotificationCenter.h"
@interface PrizeViewController ()

@end

@implementation PrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopTitle:@"兑换中心"];
    // Do any additional setup after loading the view.
    [self addLocalNotification];
}

- (void)addLocalNotification {
    [[JMNotificationCenter sharedInstance] addLocalNotificationWithFireDate:[NSDate date] activityId:1 activityTitle:@"hello"];
}

- (void)removeLocalNotification {
    [[JMNotificationCenter sharedInstance] removeNotificationWithActivityID:1];
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

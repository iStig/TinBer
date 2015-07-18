//
//  LogInViewController.h
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : CommonViewController
@property (weak, nonatomic) IBOutlet UILabel *lblseparatorPassword;

@property (weak, nonatomic) IBOutlet UILabel *lblseparatorUser;
@property (weak, nonatomic) IBOutlet UITextField *TextFildUser;
@property (weak, nonatomic) IBOutlet UITextField *TextFildPassword;

@end

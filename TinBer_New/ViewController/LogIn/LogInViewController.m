//
//  LogInViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "LogInViewController.h"
#import "ForgetPassWordViewController.h"
#import "RegisterViewController.h"

@interface LogInViewController ()<UITextFieldDelegate>

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer * tapDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard:)];
    [self.view addGestureRecognizer:tapDown];
     _TextFildPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    _TextFildUser.clearsOnBeginEditing = UITextFieldViewModeWhileEditing;
    
    [_TextFildUser addTarget:self action:@selector(limitinputlength:) forControlEvents:UIControlEventEditingChanged];
    [_TextFildPassword addTarget:self action:@selector(limitinputlength:) forControlEvents:UIControlEventEditingChanged];
}


//隐藏键盘
- (void)resignKeyboard:(UITapGestureRecognizer *)tap{
    [_TextFildPassword resignFirstResponder];
    [_TextFildUser resignFirstResponder];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden  = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)GotoForgetPasswordView:(id)sender{
    ForgetPassWordViewController * forGetVc = [ForgetPassWordViewController new];
    [self.navigationController pushViewController:forGetVc animated:YES];
}

-(IBAction)GotoRegisterView:(id)sender{
    RegisterViewController * registerVc =[RegisterViewController new];
    [self.navigationController pushViewController:registerVc animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //判断加上输入的字符，是否超过界限
    if (textField == _TextFildPassword)
    {
         _lblseparatorPassword.text = @"";
//        if (range.location == 0) {
//            _lblseparatorPassword.text = @"输入密码";
//        }
        
    }
    
    if (_TextFildUser == textField)
    {
        _lblseparatorUser.text = @"";
//        if (range.location == 0) {
//            _lblseparatorUser.text = @" 输入用户名";
//        }
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@", textField.text, string];
    if (str.length > 11 && textField == _TextFildUser)
    {
        _TextFildUser.text = [str substringToIndex:11];
        return NO;
    }
    return YES;
}

//限制输入长度
-(void)limitinputlength:(UITextField *)sender
{
    NSString *string = sender.text;
    int length;
    if (sender == _TextFildPassword)
    {
        length = 16;
        if (string.length == 0) {
            _lblseparatorPassword.text = @"输入密码";
        }
    }
    else
    {
        length = 11;
        if (string.length ==0) {
             _lblseparatorUser.text = @" 输入用户名";
        }
    }
    
    if (string.length>length) {
        sender.text = [string substringToIndex:length];
    }
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

//
//  RevisePasswordViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "RevisePasswordViewController.h"

@interface RevisePasswordViewController ()<UITextFieldDelegate>{
    UITextField * currentField;
    UITextField * NewField;
    UITextField * NewFieldA;
}

@end

@implementation RevisePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:@"修改密码"];
    
    self.navigationItem.rightBarButtonItem = [self createNavBarBtnWithTitle:@"保存" action:@selector(ResignNavgationRightButtonTouchup:)];
    [self SetMainView];
    [currentField becomeFirstResponder];
    
}

-(void)SetMainView{
    //当前密码
    float heigthH = 15;
    UIView * currentV = [[UIView alloc] initWithFrame:CGRectMake(0, heigthH, ScreenWhite, 54)];
    currentV.backgroundColor = TTWhiteColor;
    [self.view addSubview:currentV];
    
    UILabel * labelCurrent = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 93, 16)];
    labelCurrent.textColor = TTRGBColor(93, 93, 93);
    labelCurrent.text = @"当前密码";
    labelCurrent.font = [UIFont fontWithName:KFontHi size:16.0f];
    [currentV addSubview:labelCurrent];
    
    currentField = [[UITextField alloc] initWithFrame:CGRectMake(110, 18.5, 180, 16)];
    currentField.backgroundColor = TTClearColor;
    currentField.textColor = TTRGBColor(93, 93, 93);
    currentField.borderStyle = UITextBorderStyleNone;
    currentField.font = [UIFont fontWithName:KFontHi size:16.0f];
    currentField.delegate = self;
//    currentField.placeholder = @"昵称";
    [currentV addSubview:currentField];
    
    heigthH = heigthH + 54 + 15;
    
    //新密码
    UIView * currentNew = [[UIView alloc] initWithFrame:CGRectMake(0, heigthH, ScreenWhite, 54)];
    currentNew.backgroundColor = TTWhiteColor;
    [self.view addSubview:currentNew];
    
    UILabel * labelNew = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 93, 16)];
    labelNew.textColor = TTRGBColor(93, 93, 93);
    labelNew.text = @"新密码";
    labelNew.font = [UIFont fontWithName:KFontHi size:16.0f];
    [currentNew addSubview:labelNew];
    
    NewField = [[UITextField alloc] initWithFrame:CGRectMake(110, 18.5, 180, 16)];
    NewField.backgroundColor = TTClearColor;
    NewField.textColor = TTRGBColor(93, 93, 93);
    NewField.borderStyle = UITextBorderStyleNone;
    NewField.font = [UIFont fontWithName:KFontHi size:16.0f];
    NewField.delegate = self;
    NewField.tag = 101;
    //    currentField.placeholder = @"昵称";
    [currentNew addSubview:NewField];
    
    heigthH = heigthH + 54 + 1;
    
    UIView * currentNewA = [[UIView alloc] initWithFrame:CGRectMake(0, heigthH, ScreenWhite, 54)];
    currentNewA.backgroundColor = TTWhiteColor;
    [self.view addSubview:currentNewA];
    
    UILabel * labelNewA = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 93, 16)];
    labelNewA.textColor = TTRGBColor(93, 93, 93);
    labelNewA.text = @"确认新密码";
    labelNewA.font = [UIFont fontWithName:KFontHi size:16.0f];
    [currentNewA addSubview:labelNewA];
    
    NewFieldA = [[UITextField alloc] initWithFrame:CGRectMake(110, 18.5, 180, 16)];
    NewFieldA.backgroundColor = TTClearColor;
    NewFieldA.textColor = TTRGBColor(93, 93, 93);
    NewFieldA.borderStyle = UITextBorderStyleNone;
    NewFieldA.font = [UIFont fontWithName:KFontHi size:16.0f];
    NewFieldA.delegate = self;
    NewFieldA.tag = 102;
    //    currentField.placeholder = @"昵称";
    [currentNewA addSubview:NewFieldA];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [currentField resignFirstResponder];
    [NewFieldA resignFirstResponder];
    [NewField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ResignNavgationRightButtonTouchup:(id)sender{
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

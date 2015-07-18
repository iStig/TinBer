//
//  EditNameViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "EditNameViewController.h"

@interface EditNameViewController ()<UITextFieldDelegate>{
    UITextField * _textFild;
}

@end

@implementation EditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:@"修改昵称"];
    // Do any additional setup after loading the view.
    
    [self setTextFild];
    self.navigationItem.rightBarButtonItem = [self createNavBarBtnWithTitle:@"保存" action:@selector(ResignNavgationRightButtonTouchup:)];
    
}

-(void)setTextFild{
    UIView * viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 15, ScreenWhite, 54)];
    viewBg.backgroundColor = TTWhiteColor;
    
    [self.view addSubview:viewBg];
    
    _textFild= [[UITextField alloc] initWithFrame:CGRectMake(15, 18.5, ScreenWhite - 15 *2 -20, 16)];
    _textFild.backgroundColor = TTClearColor;
    _textFild.textColor = TTRGBColor(93, 93, 93);
    _textFild.borderStyle = UITextBorderStyleNone;
    _textFild.delegate = self;
    _textFild.font = [UIFont fontWithName:KFontHi size:16.0f];
    _textFild.placeholder = @"昵称";
    [viewBg addSubview:_textFild];
    
    UIButton * btnXX = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnXX setFrame:CGRectMake(341, 17.5, 19, 19)];
    [btnXX addTarget:self action:@selector(ClickXXForClear) forControlEvents:UIControlEventTouchUpInside];
    [btnXX setBackgroundImage:[UIImage imageNamed:@"RectangleXX"] forState:UIControlStateNormal];
    [viewBg addSubview:btnXX];
    
}

-(void)ClickXXForClear{
    _textFild.text = @"";
}

-(void)ResignNavgationRightButtonTouchup:(id)sender{
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

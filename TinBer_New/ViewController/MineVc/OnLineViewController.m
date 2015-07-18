//
//  OnLineViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "OnLineViewController.h"

@interface OnLineViewController ()<UITextViewDelegate>{
    UILabel * _lblNUmber;
    UILabel * placeholder;
    UITextView * _TextView;
}

@end

@implementation OnLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTextViewOnViewController];
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:@"线上客服"];
    [_TextView becomeFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [self createNavBarBtnWithTitle:@"发送" action:@selector(ResignNavgationRightButtonTouchup:)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardDidShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardDidHideNotification
                                              object:nil];
}


//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    _TextView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
}

- (void)handleKeyboardDidHidden
{
    _TextView.contentInset=UIEdgeInsetsZero;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_TextView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)ResignNavgationRightButtonTouchup:(id)sender{
    if (_TextView.text.length >6 ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(_TextView.text.length == 0)
    {
        TTAlert(@"反馈信息不能为空");
        
    }
    else
    {
        TTAlert(@"反馈信息不能少于6个字符");
    }
}


-(void)setTextViewOnViewController{
    _TextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 15, ScreenWhite - 40, ScreenHeigth - 340)];
    _TextView.backgroundColor = TTClearColor;
    _TextView.tintColor = TTRGBColor(249, 69, 61);
    _TextView.font = [UIFont systemFontOfSize:16.0f];
    _TextView.delegate = self;
    
    placeholder = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 20)];
    placeholder.enabled = NO;
    placeholder.text = @"请输入";
    placeholder.font = [UIFont fontWithName:KFontHi size:15.0f];
    [_TextView addSubview:placeholder];
    [self.view addSubview:_TextView];
    
    _lblNUmber = [[UILabel alloc] initWithFrame:CGRectMake(20 + _TextView.frame.size.width - 60, _TextView.frame.size.height + 15 - 30, 60, 30)];
    _lblNUmber.text = @"200";
    _lblNUmber.textAlignment = NSTextAlignmentRight;
    _lblNUmber.textColor = TTRGBColor(204, 204, 204);
    [self.view addSubview:_lblNUmber];
}


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        placeholder.text = @"请输入";
    }
    else
    {
        placeholder.text = @"";
    }
    //该判断用于联想输入
    if (textView.text.length > 200)
    {
        textView.text = [textView.text substringToIndex:200];
        _lblNUmber.text = @"0";
        return;
    }
    _lblNUmber.text = [NSString stringWithFormat:@"%d",200 - (int)textView.text.length];

}

//键入Done时，插入换行符，然后执行addBookmark
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //判断加上输入的字符，是否超过界限
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > 200)
    {
        textView.text = [str substringToIndex:200];
         _lblNUmber.text =@"0";
        return NO;
    }
     _lblNUmber.text = [NSString stringWithFormat:@"%d",200 - (int)textView.text.length];
    return YES;
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

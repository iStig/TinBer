//
//  ForgetPassWordViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "ForgetPassWordViewController.h"

@interface ForgetPassWordViewController ()<UITextFieldDelegate>{
    UITextField *phoneNum;
    UITextField *mesCheck;
    UITextField *passWord;
    UITextField *confirmPW;
    NSTimer *timer;
    int timecounter;
    BOOL hasagreedpro;
    
    UIView * viewMain;
}

@end

@implementation ForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:@"忘记密码"];
    self.navigationItem.rightBarButtonItem = [self createNavBarBtnWithTitle:Kconfirm action:@selector(ResignNavgationRightButtonTouchup:)];
    [self initContentView];
    
    UITapGestureRecognizer * tapDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    [self.view addGestureRecognizer:tapDown];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden  = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigaBar"] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignKeyboard];
}

-(void)initContentView{
    viewMain = [[UIView alloc] initWithFrame:CGRectMake(0, 0,ScreenWhite, ScreenHeigth)];
    viewMain.backgroundColor = TTClearColor;
    [self.view addSubview:viewMain];
    float heigthIndex = 0;
    
//    //定义一个toolBar
//    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
//    
//    //设置style
//    [topView setBarStyle:UIBarStyleDefault];
//    [topView setBackgroundImage:[UIImage imageNamed:@"NavigaBar"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    
//    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
//    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    
//    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    
//    //定义完成按钮
//    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain  target:self action:@selector(resignKeyboard)];
//    doneButton.tintColor = TTWhiteColor;
//    
//    //在toolBar上加上这些按钮
//    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
//    [topView setItems:buttonsArray];
    
    heigthIndex =  15;
    
    //手机号
    UIView * viewPhone = [[UIView alloc] initWithFrame:CGRectMake(0, heigthIndex, ScreenWhite, 54)];
    viewPhone.backgroundColor = TTWhiteColor;
    [viewMain addSubview:viewPhone];
    
    UILabel * labelphone = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 64, 16.5)];
    labelphone.text = @"手机号";
    labelphone.font = [UIFont fontWithName:KFontHi size:16.0f];
    labelphone.textColor = TTRGBColor(153, 153, 153);
    labelphone.textAlignment = NSTextAlignmentRight;
    [viewPhone addSubview:labelphone];
    
    phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(94,18.5,ScreenWhite - 94 - 30,19)];
    [phoneNum setBorderStyle:UITextBorderStyleNone];
    phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNum.placeholder = @"手机号";
    phoneNum.font = [UIFont systemFontOfSize:16.0f];
    phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    phoneNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
    [phoneNum addTarget:self action:@selector(limitinputlength:) forControlEvents:UIControlEventEditingChanged];
    phoneNum.delegate = self;
    [viewPhone addSubview:phoneNum];
//    [phoneNum setInputAccessoryView:topView];
    
    heigthIndex = heigthIndex + 54 + 1;
    
    //校验码
    
    UIView * viewCheck = [[UIView alloc] initWithFrame:CGRectMake(0, heigthIndex, ScreenWhite, 54)];
    viewCheck.backgroundColor = TTWhiteColor;
    [viewMain addSubview:viewCheck];
    
    UILabel * labelCheck = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 64, 16.5)];
    labelCheck.text = @"校验码";
    labelCheck.font = [UIFont fontWithName:KFontHi size:16.0f];
    labelCheck.textColor = TTRGBColor(153, 153, 153);
    labelCheck.textAlignment = NSTextAlignmentRight;
    [viewCheck addSubview:labelCheck];
    
    mesCheck =  [[UITextField alloc] initWithFrame:CGRectMake(94,18.5,200,19)];
    [mesCheck setBorderStyle:UITextBorderStyleNone]; //外框类型
    mesCheck.secureTextEntry = NO;
    mesCheck.clearButtonMode = UITextFieldViewModeWhileEditing;
    mesCheck.placeholder = @"校验码";
    mesCheck.delegate = self;
    mesCheck.font = [UIFont systemFontOfSize:16.0f];
    mesCheck.keyboardType = UIKeyboardTypeNumberPad;
    mesCheck.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
//    [mesCheck setInputAccessoryView:topView];
    [mesCheck addTarget:self action:@selector(limitinputlength:) forControlEvents:UIControlEventEditingChanged];
    
    [viewCheck addSubview:mesCheck];
    
    UIButton *sendBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(ScreenWhite - 78, 11, 71, 32);
    sendBtn.tag = 111;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.layer.masksToBounds = YES;
    [sendBtn setBackgroundColor:TTRGBColor(244, 242, 241)];
    sendBtn.layer.cornerRadius = 18;
    [sendBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [sendBtn setTitleColor:TTRGBColor(249, 69, 61) forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendCheckNum:) forControlEvents:UIControlEventTouchUpInside];
    [viewCheck addSubview:sendBtn];
    
    heigthIndex = heigthIndex + 54 + 1;
    
    //密码
    
    UIView * viewpassWord = [[UIView alloc] initWithFrame:CGRectMake(0, heigthIndex, ScreenWhite, 54)];
    viewpassWord.backgroundColor = TTWhiteColor;
    [viewMain addSubview:viewpassWord];
    
    UILabel * labelpassWord = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 64, 16.5)];
    labelpassWord.text = @"密码";
    labelpassWord.font = [UIFont fontWithName:KFontHi size:16.0f];
    labelpassWord.textColor = TTRGBColor(153, 153, 153);
    labelpassWord.textAlignment = NSTextAlignmentRight;
    [viewpassWord addSubview:labelpassWord];
    
    passWord =  [[UITextField alloc] initWithFrame:CGRectMake(94,18.5,ScreenWhite - 94 - 30,19)];
    [passWord setBorderStyle:UITextBorderStyleNone]; //外框类型
    passWord.secureTextEntry = YES;
    passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWord.placeholder = @"密码:6-16位数字和字母组成";
    passWord.delegate = self;
    passWord.font = [UIFont systemFontOfSize:16.0f];
    passWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
//    [passWord setInputAccessoryView:topView];
    [passWord addTarget:self action:@selector(limitinputlength:) forControlEvents:UIControlEventEditingChanged];
    [viewpassWord addSubview:passWord];
    
    heigthIndex = heigthIndex + 54 + 1;
    
    //确认密码
    
    UIView * viewconfirmPW = [[UIView alloc] initWithFrame:CGRectMake(0, heigthIndex, ScreenWhite, 54)];
    viewconfirmPW.backgroundColor = TTWhiteColor;
    [viewMain addSubview:viewconfirmPW];
    
    UILabel * labelconfirmPW = [[UILabel alloc] initWithFrame:CGRectMake(15-6, 18.5, 70, 16.5)];
    labelconfirmPW.text = @"确认密码";
    labelconfirmPW.font = [UIFont fontWithName:KFontHi size:16.0f];
    labelconfirmPW.textColor = TTRGBColor(153, 153, 153);
    labelconfirmPW.textAlignment = NSTextAlignmentRight;
    [viewconfirmPW addSubview:labelconfirmPW];
    
    confirmPW =  [[UITextField alloc] initWithFrame:CGRectMake(94,18.5,ScreenWhite - 94 - 30,19)];
    [confirmPW setBorderStyle:UITextBorderStyleNone]; //外框类型
    confirmPW.secureTextEntry = YES;
    confirmPW.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmPW.placeholder = @"请再次输入密码";
    confirmPW.delegate = self;
    confirmPW.font = [UIFont systemFontOfSize:16.0f];
    confirmPW.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
//    [confirmPW setInputAccessoryView:topView];
    [confirmPW addTarget:self action:@selector(limitinputlength:) forControlEvents:UIControlEventEditingChanged];
    [viewconfirmPW addSubview:confirmPW];
    
    heigthIndex = heigthIndex + 54 + 1;
    
    //倒计时定时60s
    timecounter = 60;
    
}
//隐藏键盘
- (void)resignKeyboard {
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
//    viewMain.frame = rect;
//    [UIView commitAnimations];
    [phoneNum resignFirstResponder];
    [mesCheck resignFirstResponder];
    [passWord resignFirstResponder];
    [confirmPW resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)field
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    [field resignFirstResponder];
    return YES;
}
//发送校验码
-(void)sendCheckNum:(UIButton *)sender
{
    
    //判断手机号是否为空
    if (phoneNum.text.length == 0){
        TTAlert(@"请输入手机号");
        if (timer) {
            [timer setFireDate:[NSDate distantFuture]];
        }
        [sender setTitle:@"发送" forState:UIControlStateNormal];
        return;
    }
    
    [sender setTitle:@"发送中..." forState:UIControlStateNormal];
    //请求服务器接口
    //    [[MOYUNService sharedMOYUNService] pushSMSCodeByMobile:phoneNum.text andSendType:@"1" Special:^(BOOL success) {
    
    //开始倒计时
    timecounter = 60;
    [sender setTitle:[NSString stringWithFormat:@"%d秒",timecounter] forState:UIControlStateNormal];
    
    //启动定时器
    if (!timer){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    }
    else {
        [timer setFireDate:[NSDate date]];
    }
    //    } faild:^(NSDictionary *errorDic) {
    //        //复原按钮标题
    //        UIButton *button = (UIButton *)[self.view viewWithTag:111];
    //        [button setTitle:@"发送验证码" forState:UIControlStateNormal];
    //        [PXAlertView showAlertWithTitle:@""
    //                                message:[errorDic objectForKey:@"returnDesc"]
    //                            cancelTitle:@"确定"
    //                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
    //                             }];    }];
    //
}

//发送校验码倒计时
-(void)countdown
{
    if (timecounter == 0){
        //暂停计时器
        [timer setFireDate:[NSDate distantFuture]];
        UIButton *button = (UIButton *)[self.view viewWithTag:111];
        [button setTitle:@"发送" forState:UIControlStateNormal];
        button.frame = CGRectMake(ScreenWhite - 78, 11, 71, 32);
        
        //复位
        timecounter = 60;
    }
    else{
        timecounter--;
        UIButton *button = (UIButton *)[self.view viewWithTag:111];
        NSString *message = [NSString stringWithFormat:@"%d秒后发送",timecounter];
        [button setTitle:message forState:UIControlStateNormal];
        button.frame = CGRectMake(ScreenWhite - 108, 11, 101, 32);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)field
{
    //    CGRect frame = field.frame;
    //    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 220.0);//键盘高度216
//    int offset = 340 - (self.view.frame.size.height - 270.0);//键盘高度216
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    if(offset > 0)
//    {
//        CGRect rect = CGRectMake(0.0f, -offset,width,height);
//        viewMain.frame = rect;
//    }
//    [UIView commitAnimations];
}

//限制输入长度
-(void)limitinputlength:(UITextField *)sender
{
    NSString *string = sender.text;
    int length;
    if (sender == passWord||sender == confirmPW)
    {
        length = 16;
    }
    else
    {
        length = 11;
    }
    
    if (string.length>length) {
        sender.text = [string substringToIndex:length];
    }
    
    
}

//提交注册
-(void)ResignNavgationRightButtonTouchup:(id)sender
{
    
    //判断是否是合法的手机号
    NSString *regex = PHONE_Regex;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum.text];
    if (!isMatch) {
        TTAlert(@"手机号不合法");
        return;
    }
    
    //判断校验码是否为空
    if (mesCheck.text.length == 0) {
        TTAlert(@"校验码不能为空");
        return;
        
    }
    
    //判断两次密码输入是否一致
    if (![passWord.text isEqualToString:confirmPW.text]) {
        TTAlert(@"两次输入的密码不一致");
        return;
    }
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(backToParrentViewController) userInfo:nil repeats:NO];
    
}
-(void)backToParrentViewController
{
    //销毁计时器
    if (timer){
        [timer invalidate];
        timer = nil;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

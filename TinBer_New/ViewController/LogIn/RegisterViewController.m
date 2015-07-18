
//
//  RegisterViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserProtocalViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UITextField *phoneNum;
    UITextField *mesCheck;
    UITextField *passWord;
    UITextField *confirmPW;
    UITextField * NeiChen;
    NSTimer *timer;
    int timecounter;
    BOOL hasagreedpro;
    
    UIImageView * _imageVHeard;
    
    UIView * viewMain;
    BOOL hasCamaraDevice;
    UIAlertController * alertContrl;
    NSArray * arydata;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:@"注册"];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [self createNavBarBtnWithTitle:Kconfirm action:@selector(ResignNavgationRightButtonTouchup:)];
    
    arydata = [NSArray arrayWithObjects:@"上海",@"广州",@"深圳",@"北京",@"天津",@"南京", nil];
    [self initContentView];
    
    UITapGestureRecognizer * tapDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    [self.view addGestureRecognizer:tapDown];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden  = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigaBar"] forBarMetrics:UIBarMetricsDefault];
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
    
    //头像
    UIView * viewHeard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, 90)];
    viewHeard.backgroundColor = TTRGBColor(249, 69, 61);
    
    [viewMain addSubview:viewHeard];
    
    UIImageView  * imageVHeardB = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWhite-75)/2, 0, 75, 75)];
    imageVHeardB.image = [UIImage imageNamed:@"headbord"];
    imageVHeardB.userInteractionEnabled = YES;
    [viewHeard addSubview:imageVHeardB];
    
    _imageVHeard = [[UIImageView alloc] initWithFrame:CGRectMake(imageVHeardB.frame.origin.x + 2, 3, 70, 70)];
    _imageVHeard.userInteractionEnabled = YES;
    [[_imageVHeard layer]setCornerRadius:35];
    [[_imageVHeard layer]setMasksToBounds:YES];
    [[_imageVHeard layer]setBorderColor:[[UIColor clearColor] CGColor]];
    [viewHeard addSubview:_imageVHeard];
    
    UIImageView * imagePen = [[UIImageView alloc] initWithFrame:CGRectMake(imageVHeardB.frame.origin.x + 53, 52, 26, 26)];
    imagePen.image = [UIImage imageNamed:@"photoPen"];
    imagePen.userInteractionEnabled = YES;
    [viewHeard addSubview:imagePen];
    
    UITapGestureRecognizer * tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickHeardviewChangephoto:)];
    [_imageVHeard addGestureRecognizer:tapGest];
    
    heigthIndex = heigthIndex + 90 + 15;
    
    // 昵称
    UIView * viewNeiChen = [[UIView alloc] initWithFrame:CGRectMake(0, heigthIndex, ScreenWhite, 54)];
    viewNeiChen.backgroundColor = TTWhiteColor;
    [viewMain addSubview:viewNeiChen];
    
    UILabel * labelNeiChen = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 64, 16.5)];
    labelNeiChen.text = @"昵称";
    labelNeiChen.font = [UIFont fontWithName:KFontHi size:16.0f];
    labelNeiChen.textColor = TTRGBColor(153, 153, 153);
    labelNeiChen.textAlignment = NSTextAlignmentRight;
    [viewNeiChen addSubview:labelNeiChen];
    
    NeiChen = [[UITextField alloc] initWithFrame:CGRectMake(94,18.5,200,19)];
    [NeiChen setBorderStyle:UITextBorderStyleNone];
    NeiChen.clearButtonMode = UITextFieldViewModeWhileEditing;
    NeiChen.placeholder = @"昵称";
    NeiChen.font = [UIFont systemFontOfSize:16.0f];
    NeiChen.keyboardType = UIKeyboardTypeDefault;
//    [NeiChen setInputAccessoryView:topView];
    NeiChen.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
    [NeiChen addTarget:self action:@selector(limitinputlength:) forControlEvents:UIControlEventEditingChanged];
    NeiChen.delegate = self;
    [viewNeiChen addSubview:NeiChen];
    
    heigthIndex = heigthIndex + 54 + 1;
    
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
    
    phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(94,18.5,200,19)];
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
    
    sendBtn.tag = 111;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(ScreenWhite - 78, 11, 71, 32);
    [sendBtn setTitleColor:TTRGBColor(249, 69, 61) forState:UIControlStateNormal];
    [sendBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [sendBtn addTarget:self action:@selector(sendCheckNum:) forControlEvents:UIControlEventTouchUpInside];
    [viewCheck addSubview:sendBtn];
    
    [sendBtn setBackgroundColor:TTRGBColor(244, 242, 241)];
    sendBtn.layer.masksToBounds = YES;
    
    sendBtn.layer.cornerRadius = 18;
    
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
    
    passWord =  [[UITextField alloc] initWithFrame:CGRectMake(94,18.5,200,19)];
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
    
    confirmPW =  [[UITextField alloc] initWithFrame:CGRectMake(94,18.5,200,19)];
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
    
    //所在地
    UIView * viewCity = [[UIView alloc] initWithFrame:CGRectMake(0, heigthIndex, ScreenWhite, 54)];
    viewCity.backgroundColor = TTWhiteColor;
    [viewMain addSubview:viewCity];
    
    UILabel * labelCity = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 64, 16.5)];
    labelCity.text = @"所在地";
    labelCity.font = [UIFont fontWithName:KFontHi size:16.0f];
    labelCity.textColor = TTRGBColor(153, 153, 153);
    labelCity.textAlignment = NSTextAlignmentRight;
    [viewCity addSubview:labelCity];
    
    UITapGestureRecognizer * tapGestCity = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CickSelectCity:)];
    [viewCity addGestureRecognizer:tapGestCity];
    
    heigthIndex = heigthIndex + 54 + 8;
    
    
    //倒计时定时60s
    timecounter = 60;
    
    //用户协议条款
    UIView * viewagree = [[UIView alloc] initWithFrame:CGRectMake(ScreenWhite -118, heigthIndex, 111, 25)];
    viewagree.backgroundColor = TTClearColor;
    [viewMain addSubview:viewagree];
    
    UIButton *agree = [UIButton buttonWithType:UIButtonTypeCustom];
    agree.backgroundColor = [UIColor whiteColor];
    agree.frame = CGRectMake(5,5, 14, 14);
    [agree setBackgroundImage:[UIImage imageNamed:@"Checkmark"] forState:UIControlStateNormal];
    [agree setBackgroundImage:[UIImage imageNamed:@"37x-Checkmark.png"] forState:UIControlStateSelected];
    [agree addTarget:self action:@selector(hasagreed:) forControlEvents:UIControlEventTouchUpInside];
    [agree setSelected:YES];
    [viewagree addSubview:agree];
    
    UIButton *userpro = [UIButton buttonWithType:UIButtonTypeCustom];
    userpro.frame = CGRectMake(27, 4, 84, 15);
    [userpro setTitle:@"同意用户协议" forState:UIControlStateNormal];
    userpro.titleLabel.font = [UIFont systemFontOfSize:14];
    [userpro setTitleColor:TTRGBColor(249, 69, 61) forState:UIControlStateNormal];
    [userpro addTarget:self action:@selector(jumptopro) forControlEvents:UIControlEventTouchUpInside];
    userpro.backgroundColor = TTClearColor;
    [viewagree addSubview:userpro];
    //初始化是否同意用户协议
    hasagreedpro = YES;
}


-(void)ClickHeardviewChangephoto:(UITapGestureRecognizer *)TopGest{
    [self changePersonalHeard];
}

-(void)CickSelectCity:(UITapGestureRecognizer *)TopGest{
    [self setPickview];
    
    [self setAnimation:-80];
}


-(void)setAnimation:(float)framey{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0,framey, self.view.frame.size.width, self.view.frame.size.height);
    viewMain.frame = rect;
    [UIView commitAnimations];
}

//隐藏键盘
- (void)resignKeyboard {
    [self setAnimation:0];
    
    [phoneNum resignFirstResponder];
    [mesCheck resignFirstResponder];
    [passWord resignFirstResponder];
    [confirmPW resignFirstResponder];
    [NeiChen resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)field
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    [self setAnimation:0];
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

    int offset = 340 - (self.view.frame.size.height - 270.0);//键盘高度216
    
    [self setAnimation:-offset];
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
    
    //判断是否同意用户协议
    if (hasagreedpro == NO) {
        TTAlert(@"请先同意用户协议");
        return;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(backToParrentViewController) userInfo:nil repeats:NO];
//    //提交注册信息
//    loadingview = [[TVLoadingView alloc] initWithFrame:CGRectMake(0,0, 119, 85)];
//    [loadingview setCenter:self.view.center];
//    [loadingview settext:@"提交中...."];
//    UIWindow *window = [TVAppDelegate sharedAppDelegate].window;
//    [window addSubview:loadingview];
//    NSArray *Info = [NSArray arrayWithObjects:phoneNum.text,mesCheck.text,passWord.text, nil];
//    [[MOYUNService sharedMOYUNService] userRegister:Info Special:^(NSDictionary * success) {
//        [loadingview removeFromSuperview];
//        loadingview = nil;
//        HUD = [[MBProgressHUD alloc]initWithView:self.view];
//        [self.view addSubview:HUD];
//        __block UIImageView *imageView;
//        UIImage *image =  ImageNamed(@"37x-Checkmark.png");
//        imageView = [[UIImageView alloc] initWithImage:image];
//        HUD.customView = imageView;
//        HUD.mode = MBProgressHUDModeCustomView;
//        HUD.labelText = @"注册成功";
//        [HUD hide:YES afterDelay:2];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginReloadWeb" object:nil];
//        if ([success objectForKey:@"hongbao"]) { //注册送红包
//            NSString * score = [[success objectForKey:@"hongbao"] objectForKey:@"score"];
//            UIView *bgview = [[UIView alloc] initWithFrame:self.view.frame];
//            bgview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//            bgview.tag = 999;
//            [[TVAppDelegate sharedAppDelegate].window addSubview:bgview];
//            
//            TVHongBaoView * view = [[TVHongBaoView alloc] initWithFrame:CGRectMake(34,-420, 253, 419) score:score andADDic:nil];
//            view.delegate = self;
//            [bgview addSubview:view];
//            CGPoint point = view.center;
//            CGFloat f = iPhone5?290:240;
//            [self showPopWithPopView:view showPosition:CGSizeMake(point.x, f)];
//        }else{
//            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(backToParrentViewController) userInfo:nil repeats:NO];
//        }
//    } faild:^(NSDictionary *errorDic) {
//        [loadingview removeFromSuperview];
//        loadingview = nil;
//        [PXAlertView showAlertWithTitle:@""
//                                message:[errorDic objectForKey:@"returnDesc"]
//                            cancelTitle:@"确定"
//                             completion:^(BOOL cancelled, NSInteger buttonIndex) {
//                             }];
//    }];
    
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

#pragma mark--是否同意
-(void)hasagreed:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
    hasagreedpro = !hasagreedpro;
}
#pragma mark--跳转用户协议
-(void)jumptopro
{
    UserProtocalViewController *userpro = [[UserProtocalViewController alloc]init];
    [self.navigationController pushViewController:userpro animated:YES];
    
}

#pragma mark -- 更换头像
-(void)changePersonalHeard{
    //判断是否有摄像头
    hasCamaraDevice = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (hasCamaraDevice) {
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"请选择图片来源:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机拍摄",@"相册选择", nil];
        [actionSheet showInView:self.view];
        actionSheet.tag=60;
    }else{
        [self selImageByPhoto];
    }
    
}
//从相册选择图片
-(void)selImageByPhoto
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;// 设置代理
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:NULL];
}

//摄像头拍摄图片
-(void)selImageByShoot
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
    [picker setDelegate:self];
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:NULL];
    
    //设置判断属性是否要保存到图册
    //    fromShootImageOrVideo = YES;
}

#pragma mark--actionsheetdelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self selImageByShoot];
            break;
        case 1:
            [self selImageByPhoto];
            break;
        default:
            break;
    }
    
}


#pragma mark-imagepickerdelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"editing info");
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey: UIImagePickerControllerEditedImage];
    //当前图片数据
    NSData *data = UIImageJPEGRepresentation(_imageVHeard.image, 0.5);
    //选取图片数据
    //UIImage *select = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *data1 = UIImageJPEGRepresentation(image, 0.5);
    //判断图片是否改变
    if (![data isEqualToData:data1]) {
        //        isheadimgchanged = YES;
        NSLog(@"换头像了");
    }
    _imageVHeard.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)setPickview{
    alertContrl = [UIAlertController alertControllerWithTitle:nil
                                                  message:@"\n\n\n\n\n\n\n\n\n\n\n"// change UIAlertController height
                                           preferredStyle:UIAlertControllerStyleActionSheet];
    alertContrl.view.backgroundColor=[UIColor whiteColor];

    UINavigationBar *ba = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, 44)];
    [ba setBackgroundImage:[UIImage imageNamed:@"NavigaBar"] forBarMetrics:UIBarMetricsDefault];
    [alertContrl.view addSubview:ba];

    UINavigationItem *nav = [[UINavigationItem alloc] init];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:kCancel style:UIBarButtonItemStylePlain target:self action:@selector(pickerHideCancel:)];
    left.tintColor = TTWhiteColor;
    nav.leftBarButtonItem = left;
    [ba pushNavigationItem:nav animated:YES];


    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:Kconfirm style:UIBarButtonItemStyleDone target:self action:@selector(pickerHideOK:)];
    right.tintColor = TTWhiteColor ;
    nav.rightBarButtonItem = right;

    [ba pushNavigationItem:nav animated:YES];

    CGRect pickerFrame = CGRectMake(0, 44, ScreenWhite, 200);
    UIPickerView *picktype=[ [UIPickerView alloc] initWithFrame:pickerFrame];
    picktype.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    picktype.showsSelectionIndicator = YES;
    picktype.delegate=self;
    picktype.dataSource=self;
    picktype.hidden = NO;
    [alertContrl.view addSubview:picktype];

    [self presentViewController:alertContrl animated:NO completion:nil];
}

#pragma mark 处理PickView的选择结果

-(void)pickerHideCancel:(UIBarButtonItem *)item
{
    [self setAnimation:0];
    [alertContrl dismissViewControllerAnimated:YES completion:nil];
}

-(void)pickerHideOK:(UIBarButtonItem *)item
{
    [self setAnimation:0];
    [alertContrl dismissViewControllerAnimated:YES completion:nil];
    
    [self SelectValue:nil withtag:item.tag];
    
    
}
-(void)SelectValue:(NSDictionary *)dic withtag:(NSInteger)sender
{
    
}

-(void)SaveForSqlite{
    
}


#pragma mark UIPickerViewDelegate
#pragma mark -
#pragma mark
//选项默认值
-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    if (component==1)
    {
        
        
    }
}


// 返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
    
}
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arydata count];
    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel * labtitile=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWhite, 30)];
    labtitile.backgroundColor=[UIColor clearColor];
    //[labtitile setFont:[UIFont systemFontOfSize:16.0]];
    [labtitile setFont:[UIFont boldSystemFontOfSize:16.0f]];
    labtitile.textAlignment=NSTextAlignmentCenter;
    labtitile.text=[arydata objectAtIndex:row];
    [labtitile sizeToFit];
    return labtitile;
}



//UIpickview 设置的值
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    [self SelectPickIndex:[arydata objectAtIndex:row]];
}


-(void)SelectPickIndex:(NSDictionary *)dic
{
}


@end

//
//  AddressViewController.m
//  TinBer_New
//
//  Created by shentingting on 15/7/7.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIScrollView * scrollview;
    
    UILabel * placeholder;
    UITextView * _TextView;
    UIAlertController *alertContrl;
    
    NSArray * arydata;
}

@end

@implementation AddressViewController
@synthesize strReturn = _strReturn,strtitle = _strtitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftbuttonImage:@"IconBack"];
    [self setTopTitle:_strtitle];
    [self initMain];
}

-(void)initMain{
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, ScreenHeigth)];
    scrollview.backgroundColor = TTClearColor;
    [self.view addSubview:scrollview];
    
    arydata = [NSArray arrayWithObjects:@"上海",@"广州",@"深圳",@"北京",@"天津",@"南京", nil];
    
    NSArray * ary1 = [NSArray arrayWithObjects:@[@"收件人",@"您的姓名"],@[@"手机号码",@"您的手机号码"], nil];
    
    float height = 15;
    for (int i =0;  i < 2; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, height, ScreenWhite, 54)];
        view.tag = 10 + i;
        view.backgroundColor = TTWhiteColor;
        [scrollview addSubview:view];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 93, 16)];
        label.textColor = TTRGBColor(93, 93, 93);
        label.text = [[ary1 objectAtIndex:i] objectAtIndex:0];
        label.font = [UIFont fontWithName:KFontHi size:16.0f];
        [view addSubview:label];
        
        UITextField * _textFild= [[UITextField alloc] initWithFrame:CGRectMake(112, 18.5, 180, 16)];
        _textFild.backgroundColor = TTClearColor;
        _textFild.textColor = TTRGBColor(93, 93, 93);
        _textFild.borderStyle = UITextBorderStyleNone;
        _textFild.returnKeyType = UIReturnKeyDone;
        _textFild.font = [UIFont fontWithName:KFontHi size:16.0f];
        _textFild.tag = 15+ i;
        _textFild.delegate = self;
        _textFild.placeholder = [[ary1 objectAtIndex:i] objectAtIndex:1];
        [view addSubview:_textFild];
        
        height = height + 54 + 1;
    }
    
    NSArray * ary2 = [NSArray arrayWithObjects:@[@"省",@"省"],@[@"市",@"市"],@[@"区",@"区"], nil];
    
    for (int i =0;  i < 3; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, height, ScreenWhite, 54)];
        view.backgroundColor = TTWhiteColor;
        view.tag = 20 + i;
        [scrollview addSubview:view];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 93, 16)];
        label.textColor = TTRGBColor(93, 93, 93);
        label.text = [[ary2 objectAtIndex:i] objectAtIndex:0];
        label.font = [UIFont fontWithName:KFontHi size:16.0f];
        [view addSubview:label];
        
        UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(112, 18.5, 180, 16)];
        labelText.textColor = TTRGBColor(204, 204, 204);
        labelText.text = [[ary2 objectAtIndex:i] objectAtIndex:1];
        labelText.font = [UIFont fontWithName:KFontHi size:16.0f];
        labelText.tag = 25+ i;
        [view addSubview:labelText];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(112, 0, 180, 54)];
        [btn setBackgroundColor:TTClearColor];
        [btn setTag:30+ i];
        [btn addTarget:self action:@selector(ClickCityBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
        
        height = height + 54 + 1;
    }
    
    NSArray * ary3 = [NSArray arrayWithObjects:@"详细地址",@"填写详细地址", nil];
    UIView * ViewAddress = [[UIView alloc] initWithFrame:CGRectMake(0, height, ScreenWhite, 130)];
    ViewAddress.backgroundColor = TTWhiteColor;
    [scrollview addSubview:ViewAddress];
    
    UILabel * labelAD= [[UILabel alloc] initWithFrame:CGRectMake(15, 18.5, 93, 16)];
    labelAD.textColor = TTRGBColor(93, 93, 93);
    labelAD.text = [ary3 objectAtIndex:0];
    labelAD.font = [UIFont fontWithName:KFontHi size:16.0f];
    [ViewAddress addSubview:labelAD];
    
    _TextView = [[UITextView alloc] initWithFrame:CGRectMake(108, 8, 248, 96)];
    _TextView.backgroundColor = TTClearColor;
    _TextView.tintColor = TTRGBColor(249, 69, 61);
    _TextView.returnKeyType = UIReturnKeyDone;
//    _TextView.text = @"填写详细地址";
    _TextView.font = [UIFont systemFontOfSize:16.0f];
    _TextView.delegate = self;
    
    placeholder = [[UILabel alloc]initWithFrame:CGRectMake(4, 9, 180, 20)];
//    placeholder.enabled = NO;
    placeholder.text = [ary3 objectAtIndex:1];
    placeholder.textColor = TTRGBColor(204, 204, 204);
    placeholder.font = [UIFont fontWithName:KFontHi size:16.0f];
    [_TextView addSubview:placeholder];
    [ViewAddress addSubview:_TextView];
    
    height = height + 130 + 25;
    
    NSString * strbtn = nil;
    if (_strReturn.length ) {
        strbtn = _strReturn;
    }else {
        strbtn = Kconfirm;
    }
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(15, height, 345, 44)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"RectangleYellow"] forState:UIControlStateNormal];
    [btn1 setTitle:strbtn forState:UIControlStateNormal];
    [btn1 setTitleColor:TTWhiteColor forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont fontWithName:KFontHi size:17.0f];
    [btn1 addTarget:self action:@selector(SaveForSqlite) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btn1];
    
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    //注册通知,监听键盘出现
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(handleKeyboardDidShow:)
//                                                name:UIKeyboardDidShowNotification
//                                              object:nil];
//    //注册通知，监听键盘消失事件
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(handleKeyboardDidHidden)
//                                                name:UIKeyboardDidHideNotification
//                                              object:nil];
//}
//
////监听事件
//- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
//{
//    //获取键盘高度
//    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
//    
//    CGRect keyboardRect;
//    [keyboardRectAsObject getValue:&keyboardRect];
//    
//    _TextView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
//}
//
//- (void)handleKeyboardDidHidden
//{
//    _TextView.contentInset=UIEdgeInsetsZero;
//}

-(void)setPickview{
    
    [_TextView resignFirstResponder];
    for (int i = 0; i < 2; i++) {
        
        UIView * view = (UIView *)[scrollview viewWithTag:10+ i];
        UITextField * _textFild = (UITextField *)[view viewWithTag:15+i];
        [_textFild resignFirstResponder];
    }
    alertContrl = [UIAlertController alertControllerWithTitle:nil
                                                      message:@"\n\n\n\n\n\n\n\n\n\n\n"// change UIAlertController height
                                               preferredStyle:UIAlertControllerStyleActionSheet];
    alertContrl.view.backgroundColor=[UIColor whiteColor];
    
    UINavigationBar *ba = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, 44)];
//    ba.barStyle = UIBarStyleBlackTranslucent;
//    ba.backgroundColor = TTRGBColor(244, 69, 61);
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

    [alertContrl dismissViewControllerAnimated:YES completion:nil];
    if (scrollview.frame.origin.y != 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2f];
        scrollview.frame =   CGRectMake(0, 0, ScreenWhite, ScreenHeigth-64);
        [UIView commitAnimations];
    }
}

-(void)pickerHideOK:(UIBarButtonItem *)item
{
    [alertContrl dismissViewControllerAnimated:YES completion:nil];

    [self SelectValue:nil withtag:item.tag];
    
    if (scrollview.frame.origin.y != 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2f];
        scrollview.frame =   CGRectMake(0, 0, ScreenWhite, ScreenHeigth-64);
        [UIView commitAnimations];
    }
}
-(void)SelectValue:(NSDictionary *)dic withtag:(NSInteger)sender
{
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    [_TextView resignFirstResponder];
    for (int i = 0; i < 2; i++) {
        
        UIView * view = (UIView *)[scrollview viewWithTag:10+ i];
        UITextField * _textFild = (UITextField *)[view viewWithTag:15+i];
        [_textFild resignFirstResponder];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)SaveForSqlite{
    
}

-(void)ClickCityBtn:(id)sender{
    [self setPickview];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        placeholder.text = @"填写详细地址";
    }
    else
    {
        placeholder.text = @"";
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2f];
    scrollview.frame =   CGRectMake(0, -100, ScreenWhite, ScreenHeigth-64);
    [UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    if ([text isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [textView resignFirstResponder];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.2f];
        scrollview.frame =   CGRectMake(0, 0, ScreenWhite, ScreenHeigth-64);
        [UIView commitAnimations];
        return NO;
    }
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

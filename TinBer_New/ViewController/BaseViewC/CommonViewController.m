//
//  CommonViewController.m
//  BoYou
//
//  Created by fanshan on 13-9-6.
//  Copyright (c) 2013年 xbwu. All rights reserved.
//

#import "CommonViewController.h"
#import "TabbarViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController
@synthesize navBarBgImage = _navBarBgImage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = TTRGBColor(238, 238, 238);
    
    [self initCustomNavigationView];
	// Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBackgroundImage:self.navBarBgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)initCustomNavigationView
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _customTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _customTitleLabel.userInteractionEnabled = NO;
    _customTitleLabel.font = [UIFont systemFontOfSize:15];
    _customTitleLabel.textAlignment = NSTextAlignmentCenter;
    _customTitleLabel.textColor = TTBlackColor;
    _customTitleLabel.backgroundColor = [UIColor clearColor];
    _customTitleLabel.userInteractionEnabled = YES;
    
    self.navigationItem.titleView = _customTitleLabel;
}

- (void)setTopTitle:(NSString *)strTitle {
    _customTitleLabel.text = strTitle;
    
    if (strTitle.length >23) {
        _customTitleLabel.frame=CGRectMake(45, 0, 230, 47);
        _customTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
}

-(void)setLeftbuttonImage:(NSString* )strImage{
    self.navigationItem.leftBarButtonItem = [self createNavBarBtn:@"IconBack.png" action:@selector(ResignNavgationLeftButtonTouchup:)];
}


-(void)ResignNavgationLeftButtonTouchup:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)createNavBarBtn:(NSString *)imageName action:(SEL)selector
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width + 5, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, (bgView.frame.size.height - image.size.height)/2, image.size.width, image.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    [bgView addSubview:btn];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    return barBtn;
}


- (void)showTabBarView
{
//    TabbarViewController *tabBarVC = (TabbarViewController *)self.tabBarController;
//    tabBarVC.customTabbar.hidden = NO;
//    self.hidesBottomBarWhenPushed = NO;
//    [tabBarVC.view bringSubviewToFront:tabBarVC.customTabbar];
}

- (void)hiddenTabBarView
{
//    TabbarViewController *tabBarVC = (TabbarViewController *)self.tabBarController;
//    tabBarVC.customTabbar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
}


@end

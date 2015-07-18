//
//  TabbarViewController.m
//  Maybelline
//
//  Created by gongxuehan on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TabbarViewController.h"
#import "AppDelegate.h"

@interface TabbarViewController()

- (void)showAccessoryView:(BOOL)isShow;

@end

@implementation TabbarViewController
@synthesize customTabbar = _customTabbar;
//@synthesize accessoryContent = _accessoryContent;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (id)initWithControllers:(NSArray *)controllers
{
    self = [super init];
    if (self)
    {
        _viewControllers = [[NSArray alloc] initWithArray:controllers];
        self.viewControllers = controllers;
    }
    return self;
}

- (void)viewDidLoad
{

//    for (UIView *view in [self.view subviews])
//    {
//        if ([view isKindOfClass:[UITabBar class]])
//        {
//            [view removeFromSuperview];
//        }
//        else if ([view isKindOfClass:[UIImageView class]])
//        {
//        
//        }
//        else 
//        {
////            view.frame = CGRectMake(0, 100, 320, 500);
//        }
//        view.backgroundColor = TTRedColor;
//    }
    float screenHeight = ScreenHeigth;
    _customTabbar = [[CustomTabbarView alloc] initWithFrame:CGRectMake(0, screenHeight - 49, 320, 49)];
    _customTabbar.delegate = self;
    _customTabbar.backgroundColor = TTWhiteColor;
    [self.view addSubview:_customTabbar];
//    
//    //Cover view
//    CGRect frame = self.view.frame;
//    frame.size.height -= self.tabBar.frame.size.height;
//    _coverView = [[UIView alloc] initWithFrame:frame];
//    [self.view addSubview:_coverView];
//
//    _accessoryView = [[UIImageView alloc] initWithFrame:CGRectZero];
//    [_coverView addSubview:_accessoryView];
    
    [self showAccessoryView:NO];
}

- (void)loadPreviewImage:(SInt32)index
{
    return;
    UIImage *img = [UIImage imageNamed:[_accessoryContent objectAtIndex:index]];
    if (img)
    {
        CGRect frame = CGRectZero;
        frame.size = img.size;
        _accessoryView.frame = frame;
        _accessoryView.center = self.view.center;
        _accessoryView.image = img;
    }
}

- (void)setAccessoryContent:(NSArray *)accessoryContent
{
    if (!_accessoryContent)
    {
        _accessoryContent = [[NSMutableArray alloc] initWithCapacity:[accessoryContent count]];
    }
    
    [_accessoryContent removeAllObjects];
    if ([accessoryContent count])
    {
        [_accessoryContent addObjectsFromArray:accessoryContent];
    }
}

- (void)showAccessoryView:(BOOL)isShow
{
    [_accessoryView setHidden:!isShow];
    [_coverView setHidden:!isShow];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [_viewControllers release];
    [_accessoryView release];
    [_coverView release];
    [_accessoryContent release];
    [_customTabbar release];
    [super dealloc];
}

#pragma mark -CustomTabbarView Method-
- (void)touchesBeganAt:(SInt32)index
{
//    [self loadPreviewImage:index];
}

- (void)tabbarIsMovedFrom:(SInt32)oldIndex to:(SInt32)curIndex
{
//    [self showAccessoryView:YES];
//    [self loadPreviewImage:curIndex];
}

- (void)tabbarIsEndedAt:(SInt32)curIndex
{
    if (curIndex != self.selectedIndex) {
        if ([self.delegate respondsToSelector:@selector(tabBarController: shouldSelectViewController:)]) {
            if ([self.delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:curIndex]]) {
            }
        }

        [self loadPreviewImage:curIndex];
        self.selectedIndex = curIndex;
        [self showAccessoryView:NO];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

// New Autorotation support.
- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end

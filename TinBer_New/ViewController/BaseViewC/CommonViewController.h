//
//  CommonViewController.h
//  BoYou
//
//  Created by fanshan on 13-9-6.
//  Copyright (c) 2013年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonViewController : UIViewController
{
    UIImage *_navBarBgImage;
    UILabel * _customTitleLabel;
}
@property (nonatomic,retain)UIImage *navBarBgImage;

- (UIBarButtonItem *)createNavBarBtn:(NSString *)imageName action:(SEL)selector;
- (UIBarButtonItem *)createNavBarBtnWithTitle:(NSString *)Title action:(SEL)selector;
- (void)setTopTitle:(NSString *)strTitle ;
-(void)setLeftbuttonImage:(NSString* )strImage;

- (void)showTabBarView;
- (void)hiddenTabBarView;

@end

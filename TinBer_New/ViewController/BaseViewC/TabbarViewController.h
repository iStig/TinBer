//
//  TabbarViewController.h
//  Maybelline
//
//  Created by gongxuehan on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabbarView.h"

@interface TabbarViewController : UITabBarController <CustomTabbarViewDelegate>
{
    NSMutableArray      *_items;
    CustomTabbarView    *_customTabbar;
    
    NSArray             *_viewControllers;
    UIView              *_coverView;
    UIImageView         *_accessoryView;
    NSMutableArray      *_accessoryContent;
}
@property (nonatomic,retain) CustomTabbarView    *customTabbar;
- (id)initWithControllers:(NSArray *)controllers;
- (void)setAccessoryContent:(NSArray *)accessoryContent;

@end

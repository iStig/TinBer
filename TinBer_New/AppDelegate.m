//
//  AppDelegate.m
//  TinBer_New
//
//  Created by shentingting on 15/7/6.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "ActiviesHomeViewController.h"
#import "ShakeViewController.h"
#import "ListenViewController.h"
#import "PrizeViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self mainViewController];
    
    NSLog(@"%@",NSStringFromCGSize(self.window.frame.size));
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)mainViewController {
    
    ActiviesHomeViewController *eivc = [[ActiviesHomeViewController alloc] init];
    UINavigationController *tabOne = [[UINavigationController alloc] initWithRootViewController:eivc];
    tabOne.navigationBar.tintColor = [UIColor blackColor];
    
    ShakeViewController *ervc = [[ShakeViewController alloc] init];
    UINavigationController *tabTwo = [[UINavigationController alloc] initWithRootViewController:ervc];
    tabTwo.navigationBar.tintColor = [UIColor blackColor];
    
    ListenViewController *tvc = [[ListenViewController alloc] init];
    UINavigationController *tabThree = [[UINavigationController alloc] initWithRootViewController:tvc];
    tabThree.navigationBar.tintColor = [UIColor blackColor];
    
    PrizeViewController *qvc = [[PrizeViewController alloc] init];
    UINavigationController *tabFour = [[UINavigationController alloc] initWithRootViewController:qvc];
    tabFour.navigationBar.tintColor = [UIColor blackColor];
    
    MineViewController * mineVc = [[MineViewController alloc] init];
    UINavigationController *tabFive = [[UINavigationController alloc] initWithRootViewController:mineVc];
    tabFive.navigationBar.tintColor = [UIColor blackColor];
    
     TabbarViewController *tabbarViewController = [[TabbarViewController alloc] initWithControllers:[NSArray arrayWithObjects:tabOne,tabTwo,tabThree,tabFour,tabFive,nil]];
    
    self.window.rootViewController = tabbarViewController;
    [tabbarViewController.customTabbar selectedItemFrom:-1 to:0];
    tabbarViewController.delegate = self;
    
    NSLog(@"window frame %@", NSStringFromCGSize(self.window.frame.size) );
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    UINavigationController *nav = (UINavigationController *)viewController;
//    if ([[nav.viewControllers objectAtIndex:0] respondsToSelector:@selector(reNew)]) {
//        [[nav.viewControllers objectAtIndex:0] reNew];
//    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

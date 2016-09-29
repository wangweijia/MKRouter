//
//  AppDelegate.m
//  MKRouterDemo
//
//  Created by xmk on 16/9/27.
//  Copyright © 2016年 mk. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarCtlMgr.h"
#import "MKRouterConst.h"

#import "MainFirst_VC.h"
#import "Test1_VC.h"
#import "Test2_VC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[MainTabBarCtlMgr sharedInstance] creatTabbar];
    [self.window makeKeyAndVisible];
    
    [self registerRouter];
    return YES;
}

- (void)registerRouter{
    
    
    [MKRouter routerWithName:@"MAIN" path:@"/home" navigationController:[[MainTabBarCtlMgr sharedInstance] getCurrentNavCtrl] controller:^__kindof UIViewController *{
        Test1_VC *vc = [[Test1_VC alloc] init];
        return vc;
    } action:^(__kindof UIViewController *controller) {
        [[[MainTabBarCtlMgr sharedInstance] getCurrentNavCtrl] pushViewController:controller animated:NO];
    }];
    
    [MKRouter routerWithName:@"PROFILE" path:@"/user/:id" navigationController:[[MainTabBarCtlMgr sharedInstance] getCurrentNavCtrl] controller:^__kindof UIViewController *{
        Test2_VC *vc = [[Test2_VC alloc] init];
        return vc;
    } action:^(__kindof UIViewController *controller) {
        [[[MainTabBarCtlMgr sharedInstance] getCurrentNavCtrl] pushViewController:controller animated:NO];
    }];
    
    
    
    
    
//    [MKRouter registNativeWithScheme:@"Dome"];
//   
//    [MKRouter routerWithName:@"MAINF" path:@"/test1/66666/profile" controller:^__kindof UIViewController *{
//        Test1_VC *vc = [[Test1_VC alloc] init];
//        return vc;
//    } action:^(__kindof UIViewController *controller) {
//        [[[MainTabBarCtlMgr sharedInstance] getCurrentNavCtrl] pushViewController:controller animated:YES];
//    }];
    
//    [MKRouter routerWithName:<#(NSString *)#> path:<#(NSString *)#> navigationController:<#(UINavigationController *)#> controller:<#^__kindof UIViewController *(void)controller#> action:<#^(__kindof UIViewController *controller)action#>]
//    
//    [MKRouter routerWithName:@"MAINF" path:@"/first" controller:^__kindof UIViewController *{
//        return nil;
//    } action:^(__kindof UIViewController *controller) {
//        [[MainTabBarCtlMgr sharedInstance] setSelectWithIndex:0];
//        [[MainTabBarCtlMgr sharedInstance].nav1 popToRootViewControllerAnimated:NO];
//    }];
//    
//    [MKRouter routerWithName:@"MAINS" path:@"/second" controller:^__kindof UIViewController *{
//        return nil;
//    } action:^(__kindof UIViewController *controller) {
//        [[MainTabBarCtlMgr sharedInstance] setSelectWithIndex:1];
//        [[MainTabBarCtlMgr sharedInstance].nav2 popToRootViewControllerAnimated:NO];
//    }];
//
//    [MKRouter routerWithName:@"MAINT" path:@"/third" controller:^__kindof UIViewController *{
//        return nil;
//    } action:^(__kindof UIViewController *controller) {
//        [[MainTabBarCtlMgr sharedInstance] setSelectWithIndex:2];
//        [[MainTabBarCtlMgr sharedInstance].nav3 popToRootViewControllerAnimated:NO];
//    }];
//
//    [MKRouter routerWithName:@"TEST1" path:@"/test1" controller:^__kindof UIViewController *{
//        UIViewController *vc = [[Test1_VC alloc] init];
//        return vc;
//    } action:^(__kindof UIViewController *controller) {
//        controller.hidesBottomBarWhenPushed = YES;
//        [weakSelf.nav1 pushViewController:controller animated:YES];
//    }];
//    
//    [MKRouter routerWithName:@"TEST2" path:@"/test2" controller:^__kindof UIViewController *{
//        UIViewController *vc = [[Test2_VC alloc] init];
//        return vc;
//    } action:^(__kindof UIViewController *controller) {
//        [weakSelf setSelectWithIndex:1];
//        //        controller.hidesBottomBarWhenPushed = YES;
//        [weakSelf.nav1 pushViewController:controller animated:YES];
//    }];
//    
//    [MKRouter routerWithName:@"MAIN4" path:@"/test3" navigationController:nav1 controller:^__kindof UIViewController *{
//        UIViewController *vc = [[Test2_VC alloc] init];
//        return vc;
//    } action:^(__kindof UIViewController *controller) {
//        [weakSelf setSelectWithIndex:2];
//        //        controller.hidesBottomBarWhenPushed = YES;
//        [nav1 pushViewController:controller animated:YES];
//    }];

}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([[MKRouter router] canOpen:url.absoluteString]) {
        [[MKRouter router] open:url.absoluteString];
        return YES;
    }
    return NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

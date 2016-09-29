//
//  MainTabBarCtlMgr.m
//  jianke
//
//  Created by xiaomk on 16/6/14.
//  Copyright © 2016年 xianshijian. All rights reserved.
//

#import "MainTabBarCtlMgr.h"
#import "MKRouterConst.h"

#import "MainFirst_VC.h"
#import "MainSecond_VC.h"
#import "MainThird_VC.h"

#import "MKRouterConst.h"
#import "Test1_VC.h"
#import "Test2_VC.h"

@interface MainTabBarCtlMgr()<UITabBarControllerDelegate>{

}
@property (nonatomic, strong) UITabBarController *rootTabbarCtl;

@end

@implementation MainTabBarCtlMgr

MKImpl_sharedInstance(MainTabBarCtlMgr);

- (UITabBarController *)creatTabbar{
    MainFirst_VC *vc1 = [[MainFirst_VC  alloc] init];
    self.nav1 = [[MKMainNavigationCtr alloc] initWithRootViewController:vc1];
    self.nav1.tabBarItem.title = @"first";
    self.nav1.tabBarItem.image = [UIImage imageNamed:@"home_tabbar_1_0"];
    self.nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabbar_1_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MainSecond_VC *vc2 = [[MainSecond_VC  alloc] init];
    self.nav2 = [[MKMainNavigationCtr alloc] initWithRootViewController:vc2];
    self.nav2.tabBarItem.title = @"second";
    self.nav2.tabBarItem.image = [UIImage imageNamed:@"home_tabbar_2_0"];
    self.nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabbar_2_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MainThird_VC *vc3 = [[MainThird_VC  alloc] init];
    self.nav3 = [[MKMainNavigationCtr alloc] initWithRootViewController:vc3];
    self.nav3.tabBarItem.title = @"third";
    self.nav3.tabBarItem.image = [UIImage imageNamed:@"home_tabbar_3_0"];
    self.nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabbar_3_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.rootTabbarCtl.viewControllers = nil;
    self.rootTabbarCtl.viewControllers = @[self.nav1,self.nav2,self.nav3];
    return self.rootTabbarCtl;
}

- (UITabBarController *)rootTabbarCtl{
    if (!_rootTabbarCtl) {
        _rootTabbarCtl = [[UITabBarController alloc] init];
        _rootTabbarCtl.tabBar.tintColor = MKCOLOR_RGBA(0, 199, 225, 1);
        _rootTabbarCtl.delegate = self;
        _rootTabbarCtl.tabBar.translucent = NO;
    }
    return _rootTabbarCtl;
}

- (void)setSelectWithIndex:(NSInteger)index{
    if (self.rootTabbarCtl.viewControllers.count > index) {
        [self.rootTabbarCtl setSelectedIndex:index];
    }
}

- (MKMainNavigationCtr *)getCurrentNavCtrl{
    NSInteger index = [self.rootTabbarCtl selectedIndex];
    return self.rootTabbarCtl.viewControllers[index];
}


@end

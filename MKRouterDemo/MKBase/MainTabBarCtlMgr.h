//
//  MainTabBarCtlMgr.h
//  jianke
//
//  Created by xiaomk on 16/6/14.
//  Copyright © 2016年 xianshijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKMainNavigationCtr.h"

//@class MKMainNavigationCtr;
@interface MainTabBarCtlMgr : NSObject

@property (nonatomic, strong) MKMainNavigationCtr *nav1;
@property (nonatomic, strong) MKMainNavigationCtr *nav2;
@property (nonatomic, strong) MKMainNavigationCtr *nav3;
@property (nonatomic, strong) MKMainNavigationCtr *currentNavCtrl;

+ (instancetype)sharedInstance;

- (UITabBarController *)creatTabbar;

- (void)setSelectWithIndex:(NSInteger)index;

- (MKMainNavigationCtr *)getCurrentNavCtrl;

@end

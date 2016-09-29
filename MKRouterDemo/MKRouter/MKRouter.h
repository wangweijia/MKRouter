//
//  MKRouter.h
//  MKDevelopSolutions
//
//  Created by xmk on 16/9/26.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRouterCenter.h"
#import "UIViewController+MKRouterExtend.h"

@interface MKRouter : NSObject

+ (instancetype)router;

+ (instancetype)registNativeWithScheme:(NSString *)scheme;

+ (instancetype)notFoundRouterWithController:(__kindof UIViewController *(^)(void))controller
                                      action:(void(^)(__kindof UIViewController *controller)) action;

+ (instancetype)routerWithName:(NSString *)name
                          path:(NSString *)path
                    controller:(__kindof UIViewController *(^)(void))controller
                        action:(void(^)(__kindof UIViewController *controller)) action;

+ (instancetype)routerWithName:(NSString *)name
                          path:(NSString *)path
          navigationController:(UINavigationController *)navigationController
                    controller:(__kindof UIViewController *(^)(void))controller
                        action:(void(^)(__kindof UIViewController *controller))action;

- (__kindof UIViewController *)open:(NSString *)path;

- (BOOL)canOpen:(NSString *)path;

- (__kindof UIViewController *)redirect:(NSString *)name;

- (BOOL)canRedirect:(NSString *)name;

@end

//
//  MKRouter.m
//  MKDevelopSolutions
//
//  Created by xmk on 16/9/26.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "MKRouter.h"

@interface MKRouter(){
    
}
@property (nonatomic, copy) NSString *scheme;
@property (nonatomic, strong)UINavigationController *navigationController;
@end

@implementation MKRouter

+ (instancetype)router{
    static MKRouter *router = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        router = [[self alloc] init];
    });
    return router;
}

+ (instancetype)registNativeWithScheme:(NSString *)scheme{
    [MKRouter router].scheme = scheme;
    return [MKRouter router];
}

+ (instancetype)notFoundRouterWithController:(__kindof UIViewController *(^)(void))controller
                                      action:(void(^)(__kindof UIViewController *controller))action{
    MKRouter *router = [MKRouter router];
    return router;
}

+ (instancetype)routerWithName:(NSString *)name
                          path:(NSString *)path
                    controller:(__kindof UIViewController *(^)(void))controller
                        action:(void(^)(__kindof UIViewController *controller)) action;{
    
    [[MKRouterCenter defaultCenter] addName:name path:path controller:controller action:action];
    return [MKRouter router];
}

+ (instancetype)routerWithName:(NSString *)name
                          path:(NSString *)path
          navigationController:(UINavigationController *)navigationController
                    controller:(__kindof UIViewController *(^)(void))controller
                        action:(void(^)(__kindof UIViewController *controller))action{
    [MKRouter router].navigationController = navigationController;
    [[MKRouterCenter defaultCenter] addName:name path:path controller:controller action:action];
    return [MKRouter router];
}

- (instancetype)init{
    if (self = [super init]) {
        [MKRouterCenter defaultCenter].scheme = self.scheme;
    }
    return self;
}

- (__kindof UIViewController *)open:(NSString *)path{
    NSArray<MKRouterAction *> *actions = [[MKRouterCenter defaultCenter] actionsOfPath:path];
    
    if (!actions) {
        return nil;
    }
    
    for (MKRouterAction *action in actions) {
        if (action.behavior == MKActionBehavior_Attached) {
            if (action.action) {
                UIViewController *controller = action.controller();
                if ([controller respondsToSelector:@selector(mk_viewDidLoadQuery:)]) {
                    [controller mk_viewDidLoadQuery:action.queryItems];
                }
                if ([controller respondsToSelector:@selector(mk_viewDidLoadQueryId:)]) {
                    [controller mk_viewDidLoadQueryId:action.queryId];
                }
                if (controller && [controller isKindOfClass:[UIViewController class]]) {
                    action.action(controller);
                }
            }
        }
        
        if (action.behavior == MKActionBehavior_Pop && self.navigationController) {
            [self.navigationController popViewControllerAnimated:self.navigationController.topViewController.mk_popAnimationNeeded];
        }
        if (action.behavior == MKActionBehavior_PopToRoot && self.navigationController) {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
    }
    return nil;
}

- (BOOL)canOpen:(NSString *)path{
    NSArray<MKRouterAction *> *action = [[MKRouterCenter defaultCenter] actionsOfPath:path];
    if (!action) {
        return NO;
    }
    return YES;
}

- (__kindof UIViewController *)redirect:(NSString *)name{
    MKRouterAction *action = [[MKRouterCenter defaultCenter] actionOfName:name];
    if (!action) {
        return nil;
    }
    UIViewController *controller = action.controller();
    if (controller && [controller isKindOfClass:[UIViewController class]]) {
        action.action(controller);
    }
    return controller;
}

- (BOOL)canRedirect:(NSString *)name{
    if ([[MKRouterCenter defaultCenter] actionOfName:name]) {
        return YES;
    }
    return NO;
}

- (NSString *)scheme{
    if (!_scheme) {
        NSArray *urls = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        id values = urls.firstObject;
        if (values && [values isKindOfClass:[NSDictionary class]]) {
            _scheme = [[values objectForKey:@"CFBundleURLSchemes"] firstObject];
        }
    }
    NSLog(@"_scheme : %@", _scheme);
    return _scheme;
}
@end

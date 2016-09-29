//
//  MKRouterCenter.h
//  MKDevelopSolutions
//
//  Created by xmk on 16/9/26.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MKActionBehavior) {
    MKActionBehavior_Pop,
    MKActionBehavior_PopToRoot,
    MKActionBehavior_Attached,
    MKActionBehavior_DynamicUndefine
};

@interface MKRouterAction : NSObject
@property (nonatomic, assign) MKActionBehavior behavior;
@property (nonatomic, strong) NSDictionary *queryItems;
@property (nonatomic, copy) NSString *queryId;
@property (nonatomic, copy) UIViewController *(^controller)(void);
@property (nonatomic, copy) void *(^action)(UIViewController *controller);
@end


@interface MKRouterCenter : NSObject
@property (nonatomic, copy) NSString *scheme;

+ (instancetype)defaultCenter;

- (void)addName:(NSString *)name
           path:(NSString *)path
     controller:(__kindof UIViewController *(^)(void))controller
         action:(void(^)(__kindof UIViewController *controller))action;

- (MKRouterAction *)actionOfName:(NSString *)name;
- (NSArray *)actionsOfPath:(NSString *)path;
@end

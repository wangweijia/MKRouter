//
//  UIViewController+MKRouterExtend.m
//  MKDevelopSolutions
//
//  Created by xmk on 16/9/26.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "UIViewController+MKRouterExtend.h"
#import <objc/runtime.h>

static const void *pushAnimated = &pushAnimated;
static const void *popAnimated = &popAnimated;

@implementation UIViewController (MKRouterExtend)

@dynamic mk_pushAnimationNeeded, mk_popAnimationNeeded;

- (BOOL)mk_popAnimationNeeded{
    return [objc_getAssociatedObject(self, popAnimated) boolValue];
}

- (BOOL)mk_pushAnimationNeeded{
    return [objc_getAssociatedObject(self, pushAnimated) boolValue];
}

- (void)setMk_popAnimationNeeded:(BOOL)mk_popAnimationNeeded{
    objc_setAssociatedObject(self, popAnimated, @(mk_popAnimationNeeded), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setMk_pushAnimationNeeded:(BOOL)mk_pushAnimationNeeded{
    objc_setAssociatedObject(self, pushAnimated, @(mk_pushAnimationNeeded), OBJC_ASSOCIATION_ASSIGN);
}

- (void)mk_viewDidLoadQuery:(NSDictionary *)queryItems{}
- (void)mk_viewDidLoadQueryId:(NSString *)qid{}

@end

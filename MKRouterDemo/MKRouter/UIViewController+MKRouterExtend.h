//
//  UIViewController+MKRouterExtend.h
//  MKDevelopSolutions
//
//  Created by xmk on 16/9/26.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MKRouterExtend)

@property (nonatomic, assign)BOOL mk_pushAnimationNeeded;
@property (nonatomic, assign)BOOL mk_popAnimationNeeded;

- (void)mk_viewDidLoadQuery:(NSDictionary *)queryItems;
- (void)mk_viewDidLoadQueryId:(NSString *)qid;

@end

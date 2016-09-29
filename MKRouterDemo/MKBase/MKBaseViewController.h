//
//  MKBaseViewController.h
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/5/15.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKBaseViewController : UIViewController

@property (nonatomic, assign) BOOL isUIRectEdgeAll; /*!< 是否 */
@property (nonatomic, assign) BOOL isRootVC;        /*!< 是否是首页，控制返回按钮 */
@property (nonatomic, strong) NSDictionary *params;

- (BOOL)gestureRecognizerShouldBegin;

- (void)backOnclick;
@end

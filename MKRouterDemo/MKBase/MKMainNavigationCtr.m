//
//  MKMainNavigationCtr.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/5/15.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "MKMainNavigationCtr.h"
#import "MKBaseViewController.h"
#import "MKRouterConst.h"

@interface MKMainNavigationCtr ()<UIGestureRecognizerDelegate>

@end

@implementation MKMainNavigationCtr

+ (void)initialize{
    // 设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    //     1.appearance方法返回一个导航栏的外观对象  修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar* navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:MKCOLOR_RGB(39, 39, 39)];    //背景颜色
    [navBar setTintColor:[UIColor whiteColor]];      //文字颜色
    
    
    
    //    设置导航栏的文字
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(1, 1);
    
    [navBar setTitleTextAttributes:@{
                                     NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0],
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSShadowAttributeName : shadow,
                                     }];
    
    //    设置导航栏背景
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    
    //      替换返回按钮 < 图片
    //    [navBar setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
    //    [navBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
    
    
    
    
    
    
    // 2.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTintColor:[UIColor whiteColor]];
    // 2.1.设置背景
    //    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    //    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable.png"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    // 2.2.设置item的文字属性
    NSShadow *barShadow = [[NSShadow alloc] init];
    barShadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];    //文字阴影颜色
    barShadow.shadowOffset = CGSizeMake(1, 1);  //文字阴影偏移量
    NSDictionary *barItemTextAttr = @{
                                      NSFontAttributeName : [UIFont systemFontOfSize:13],   //字体
                                      NSForegroundColorAttributeName : [UIColor darkGrayColor],   //文字颜色
                                      NSShadowAttributeName : barShadow
                                      };
    
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateHighlighted];
    
    //修改返回按钮样式
//    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideBottomLine];
    
    self.interactivePopGestureRecognizer.delegate = self;

    [self setNeedsStatusBarAppearanceUpdate];

    
    //将标题设置成图片
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appcoda-logo.png"]];
    
    
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.interactivePopGestureRecognizer.delegate = self;
    //    }
    //
    //    self.interactivePopGestureRecognizer.enabled = YES;
    //    self.navigationBar.barTintColor = [UIColor blueColor];
    //    self.navigationBar.translucent = NO;    //半透明的
    //    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL ok = YES;
    if ([self.topViewController isKindOfClass:[MKBaseViewController class]]) {
        if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
            MKBaseViewController *vc = (MKBaseViewController *)self.topViewController;
            ok = [vc gestureRecognizerShouldBegin];
        }
    }
    
    return ok;
}




- (void)hideBottomLine{
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray* array = self.navigationBar.subviews;
        for (id obj in array) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView* imageView = (UIImageView *)obj;
                NSArray* subViews = imageView.subviews;
                for (id view in subViews) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        UIImageView* imgView = (UIImageView *)view;
                        imgView.hidden = YES;
                    }
                }
            }
        }
    }
}

//- (void)hideTitle{
//    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//        NSArray* array = self.navigationBar.subviews;
//        for (id obj in array) {
//            if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
//                UIView* titleView = (UIView*)obj;
//                titleView.hidden = YES;
//            }
//        }
//    }
//}



//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [super pushViewController:viewController animated:animated];
//
//    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 1) {
//        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
//    }
//}

//- (UIBarButtonItem *)creatBackButton{
//    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
//}
//
//- (void)popSelf{
//    [self popViewControllerAnimated:YES];
//}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


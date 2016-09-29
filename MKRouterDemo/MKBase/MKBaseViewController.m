//
//  MKBaseViewController.m
//  MKDevelopSolutions
//
//  Created by xiaomk on 16/5/15.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#import "MKBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MKRouterConst.h"

@interface MKBaseViewController ()

@end

@implementation MKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    if (self.isUIRectEdgeAll) {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
//            self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        }
        
        if ([self respondsToSelector:@selector(modalPresentationCapturesStatusBarAppearance)]) {
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
        
        if ([self respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)]) {
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }

    if (self.navigationController && self.navigationController.childViewControllers.count <= 1) {
        DLog(@"isRootVC");
        self.isRootVC = YES;
    }
    
    if (!self.isRootVC) {

        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
        btnBack.frame = CGRectMake(0, 0, 80, 44);
        [btnBack setImage:[UIImage imageNamed:@"public_img_back"] forState:UIControlStateNormal];
        [btnBack setTitle:@"返回" forState:UIControlStateNormal];
        btnBack.titleLabel.font = [UIFont systemFontOfSize:16];
        [btnBack addTarget:self action:@selector(backOnclick) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
        self.navigationItem.leftBarButtonItem = itemBack;
        
        UIBarButtonItem *nevgativeSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        nevgativeSpaceLeft.width = -20;
        self.navigationItem.leftBarButtonItems = @[nevgativeSpaceLeft,itemBack];
    }
    
//    [self hideNavigationBarBottomLine];
}

- (void)hideNavigationBarBottomLine{
    //删除导航栏底部线条
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                NSArray *list2 = imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2 = (UIImageView *)obj2;
                        imageView2.hidden = YES;
                    }
                }
            }
        }
    }
}

/** 返回按钮 */
- (void)backOnclick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ***** statusBar ******
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin{
    return !self.isRootVC;
}

- (void)dealloc{
    [MKNotification removeObserver:self];
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

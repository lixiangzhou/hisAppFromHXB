//
//  HXBBaseNavigationController.m
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseNavigationController.h"
#import "HxbHomeViewController.h"
@interface HXBBaseNavigationController ()

@end



@implementation HXBBaseNavigationController

#pragma mark - setter pop按钮的自定义
- (void)setLeftBarButtonItemImage:(UIImage *)leftBarButtonItemImage {
    _leftBarButtonItemImage = [leftBarButtonItemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:_leftBarButtonItemImage style:UIBarButtonItemStylePlain target:self action:@selector(clickBarButtonItemLeft)];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
}
- (void)setLeftBarButtonItemView:(UIView *)leftBarButtonItemView {
    _leftBarButtonItemView = leftBarButtonItemView;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_leftBarButtonItemView];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
}
- (void)setLeftBarButtonItemString:(NSString *)leftBarButtonItemString {
    _leftBarButtonItemString = leftBarButtonItemString;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:_leftBarButtonItemString style:UIBarButtonItemStylePlain target:self action:@selector(clickBarButtonItemLeft)];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
}
- (void)clickBarButtonItemLeft {
    [self popViewControllerAnimated:YES];
}

#pragma mark - override push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (self.viewControllers.count >= 1)
    {   //如果进入子页面，隐藏tabbar的bottombar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //将导航栏显示出来
        self.navigationBar.hidden = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}


#pragma mark - setter pop的自定义
- (void)popViewControllerWithToViewController: (NSString *)toViewControllerStr andAnimated: (BOOL)animated{
    for (UIViewController *toVC in self.childViewControllers) {
        if ([NSStringFromClass(toVC.class) isEqualToString:toViewControllerStr]) {
            [self popToViewController:toVC animated:animated];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

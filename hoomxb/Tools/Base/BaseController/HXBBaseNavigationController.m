//
//  HXBBaseNavigationController.m
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseNavigationController.h"
#import "HxbHomeViewController.h"
#import "PYFullScreenGesturePOPManager.h"
@interface HXBBaseNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) PYFullScreenGesturePOPManager *popManager;
@end



@implementation HXBBaseNavigationController

#pragma mark - override push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = true;
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
    [self.navigationBar setValue:@(0)forKeyPath:@"backgroundView.alpha"];
    self.navigationBar.barStyle=UIBarStyleBlackTranslucent;
    self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
    HXBColourGradientView *colourGradientView = [[HXBColourGradientView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 64)];
    [self.navigationBar addSubview:colourGradientView];
     
    //侧滑手势开启
//    PYFullScreenGesturePOPManager *popManager = [[PYFullScreenGesturePOPManager alloc]initWithViewController:self andTransitionanimationType:PYFullScreenGestureManager_TransitionanimationType_Runtime];
//    self.popManager = popManager;
}
#pragma mark - 里面判断了是否为跟控制器
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    ///这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

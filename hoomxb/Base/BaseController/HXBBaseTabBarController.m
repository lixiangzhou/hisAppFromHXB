//
//  HXBBaseTabBarController.m
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTabBarController.h"
#import "HXBBaseNavigationController.h"
#import "HxbSignInViewController.h"
#import "HxbMyViewController.h"
#import "HXBCheckCaptchaViewController.h"
#import "HXBBaseViewController.h"
#import "SVGKit/SVGKImage.h"
@interface HXBBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation HXBBaseTabBarController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    ///注册通知
    [self registerNotification];

    self.delegate = self;
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UI
// 去除tabBar上面的横线
- (void)hiddenTabbarLine {
    UIImageView *shadowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.3)];
    shadowImage.backgroundColor = [UIColor colorWithWhite:0.952 alpha:0.8];
    [[HXB_XYTools shareHandle] createViewShadDow:shadowImage];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [self.tabBar addSubview:shadowImage];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

#pragma mark - Observer
///注册通知
- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLoginVC:) name:kHXBNotification_ShowLoginVC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushMyVC:) name:kHXBNotification_LoginSuccess_PushMYVC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHomeVC:) name:kHXBBotification_ShowHomeVC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMyVC:) name:kHXBNotification_ShowMyVC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMYVC_PlanList:) name:kHXBNotification_ShowMYVC_PlanList object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMyVC_LoanList:) name:kHXBNotification_ShowMYVC_LoanList object:nil];

}

#pragma mark - 封装的方法
/* 根据subVC名创建subVC并加入到self.childViewControllers里面
 */
- (void)subViewControllerNames: (NSArray <NSString *> *)subViewControllerNameArray andNavigationControllerTitleArray: (NSArray<NSString *>*)titleArray andImageNameArray: (NSArray<NSString *>*)imageNameArray andSelectImageCommonName: (NSArray<NSString *>*)selectImageCommonNameArray{
    
    for (int i = 0; i < subViewControllerNameArray.count; i ++) {
        UIViewController *VC = [self ctratSubControllerWithName:subViewControllerNameArray[i]];
        UIEdgeInsets insets = UIEdgeInsetsMake(8, 0, -8, 0);
        self.tabBar.items[i].imageInsets = insets;
        //设置字体
        VC.title = titleArray[i];
        HXBBaseNavigationController *NAV = [self creatNavigationControllerBySubViewController:VC];
        if (self.font) {
            [NAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : self.font} forState: UIControlStateNormal];
        }
        
        //字体的颜色
        [NAV.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : self.normalColor} forState:UIControlStateNormal];
        [NAV.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : self.selectColor} forState:UIControlStateSelected];
        
        // 设置image 及渲染模式
        SVGKImage *svgImage = [SVGKImage imageNamed:imageNameArray[i]];
        UIImage *image = [svgImage.UIImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NAV.tabBarItem.image = image;
        
        svgImage = [SVGKImage imageNamed:selectImageCommonNameArray[i]];
        UIImage *selectImage = svgImage.UIImage;
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NAV.tabBarItem.selectedImage = selectImage;
        
        [self addChildViewController:NAV];
        if (i == 2) {
            [NAV.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:(UIBarMetricsDefault)];
            NAV.navigationItem.leftBarButtonItem = nil;
            [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
            
        }
    }
}

/// 创建导航控制器
- (HXBBaseNavigationController *)creatNavigationControllerBySubViewController: (UIViewController *)VC {
    HXBBaseNavigationController *NAV = [[HXBBaseNavigationController alloc]initWithRootViewController:VC];
    return NAV;
}

/// 根据文件名创建subVC
- (UIViewController *)ctratSubControllerWithName: (NSString *)subViewControllerName {
    Class class = NSClassFromString(subViewControllerName);
    UIViewController *controller = [[class alloc]init];
    return controller;
}

#pragma mark - tabBarDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    DLog(@"select item === %lu",(unsigned long)tabBarController.selectedIndex);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //获取当前的导航控制器的跟控制器
    UIViewController *vc = ((HXBBaseNavigationController *)viewController).viewControllers.firstObject;
    
    //当前的控制器是否为 “我的“ 界面的控制器
    BOOL isMYController = vc && [vc.class isSubclassOfClass:[HxbMyViewController class]];
    
    //当前是否处于登录状态// 没有登录的话就return一个NO，并modal一个登录控制器。
    if (isMYController && ![KeyChain isLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:@{@"selectedIndex" : [NSString stringWithFormat:@"%lu",(unsigned long)tabBarController.selectedIndex]}];
        return YES;
    }
    return YES;
}

#pragma mark - 通知Action
// modal 登录控制器
- (void)presentLoginVC:(NSNotification *)notification {
    HxbSignInViewController *vc = [[HxbSignInViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    vc.selectedIndexVC = notification.object[@"selectedIndex"];
    @try {
        vc.isUpdate = notification.object[kHXBMY_VersionUpdateURL];
    } @catch (NSException *exception) {
    } @finally {
    }
    
    [self presentViewController:navi animated:YES completion:^{
//        self.selectedViewController = self.viewControllers.lastObject;
    }];
}

//跳转 myVC
- (void)pushMyVC:(NSNotification *)notification {
    self.selectedViewController = self.viewControllers.lastObject;
}
//显示我的界面
- (void)showMyVC: (NSNotification *)notification {
    self.selectedViewController = self.viewControllers.lastObject;
}

- (void)showHomeVC: (NSNotification *)notification {
    self.selectedViewController = self.viewControllers.firstObject;
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UINavigationController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj popToRootViewControllerAnimated:NO];
    }];
}

- (void)showMYVC_PlanList:(NSNotification *)notification {
    Class obj = NSClassFromString(@"HXBMY_PlanListViewController");
    UINavigationController *myPlanListViewController = [[obj alloc]init];
    [self.viewControllers.lastObject pushViewController:myPlanListViewController animated:YES];
    self.selectedViewController = self.viewControllers.lastObject;
}

- (void)showMyVC_LoanList:(NSNotification *)notification {
    Class obj = NSClassFromString(@"HXBMY_LoanListViewController");
    UINavigationController *myPlanListViewController = [[obj alloc]init];
    [self.viewControllers.lastObject pushViewController:myPlanListViewController animated:YES];
    self.selectedViewController = self.viewControllers.lastObject;
}

#pragma mark - gtter方法
- (UIColor *)normalColor {
    if (!_normalColor) {
        _normalColor = [UIColor redColor];
    }
    return _normalColor;
}
- (UIColor *)selectColor {
    if (!_selectColor) {
        _selectColor = [UIColor blueColor];
    }
    return _selectColor;
}

@end


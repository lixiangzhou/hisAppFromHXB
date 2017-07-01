//
//  HXBBaseTabBarController.m
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTabBarController.h"
#import "HXBBaseNavigationController.h"
#import "HxbSignInViewController.h"
#import "HxbMyViewController.h"
#import "HXBCheckCaptchaViewController.h"
#import "HXBBaseViewController.h"

@interface HXBBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation HXBBaseTabBarController


#pragma mark - setter方法
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

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    ///注册通知
    [self registerNotification];
    self.delegate = self;
}
///注册通知
- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLoginVC:) name:kHXBNotification_ShowLoginVC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushMyVC:) name:kHXBNotification_LoginSuccess_PushMYVC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHomeVC:) name:kHXBBotification_ShowHomeVC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMyVC:) name:kHXBNotification_ShowMyVC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMYVC_PlanList:) name:kHXBNotification_ShowMYVC_PlanList object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMyVC_LoanList:) name:kHXBNotification_ShowMYVC_LoanList object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark - 封装的方法
//MARK: 根据subVC名创建subVC并加入到self.childViewControllers里面
- (void)subViewControllerNames: (NSArray <NSString *> *)subViewControllerNameArray andNavigationControllerTitleArray: (NSArray<NSString *>*)titleArray andImageNameArray: (NSArray<NSString *>*)imageNameArray andSelectImageCommonName: (NSString *)selectImageCommonName{
    
    for (int i = 0; i < subViewControllerNameArray.count; i ++) {
        UIViewController *VC = [self ctratSubControllerWithName:subViewControllerNameArray[i]];
        
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
        UIImage *image = [UIImage imageNamed:imageNameArray[i]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NAV.tabBarItem.image = image;
        UIImage *selectImage = [UIImage imageNamed: [NSString stringWithFormat:@"%@%@",selectImageCommonName,imageNameArray[i]]];
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NAV.tabBarItem.selectedImage = selectImage;
        [self addChildViewController:NAV];
    }
}

//MARK: 创建导航控制器
- (HXBBaseNavigationController *)creatNavigationControllerBySubViewController: (UIViewController *)VC {
    HXBBaseNavigationController *NAV = [[HXBBaseNavigationController alloc]initWithRootViewController:VC];
    return NAV;
}


//MARK: 根据文件名创建subVC
- (UIViewController *)ctratSubControllerWithName: (NSString *)subViewControllerName {
    Class class = NSClassFromString(subViewControllerName);
    UIViewController *controller = [[class alloc]init];
    return controller;
}


- (void)realShowLogin
{
  
//    self.homePageVC.willPresent = YES;
//    self.moneyManageVC.willPresent = YES;
    
//    [self presentViewController:navLoginVC animated:YES completion:nil];
}

#pragma mark - tabBarDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    DLog(@"select item === %lu",(unsigned long)tabBarController.selectedIndex);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//#warning 屏蔽了点击 我的 跳转 登录页
//    return true;
    //获取当前的导航控制器的跟控制器
    UIViewController *vc = ((HXBBaseNavigationController *)viewController).viewControllers.firstObject;
    
    //当前的控制器是否为 “我的“ 界面的控制器
    BOOL isMYController = vc && [vc.class isSubclassOfClass:[HxbMyViewController class]];
    
    //当前是否处于登录状态// 没有登录的话就return一个NO，并modal一个登录控制器。
    if (isMYController && ![KeyChain isLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        return false;
    }
    return YES;
}

// modal 登录控制器
- (void) presentLoginVC:(NSNotification *)notification {
    HxbSignInViewController *vc = [[HxbSignInViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.selectedViewController presentViewController:navi animated:YES completion:nil];
}
//跳转 myVC
- (void) pushMyVC:(NSNotification *)notification {
    self.selectedViewController = self.viewControllers.lastObject;
}
//显示我的界面
- (void) showMyVC: (NSNotification *)notification {
    self.selectedViewController = self.viewControllers.lastObject;
}
- (void) showHomeVC: (NSNotification *)notification {
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
////谈图验
//- (void) modalCaptchaVC: (NSNotification *)notif {
//    HXBBaseNavigationController *nav =  (HXBBaseNavigationController *)self.selectedViewController;
//    UIViewController *viewController = nav.viewControllers.firstObject;
//    HXBCheckCaptchaViewController *checkCaptchaViewController = [[HXBCheckCaptchaViewController alloc]init];
//    [nav presentViewController:checkCaptchaViewController animated:true completion:nil];
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end




// ----------------- readMe ------------------------
/*
 根据subVC名创建subVC并加入到self.childViewControllers里面
 */

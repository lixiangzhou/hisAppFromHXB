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
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLoginVC) name:ShowLoginVC object:nil];
}

#pragma mark - 封装的方法
//MARK: 根据subVC名创建subVC并加入到self.childViewControllers里面
- (void)subViewControllerNames: (NSArray <NSString *> *)subViewControllerNameArray andNavigationControllerTitleArray: (NSArray<NSString *>*)titleArray andImageNameArray: (NSArray<NSString *>*)imageNameArray andSelectImageCommonName: (NSString *)selectImageCommonName{
    
    for (int i = 0; i < subViewControllerNameArray.count; i ++) {
        UIViewController *VC = [self ctratSubControllerWithName:subViewControllerNameArray[i]];
//        VC.view.backgroundColor = [UIColor whiteColor];
        
        //设置字体
        VC.title = titleArray[i];
        HXBBaseNavigationController *NAV = [self creatNavigationControllerBySubViewController:VC];
        if (self.font) {
            [NAV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : self.font} forState: UIControlStateNormal];
        }
        
        //字体的颜色
        [NAV.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateNormal];
        [NAV.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
        
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

- (void)showLoginVC
{
    [self performSelector:@selector(realShowLogin) withObject:nil afterDelay:0];
}

- (void)realShowLogin
{
    HxbSignInViewController *vc = [[HxbSignInViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
//    self.homePageVC.willPresent = YES;
//    self.moneyManageVC.willPresent = YES;
    [self presentViewController:navi animated:YES completion:nil];
    //    [self presentViewController:navLoginVC animated:YES completion:nil];
}

#pragma mark - tabBarDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    DLog(@"select item === %lu",(unsigned long)tabBarController.selectedIndex);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIViewController *vc = ((HXBBaseNavigationController *)viewController).viewControllers[0];
    
    // [viewController.tabBarItem.title isEqualToString:@"资产"]
    if (vc && [vc.class isSubclassOfClass:[HxbMyViewController class]])
    {
        // login
        if ([KeyChain isLogin])
        {
            return YES;
        }
        else
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:ShowLoginVC object:nil];
            return NO;
        }
        return YES;
        
    }
    return YES;
}

@end




// ----------------- readMe ------------------------
/*
 根据subVC名创建subVC并加入到self.childViewControllers里面
 */

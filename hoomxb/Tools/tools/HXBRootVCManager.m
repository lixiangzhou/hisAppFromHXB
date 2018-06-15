//
//  HXBRootVCManager.m
//  hoomxb
//
//  Created by lxz on 2017/11/14.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRootVCManager.h"

#import "AXHNewFeatureController.h"
#import "HxbAdvertiseViewController.h"
#import "HXBVersionUpdateModel.h"
#import "HXBHomePopViewManager.h"
#import "HXBVersionUpdateManager.h"
#import "HXBAdvertiseManager.h"

#define AXHVersionKey @"version"

@interface HXBRootVCManager ()
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) HxbAdvertiseViewController *advertiseVC;
@end

@implementation HXBRootVCManager

+ (instancetype)manager {
    static HXBRootVCManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [HXBRootVCManager new];
        UIViewController *vc = [manager getTabBarOrGesPwdVC];
        if ([vc isKindOfClass:[HXBGesturePasswordViewController class]]) {
            manager.gesturePwdVC = (HXBGesturePasswordViewController *)vc;
        }
    });
    return manager;
}

/// 创建根控制器
- (void)createRootVCAndMakeKeyWindow {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [UIApplication sharedApplication].delegate.window = self.window;
    
    [[HXBHomePopViewManager sharedInstance] getHomePopViewData];//获取首页弹窗数据
    [[HXBVersionUpdateManager sharedInstance] checkVersionUpdate];
    [[HXBAdvertiseManager shared] getSplash];
    
    [self chooseRootViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

/// 选择一个根控制器
- (void)chooseRootViewController
{
    NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:AXHVersionKey];
    //版本检测
    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新的版本号
        [self makeTabbarRootVC];
        [self showSlash];
    } else { // 有新版本
        AXHNewFeatureController *VC = [[AXHNewFeatureController alloc] init];
        self.window.rootViewController = VC;
        
        //保存当前版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:AXHVersionKey];
    }
}

- (void)showSlash {
    [self.mainTabbarVC.view addSubview:self.advertiseVC.view];
    [self.advertiseVC addTimer];
    [HXBAdvertiseManager shared].isShowed = YES;
}

- (void)showGesPwd {
    if (self.gesturePwdVC) {
        [self.mainTabbarVC.view addSubview:self.gesturePwdVC.view];
        [self.gesturePwdVC checkAlertSkipSetting];
    }
}

//- (void)popWindowsAtHomeAfterSlashOrGesturePwd {
//    UIViewController *VC = self.mainTabbarVC.childViewControllers.firstObject.childViewControllers.firstObject;
//    [[HXBHomePopViewManager sharedInstance] popHomeViewfromController:VC];//展示首页弹窗
//    [[HXBVersionUpdateManager sharedInstance] show];
////    [HXBAdvertiseManager shared].couldPopAtHomeAfterSlashOrGesturePwd = YES;
//}

/**
 判断是否进入手势密码
 */
- (void)enterTheGesturePasswordVCOrTabBar
{
    if (KeyChain.isLogin) {
        NSLog(@"%@ %@ %d", KeyChain.gesturePwd, KeyChain.skipGesture, KeyChain.skipGestureAlertAppeared);
        if (KeyChain.gesturePwd.length > 0 && [KeyChain.skipGesture isEqualToString:kHXBGesturePwdSkipeNO]) {   // 已有手势密码，手势登录
            [KeyWindow.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
            HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
            gesturePasswordVC.type = GestureViewControllerTypeLogin;
            gesturePasswordVC.switchType = HXBAccountSecureSwitchTypeNone;
            self.window.rootViewController = gesturePasswordVC;
        } else {
            NSString *skip = KeyChain.skipGesture;
            BOOL skipGesturePwd = NO;
            if (skip != nil) {
                skipGesturePwd = [skip isEqualToString:kHXBGesturePwdSkipeYES];
            }
            
            BOOL appeared = KeyChain.skipGestureAlertAppeared;
            
            if (skipGesturePwd && appeared) {
                [self makeTabbarRootVC];
//                [HXBAdvertiseManager shared].couldPopAtHomeAfterSlashOrGesturePwd = YES;
            } else {
                [KeyWindow.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
                HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
                gesturePasswordVC.type = GestureViewControllerTypeSetting;
                gesturePasswordVC.switchType = HXBAccountSecureSwitchTypeNone;
                self.window.rootViewController = gesturePasswordVC;
            }
        }
    } else {
        [self makeTabbarRootVC];
//        [HXBAdvertiseManager shared].couldPopAtHomeAfterSlashOrGesturePwd = YES;
    }
}

- (UIViewController *)getTabBarOrGesPwdVC {
    UIViewController *VC = nil;
    if (KeyChain.isLogin) {
        if (KeyChain.gesturePwd.length > 0 && [KeyChain.skipGesture isEqualToString:kHXBGesturePwdSkipeNO]) {   // 已有手势密码，手势登录
            HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
            gesturePasswordVC.type = GestureViewControllerTypeLogin;
            gesturePasswordVC.switchType = HXBAccountSecureSwitchTypeNone;
            VC = gesturePasswordVC;
        } else {
            NSString *skip = KeyChain.skipGesture;
            BOOL skipGesturePwd = NO;
            if (skip != nil) {
                skipGesturePwd = [skip isEqualToString:kHXBGesturePwdSkipeYES];
            }
            
            BOOL appeared = KeyChain.skipGestureAlertAppeared;
            
            if (skipGesturePwd && appeared) {
                VC = self.mainTabbarVC;
            } else {
                HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
                gesturePasswordVC.type = GestureViewControllerTypeSetting;
                gesturePasswordVC.switchType = HXBAccountSecureSwitchTypeNone;
                VC = gesturePasswordVC;
            }
        }
    } else {
        VC = self.mainTabbarVC;
    }
    return VC;
}

- (void)makeTabbarRootVC {
//    [HXBAdvertiseManager shared].couldPopAtHomeAfterSlashOrGesturePwd = NO;
    self.window.rootViewController = self.mainTabbarVC;
}

- (UIViewController *)topVC {
    return [self topControllerWithRootController:KeyWindow.rootViewController];
}

#pragma mark - 获取最顶端控制器
- (UIViewController *)topControllerWithRootController:(UIViewController *)rootController {
    if ([rootController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)rootController;
        return [self topControllerWithRootController:tabBarVC.selectedViewController];
    } else if ([rootController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationVC = (UINavigationController *)rootController;
        return [self topControllerWithRootController:navigationVC.visibleViewController];
    } else if (rootController.presentedViewController) {
        return [self topControllerWithRootController:rootController.presentedViewController];
    } else {
        return rootController;
    }
}


#pragma mark - Lazy
/// 懒加载主界面Tabbar
- (HXBBaseTabBarController *)mainTabbarVC
{
    if (!_mainTabbarVC) {
        _mainTabbarVC = [[HXBBaseTabBarController alloc]init];
        _mainTabbarVC.selectColor = [UIColor redColor];///选中的颜色
        _mainTabbarVC.normalColor = [UIColor grayColor];///平常状态的颜色
        
        NSArray *controllerNameArray = @[
                                         @"HxbHomeViewController",//首页
                                         @"HxbFinanctingViewController",//理财
                                         @"HxbMyViewController"];//我的
        //title 集合
        NSArray *controllerTitleArray = @[@"首页", @"出借", @"我的"];
        NSArray *imageArray = @[@"home_Unselected.svg",@"investment_Unselected.svg",@"my_Unselected.svg"];
        //选中下的图片前缀
        NSArray *commonName = @[@"home_Selected.svg",@"investment_Selected.svg",@"my_Selected.svg"];
        for (UIView *view in self.mainTabbarVC.tabBar.subviews) {
            NSLog(@"view = %@", view);
            if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1) {
                UIImageView *ima = (UIImageView *)view;
                ima.height = 0.000001;
                ima.hidden = YES;
            }
        }
        
        [_mainTabbarVC subViewControllerNames:controllerNameArray andNavigationControllerTitleArray:controllerTitleArray andImageNameArray:imageArray andSelectImageCommonName:commonName];
    }
    return _mainTabbarVC ;
}

- (HxbAdvertiseViewController *)advertiseVC {
    if (_advertiseVC == nil) {
        _advertiseVC = [HxbAdvertiseViewController new];
        kWeakSelf
        _advertiseVC.dismissBlock = ^{
            [weakSelf.advertiseVC.view removeFromSuperview];
            
            if (weakSelf.gesturePwdVC) {    // 需要显示手势密码
                [weakSelf showGesPwd];
                weakSelf.gesturePwdVC.dismissBlock = ^{
                    [[HXBRootVCManager manager].gesturePwdVC.view removeFromSuperview];
                };
            } else {
            }
        };
    }
    return _advertiseVC;
}

@end

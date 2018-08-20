//
//  HXBRootVCManager.h
//  hoomxb
//
//  Created by lxz on 2017/11/14.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXBBaseTabBarController.h"
#import "HXBGesturePasswordViewController.h"

@interface HXBRootVCManager : NSObject

@property (nonatomic, strong) HXBBaseTabBarController *mainTabbarVC;
///获取顶部控制器
@property (nonatomic, weak) UIViewController *topVC;
/// 手势密码控制器，有值会显示，无值不显示
@property (nonatomic, strong) HXBGesturePasswordViewController *gesturePwdVC;

+ (instancetype)manager;

/// 第一次创建并设置根控制器
- (void)createRootVCAndMakeKeyWindow;

/// 进入手势密码控制器，或tabBar
- (void)enterTheGesturePasswordVCOrTabBar;

/// 让tabBarVC 成为 root VC
- (void)makeTabbarRootVC;

/// 显示闪屏页面到 tabbar
- (void)showSlash;

/// 显示手势密码页面到 tabbar
- (void)showGesturePwd;

/// 闪屏或手势页接受后，首页手动弹窗
- (void)popWindowsAtHomeAfterSlashOrGesturePwd;

@end

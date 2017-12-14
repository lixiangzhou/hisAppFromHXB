//
//  HXBRootVCManager.h
//  hoomxb
//
//  Created by lxz on 2017/11/14.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXBBaseTabBarController.h"

@interface HXBRootVCManager : NSObject

@property (nonatomic, strong) HXBBaseTabBarController *mainTabbarVC;
///获取顶部控制器
@property (nonatomic, weak) UIViewController *topVC;

+ (instancetype)manager;

/// 第一次创建并设置根控制器
- (void)createRootVCAndMakeKeyWindow;

/// 进入手势密码控制器，或tabBar
- (void)enterTheGesturePasswordVCOrTabBar;

/// 让tabBarVC 成为 root VC
- (void)makeTabbarRootVC;

@end

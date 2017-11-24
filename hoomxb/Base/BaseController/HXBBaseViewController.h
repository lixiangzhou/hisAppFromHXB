//
//  HXBBaseViewController.h
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBNoNetworkStatusView.h"

@interface HXBBaseViewController : UIViewController
///是否隐藏导航栏
@property (nonatomic,assign) BOOL isHiddenNavigationBar;
///使navBar 透明
@property (nonatomic,assign) BOOL isTransparentNavigationBar;
///导航条是否为红色渐变
@property (nonatomic,assign) BOOL isColourGradientNavigationBar;
@property (nonatomic,assign) BOOL isRedColorWithNavigationBar;
///导航条是否为白色
@property (nonatomic, assign) BOOL isWhiteColourGradientNavigationBar;
///导航条是否为蓝色
@property (nonatomic,assign) BOOL isBlueGradientNavigationBar;
@property (nonatomic, strong) HXBNoNetworkStatusView *noNetworkStatusView;

///可以重写返回方法
- (void)leftBackBtnClick;
///无网状态的网络连接
- (void)getNetworkAgain;
/**
 隐藏导航栏，仅能在派生类的viewWillAppear方法中调用
 调用条件：如果需要隐藏导航栏就调用调用该方法
 @param animated 是否动画
 */
- (void)hideNavigationBar:(BOOL)animated;
/**
 设置导航栏title颜色透明， 仅能在派生类的viewWillAppear方法中调用
 调用条件：如果当前页面有presentedViewController这个方法的调用， 那就需要调用该方法
 */
- (void)transparentNavigationTitle;
@end

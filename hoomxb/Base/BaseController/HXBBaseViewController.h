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

@end

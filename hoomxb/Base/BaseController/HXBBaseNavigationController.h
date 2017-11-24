//
//  HXBBaseNavigationController.h
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseNavigationController : UINavigationController

/// 是否允许全屏手势，默认 YES
@property (nonatomic, assign) BOOL enableFullScreenGesture;
//是否发生了向右滑动的手势动作
@property (nonatomic, assign) BOOL occurRightGestureAction;

/**
 再次调用网络请求的方法
 */
//@property (nonatomic, copy) void(^getNetworkAgainBlock)();

#pragma mark -自定义 pop & push 按钮
/**
 * 跳转控制器
 * @parma toViewControllerStr跳转到的控制器的name
 * @parma animated 是否支持动画
 */
- (void)popViewControllerWithToViewController: (NSString *)toViewControllerStr andAnimated: (BOOL)animated;

@end

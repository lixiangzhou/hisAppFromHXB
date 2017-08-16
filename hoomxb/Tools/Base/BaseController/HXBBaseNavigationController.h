//
//  HXBBaseNavigationController.h
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseNavigationController : UINavigationController


/**
 再次调用网络请求的方法
 */
@property (nonatomic, copy) void(^getNetworkAgainBlock)();

#pragma mark -自定义 pop & push 按钮
/**
 * 跳转控制器
 * @parma toViewControllerStr跳转到的控制器的name
 * @parma animated 是否支持动画
 */
- (void)popViewControllerWithToViewController: (NSString *)toViewControllerStr andAnimated: (BOOL)animated;

@end

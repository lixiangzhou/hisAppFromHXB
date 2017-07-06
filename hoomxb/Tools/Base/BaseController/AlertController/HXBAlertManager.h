//
//  HXBAlertManager.h
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBVersionUpdateModel;
@interface HXBAlertManager : NSObject
/**
 重新登录的alert
 */
+ (void)alertManager_loginAgainAlertWithView: (UIView *)view;

/**
 强制更新
 */
+ (void)checkversionUpdateWith:(HXBVersionUpdateModel *)versionUpdateModel;

/**
 判断是否风险测评
 */
+ (void)checkOutRiskAssessmentWithSuperVC:(UIViewController *)vc andWithPushBlock:(void(^)())pushBlock;

/**
 初始化警告视图

 @param title title
 @param message message
 @return 创建的对象
 */
+ (instancetype)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message;

/**
 添加一个按钮

 @param btnName 按钮的名字
 @param handler 处理的事件
 */
- (void)addButtonWithBtnName:(NSString *)btnName andWitHandler:(void(^)())handler;

/**
 显示

 @param vc 显示在哪个VC
 */
- (void)showWithVC:(UIViewController *)vc;
@end

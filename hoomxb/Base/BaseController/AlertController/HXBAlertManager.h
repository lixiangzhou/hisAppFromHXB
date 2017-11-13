//
//  HXBAlertManager.h
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define kHXBCallPhone_title @"您已经在后台解绑身份证请联系客服"

#import <Foundation/Foundation.h>
@class HXBVersionUpdateModel;
@interface HXBAlertManager : NSObject
/**
 重新登录的alert
 */
//+ (void)alertManager_loginAgainAlertWithView: (UIView *)view;
+ (void)alertNeedLoginAgainWithMeaage:(NSString *)message;

/**
 强制更新
 */
+ (void)checkversionUpdateWith:(HXBVersionUpdateModel *)versionUpdateModel;

/**
 判断是否风险评测 开通存管银行账户 ///完善信息
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
/**
 拨打电话封装
 
 @param phoneNumber 电话号
 @param message 提示信息
 */
+ (void)callupWithphoneNumber:(NSString *)phoneNumber andWithTitle:(NSString *)title Message:(NSString *)message;
@end

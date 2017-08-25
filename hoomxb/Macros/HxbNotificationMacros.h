//
//  HxbNotificationMacros.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  HXBNotificationCenter  [NSNotificationCenter defaultCenter]
/// 展示登录的VC
extern NSString *const kHXBNotification_ShowLoginVC;
extern NSString *const kHXBNotification_IsLoginToReloadTableView;
///跳转我的界面
extern NSString *const kHXBNotification_LoginSuccess_PushMYVC;
extern NSString *const kHXBNotification_ShowMYVC_LoanList;
extern NSString *const kHXBNotification_ShowMYVC_PlanList;
///弹出 验证码
extern NSString *const kHXBBotification_ShowCaptchaVC;
extern NSString *const kHXBNotification_ShowMyVC;
extern NSString *const kHXBBotification_ShowHomeVC;
extern NSString *const kHXBNotification_StopAllRequest;
//跳转理财页面
extern NSString *const kHXBNotification_PlanAndLoan_Fragment;
@interface HxbNotificationMacros : NSObject

@end

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
///弹出 验证码
extern NSString *const kHXBBotification_ShowCaptchaVC;
extern NSString *const kHXBNotification_ShowMyVC;
extern NSString *const kHXBBotification_ShowHomeVC;
@interface HxbNotificationMacros : NSObject

@end

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
@end

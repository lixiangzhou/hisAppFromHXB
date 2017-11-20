//
//  HXBUMengShareManager.h
//  hoomxb
//
//  Created by HXB-C on 2017/11/8.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
@class HXBUMShareViewModel;
@interface HXBUMengShareManager : UMSocialManager


/**
 开启友盟分享
 */
+ (void)umengShareStart;

/**
 显示分享
 */
+ (void) showShareMenuViewInWindowWith:(HXBUMShareViewModel *)shareVM;
@end

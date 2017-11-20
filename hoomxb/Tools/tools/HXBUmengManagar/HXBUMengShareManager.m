//
//  HXBUMengShareManager.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/8.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUMengShareManager.h"
#import <UShareUI/UShareUI.h>
#import "HXBUmengViewController.h"
//友盟APPkey
#define kUMAppKey @"596359ca5312dd05b4001381"
//微信APPkey
#define kWechatAppKey @"wxcbdc25fe98ea7b17"
//微信AppSecret
#define kWechatAppSecret @"cbd7e23660d3af10b6ee236fa957e176"
//QQAPPkey
#define kQQAppKey @"1105452627"



@implementation HXBUMengShareManager

+ (void)umengShareStart {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMAppKey];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
}

+ (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

+ (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWechatAppKey appSecret:kWechatAppSecret redirectURL:nil];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQAppKey/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
}


+ (void) showShareMenuViewInWindowWith:(HXBUMShareViewModel *)shareVM {
    
    HXBUmengViewController *UmengVC = [[HXBUmengViewController alloc] init];
    UmengVC.shareVM = shareVM;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:UmengVC animated:NO completion:^{
        [UmengVC showShareView];
    }];
    
    

//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//        [self shareWebPageToPlatformType:platformType];
//    }];
}

@end

//
//  AppDelegate.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "AppDelegate.h"
#import "NYNetwork.h"//网络请求的kit
#import "HxbAdvertiseView.h"//弹窗
#import "HXBServerAndClientTime.h"//客户端与服务器时间协调的工具类
#import "HXBBaseVersionUpdateManager.h"//
#import "HXBVersionUpdateModel.h"//版本更新的Model
#import "IQKeyboardManager.h"//设置键盘
#import "UMMobClick/MobClick.h"//友盟统计

#import "HXBUMengShareManager.h"//友盟分享

#import "AvoidCrash.h"//防止数据为空产生的闪退
#import "HXBRootVCManager.h"    // 根控制器管理
#import <Fabric/Fabric.h> //fabric crash 统计
#import <Crashlytics/Crashlytics.h> //fabric crash 统计
#import "HXBBaseUrlSettingView.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSDate *exitTime;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置启动页面停留时间
    [NSThread sleepForTimeInterval:0.5];
    //字典和数据为空的防止闪退
//    [AvoidCrash becomeEffective];
    
    //fabrci crash 统计
    [Fabric with:@[[Crashlytics class]]];
    
    //设置友盟统计
    [self setupUmeng];
    
    //配置网络
    [self setNetworkConfig];
    
    //判断app是否第一次启动，以及版本是否需要更新
    [self judgementApplication];
    
    //创建根视图 并设置
    [[HXBRootVCManager manager] createRootVCAndMakeKeyWindow];
    
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];

    //设置键盘
    [self keyboardManager];
    
    //友盟分享
    [HXBUMengShareManager umengShareStart];
    
    //方案多个按钮同时点击
    [[UIButton appearance] setExclusiveTouch:YES];
    
    if (HXBShakeChangeBaseUrl == YES) {
        [HXBBaseUrlSettingView attatchToWindow];
    }
    
    return YES;
}

// 检测外键传入的参数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if (!url)  return NO;
    NSString *urlStr = url.absoluteString;
    NSLog(@"handleOpenURL:%@",urlStr);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
    self.exitTime = [NSDate date];
    NSLog(@"%@",application);
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
    
    if ([[HXBRootVCManager manager].versionUpdateModel.force isEqualToString:@"1"]) {
        [HXBAlertManager checkversionUpdateWith:[HXBRootVCManager manager].versionUpdateModel];
    }
    
    NSDate *nowTime = [NSDate date];
    NSTimeInterval timeDifference = [nowTime timeIntervalSinceDate: self.exitTime];
    if (timeDifference > 300) {
        [[HXBRootVCManager manager] enterTheGesturePasswordVCOrTabBar];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_starCountDown object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[HXBUMengShareManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}



- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - 基本设置
//根据服务器时间计算与本地时间的时间差
- (void)serverAndClientTime {
    //......服务器请求数据
    NSString *serverTime;//服务器求情下来之后的服务器时间戳
    HXBServerAndClientTime *serverAndClientTime = [HXBServerAndClientTime sharedServerAndClientTime];
    serverAndClientTime.serverTime = serverTime;
}
///
- (void)judgementApplication {
    if([HXBBaseVersionUpdateManager isFirstStartUPAPP]) {
        NSLog(@"第一次登录程序");
        [KeyChain removeAllInfo];
    }
}

//设置UI友盟统计信息
- (void)setupUmeng {
    [HXBUmengManagar HXB_umengStart];
}

- (void)keyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

- (void)setNetworkConfig
{
    NYNetworkConfig *config = [NYNetworkConfig sharedInstance];
    config.baseUrl = [HXBBaseUrlManager manager].baseUrl;
    
    if (HXBShakeChangeBaseUrl == YES) {
        // 当baseUrl 改变的时候，需要更新 config.baseUrl
        [RACObserve([HXBBaseUrlManager manager], baseUrl) subscribeNext:^(id  _Nullable x) {
            config.baseUrl = x;
        }];
    }
    config.version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:
//(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    //判断app是不是在前台运行，有三个状态(如果不进行判断处理，当你的app在前台运行时，收到推送时，通知栏不会弹出提示的)
//    // UIApplicationStateActive, 在前台运行
//    // UIApplicationStateInactive,未启动app
//    //UIApplicationStateBackground    app在后台
//    
//    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    {  //此时app在前台运行，我的做法是弹出一个alert，告诉用户有一条推送，用户可以选择查看或者忽略
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送消息"
//                                                         message:@"您有一条新的推送消息!"
//                                                        delegate:self
//                                               cancelButtonTitle:@"取消"
//                                               otherButtonTitles:@"查看",nil];
//        [alert show];
//        
//    }
//    
//} else {
//    //这里是app未运行或者在后台，通过点击手机通知栏的推送消息打开app时可以在这里进行处理，比如，拿到推送里的内容或者附加      字段(假设，推送里附加了一个url为 www.baidu.com)，那么你就可以拿到这个url，然后进行跳转到相应店web页，当然，不一定必须是web页，也可以是你app里的任意一个controll，跳转的话用navigation或者模态视图都可以
//}
//
////这里设置app的图片的角标为0，红色但角标就会消失
//[UIApplication sharedApplication].applicationIconBadgeNumber  =  0;
//completionHandler(UIBackgroundFetchResultNewData);
//}
@end

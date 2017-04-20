//
//  HXBServerAndClientTime.h
//  HXBServerAndClientTime
//
//  Created by HXB on 2017/4/20.
//  Copyright © 2017年 HXB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBServerAndClientTime : NSObject
//服务器的时间戳
@property (nonatomic,copy) NSString *serverTime;

//计算后的服务器时间
@property (nonatomic,strong,readonly) NSDate *serverAndClientDate;

//计算后服务器时间的timeInterval
@property (nonatomic,assign) NSTimeInterval serverAndClientTimeInterval;

+ (instancetype) sharedServerAndClientTime;
+ (instancetype) hxbSerVerAndClientTimeWithServerTime: (NSString *)serverTime;
@end

// ------------------- readMe ----------------------
/**
 * 一、应用说明
 * 给我一个服务器的时间戳，自动计算客户端时间与服务器时间的差值
 * 根据差值计算出了服务器时间
 * 所有需要用到的服务器时间 都要通过这个单利类获取
 *
 * 二、应用场景 （主要在APPDelegate中）可以分别请求一下网络数据保证时间的准确性
 * 1.- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {}
    app刚刚启动的时候创建并给出serverTime，内部计算了服务器时间
    这次计算是为了计算服务器时间
 * 2. - (void)applicationWillResignActive:(UIApplication *)application {}
    应用程序变成不激活状态，双击home建，应用程序不在相应用户点击的时候
 * 3. - (void)applicationDidEnterBackground:(UIApplication *)application{}
    应用程序进入到后台的时候调用，双击home建不会调用
 * 4. - (void)applicationWillEnterForeground:(UIApplication *)application{}
    应用程序从后台进入到前台以后调用这个方法， 应用启动不会调用
 * 5. - (void)applicationDidBecomeActive:(UIApplication *)application{}
    应用程序变为激活状态的时候会调用这个方法，（用户可以进行用户交互的时候调用）
 * 6. - (void)applicationWillTerminate:(UIApplication *)application{}
    系统将要推出（终止）的时候调用
 *
 */

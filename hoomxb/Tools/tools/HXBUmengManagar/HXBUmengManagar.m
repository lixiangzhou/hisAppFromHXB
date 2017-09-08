//
//  HXBUmengManagar.m
//  hoomxb
//
//  Created by HXB on 2017/8/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUmengManagar.h"
#import "UMMobClick/MobClick.h"//友盟统计

static NSString *const appKey = @"596359ca5312dd05b4001381";
static NSString *const channelId = @"App Store";


@implementation HXBUmengManagar

/**
 开启友盟统计
 */
+ (void)HXB_umengStart {
    UMConfigInstance.appKey = appKey;
//    UMConfigInstance.ePolicy = BATCH;
    UMConfigInstance.channelId = channelId;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version]; // 设置App的版本
    [MobClick setEncryptEnabled:NO];// 设置是否对日志信息进行加密, 默认NO(不加密).、
    [MobClick setLogEnabled:YES];
}

#pragma mark --- HXBPageController(页面统计)
/**
 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
 
 @param pageView 页面名
 */
+ (void)HXB_beginLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick beginLogPageView:NSStringFromClass(pageView)];
    return;
}

/**
 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
 
 @param pageView 页面名
 */
+ (void)HXB_endLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick endLogPageView:NSStringFromClass(pageView)];
    return;
}

#pragma mark --- HXBClickEvent(点击事件统计)

/**
 统计发生次数
 
 @param enevtid 事件id
 */
+ (void)HXB_clickEventWithEnevtId:(NSString *)enevtid {
    [MobClick event:enevtid];
    return;
}

/**
 统计发生次数

 @param enevtid 事件id
 @param string 备注事件
 */
+ (void)HXB_clickEventWithEnevtId:(NSString *)enevtid string:(NSString *)string {
    [MobClick event:enevtid label:string];
    return;
}

/**
 统计点击行为各属性被触发的次数
 
 @param enevtid 事件id
 @param attributes 事件的属性和取值
 */
+ (void)HXB_clickEventWithEnevtId:(NSString *)enevtid attributes:(NSDictionary *)attributes {
    [MobClick event:enevtid attributes:attributes];
    return;
}


/**
 计算事件
 
 @param enevtid 事件id
 @param attributes 事件的属性和取值
 @param number 金额、数量等参数
 */
+ (void)HXB_clickEventWithEnevtId:(NSString *)enevtid attributes:(NSDictionary *)attributes counter:(int)number {
    [MobClick event:enevtid attributes:attributes counter:number];
    return;
}


@end

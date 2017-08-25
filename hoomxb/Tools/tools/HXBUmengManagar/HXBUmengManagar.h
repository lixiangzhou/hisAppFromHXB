//
//  HXBUmengManagar.h
//  hoomxb
//
//  Created by HXB on 2017/8/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBUmengManagar : NSObject


/**
 开启友盟统计
 */
+ (void)HXB_umengStart;


#pragma mark --- HXBPageController(页面统计)
/**
 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据

 @param pageView 页面名
 */
+ (void)HXB_beginLogPageView:(__unsafe_unretained Class)pageView;

/**
 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据

 @param pageView 页面名
 */
+ (void)HXB_endLogPageView:(__unsafe_unretained Class)pageView;

#pragma mark --- HXBClickEvent(点击事件统计)

/**
 统计发生次数

 @param enevtid 事件id
 */
+ (void)HXB_clickEventWithEnevtId:(NSString *)enevtid;

/**
 统计发生次数
 
 @param enevtid 事件id
 @param string 备注事件
 */
+ (void)HXB_clickEventWithEnevtId:(NSString *)enevtid string:(NSString *)string;

/**
 统计点击行为各属性被触发的次数

 @param enevtid 事件id
 @param attributes 事件的属性和取值
 */
+ (void)HXB_clickEventWithEnevtId:(NSString *)enevtid attributes:(NSDictionary *)attributes;


/**
 计算事件

 @param enevtid 事件id
 @param attributes 事件的属性和取值
 @param number 金额、数量等参数
 */
+ (void)HXB_clickEventWithEnevtId:(NSString *)enevtid attributes:(NSDictionary *)attributes counter:(int)number;





@end

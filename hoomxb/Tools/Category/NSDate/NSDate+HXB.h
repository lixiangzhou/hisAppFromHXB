//
//  NSDate+HXB.h
//  hoomxb
//
//  Created by lxz on 2017/11/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HXB)
/// 毫秒级时间
+ (NSString *)milliSecondSince1970;
/// 获取当前时间
+ (NSString *)currentDateStr;
/// 获取当前时间戳
+ (NSString *)currentTimeStr;
/// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
+ (NSString *)getDateStringWithTimeStr:(NSString *)str;
/// 字符串转时间戳 如：2017-4-10 17:15:10
+ (NSString *)getTimeStrWithString:(NSString *)str;
/// 传入date，返回此天的0时0分0秒时间
+ (NSDate *)getDayZeroTimestamp:(NSDate *)aDate;
@end

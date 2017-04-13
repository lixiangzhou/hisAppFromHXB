//
//  NSDate+MTCompareDate.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/23.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

//利用运行时添加属性

@interface NSDate (CompareDate)


/** 
 * 关于时间与当前时间 比较早晚 的方法
 * date_OBJ : 传入一个字符串或者时间对象
 */
+ (BOOL)isLateCurrentDateWithDate: (NSObject *)date_OBJ;



/**
 * 关于对象转化成对象的方法
 * date_OBJ: 一个对象
 * 如果 转化失败，那么返回nil，并打印无法转化
 */
+ (NSDate *)returnDateWithOBJ: (NSObject *)date_OBJ;




/**
 * 关于两个时间差的方法
 * CompareDate: 比较的 第一个时间
 * forcedCompareDate: 比较的第二个时间
 * block返回的是第一个时间 减去第二个时间
 * 返回值是 差的时间；
 */
+ (NSString *)compareDateWithCompareDate: (NSString *)startTime andSecondCompareDate: (NSString *)endTime andDateBlock: (void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour,NSInteger minute, NSInteger second))dateBlock;

/**
 * 关于两个时间差的方法
 * CompareDate: 比较的 第一个时间
 * forcedCompareDate: 比较的第二个时间
 * 返回的是第一个时间 减去第二个时间
 */
- (void)compareDateWithCompareDate: (NSString *)startTime andSecondCompareDate: (NSString *)endTime andDateBlock: (void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour,NSInteger minute, NSInteger second))dateBlock;


@end

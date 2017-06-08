//
//  HXBBaseHandDate.h
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>


/**枚举，表示返回的是早或晚些的时间*/
typedef enum : NSUInteger {
    HXBHandleCompareType_returnLittle,//返回较晚时间
    HXBHandleCompareType_returnLong,//返回较早时间
} PYHandleCompareType;




@interface HXBBaseHandDate : NSObject



//单利
+ (instancetype) sharedHandleDate;

/**
 * 根据字符串生成时间
 * param: format 生成的字符串格式 默认yyyy-MM-dd HH:mm:ss
 */
- (NSString *) stringFromDate:(NSObject *)dateObj andDateFormat: (NSString *)format;


/**
 * 关于时间与当前时间 比较早晚 的方法
 * @param date_OBJ : 传入一个字符串或者时间对象
 */
- (BOOL)isLateCurrentDateWithDate: (NSObject *)date_OBJ andDateForMatter: (NSString *)dateForMatter;



/**
 * 传入一个对象 获取对应的时间
 * date 对象（将被转化成时间对象）
 * dateFormatter 时间格式
 * dateBlock 转化成时间后的年月日
 */
#pragma mark - 获取时间的年月日
- (void)getDate: (NSObject *)getDate andDateFormatter: (NSString *)dateFormatter andDateBlock: (void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour,NSInteger minute, NSInteger second))dateBlock;



/**
 * 关于对象转化成对象的方法
 * date_OBJ: 一个对象
 * 如果 转化失败，那么返回nil，并打印无法转化
 */
- (NSDate *)returnDateWithOBJ: (NSObject *)date_OBJ andDateFormatter: (NSString *)dateFormatterStr;



/**
 * 关于两个时间差的方法
 * CompareDate: 比较的 第一个时间
 * forcedCompareDate: 比较的第二个时间
 * block返回的是第一个时间 减去第二个时间
 * 返回值是 差的时间；
 */
#pragma mark - 两个时间相比的差值
- (NSString *)compareDateWithandDateFormatter: (NSString *)dateFormatterStr andCompareDate: (NSObject *)startTime andSecondCompareDate: (NSObject *)endTime andDateBlock: (void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour,NSInteger minute, NSInteger second))dateBlock;

@end

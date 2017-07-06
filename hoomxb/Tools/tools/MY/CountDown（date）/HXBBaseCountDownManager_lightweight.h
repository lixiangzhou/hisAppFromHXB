//
//  HXBBaseCountDownManager_ lightweight.h
//  hoomxb
//
//  Created by HXB on 2017/6/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

/**
 1 主要是给一个要倒计时的str的指针，然后在设置一些倒计时条件
 2 给一个string标识 内部进行了缓存，缓存了这个对象当缓存中没有标识对象的时候，定时器停止，当加入缓存时，查看定时器是否开启，
 */

#import <Foundation/Foundation.h>

/** 比较类型 */
typedef enum : NSUInteger {
    ///结束时间点 基于 1970 年
    HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType_1970,
    ///结束时间点 基于 现在的时间点
    HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType_Now
} HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType;


///主要是管理了项目中轻量的倒计时，
@interface HXBBaseCountDownManager_lightweight : NSObject

/**注释参见 init 构造方法*/
+ (instancetype) countDownManagerWithCountDownEndTime: (CGFloat)countDownEndTime
                              andCountDownEndTimeType: (HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType) endTimeCompareType
                                 andCountDownDuration: (CGFloat)countDownDuration
                                     andCountDownUnit: (CGFloat) countDownUnint;
/**
 轻量倒计时管理
 * @param countDownEndTime 停止时间
 * @param endTimeCompareType 倒计时停止时间是基于 哪个时间节点，默认1970
 * @param countDownDuration 倒计时时长
 * @param countDownUnint 倒计时单位 秒为单位
 */
- (instancetype) initWithCountDownEndTime: (CGFloat)countDownEndTime
                  andCountDownEndTimeType: (HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType) endTimeCompareType
                     andCountDownDuration: (CGFloat)countDownDuration
                         andCountDownUnit: (CGFloat) countDownUnint;

///是否自动关闭定时
@property (nonatomic,assign) BOOL isAutoStopTimer;

///计时回调
- (void)countDownCallBackFunc: (void(^)(CGFloat countDownValue))countDownCallBackBlock;
///开启定时器
- (void) resumeTimer;
///关闭定时器
- (void) stopTimer;
@end

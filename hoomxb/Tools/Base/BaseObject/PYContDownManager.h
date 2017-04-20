//
//  PYTextModel.m
//  PYCountDown
//
//  Created by 李鹏跃 on 2017/4/19.
//  Copyright © 2017年 李鹏跃. All rights reserved.
//



//注意 需要做倒计时的model的储存剩余时间变量的key一定要是NSString类型
#import <UIKit/UIKit.h>
@class PYCountDownModel;

///传入的model中的用于倒计时时间的参数是剩余时间还是原始时间。
///如果是原始时间的话，还要比较时间差，然后在判断符不符合倒计时标准
typedef enum : NSUInteger {
    PYContDownManagerModelDateType_Remainder = 0,
    PYContDownManagerModelDateType_OriginalTime = 1,
} PYContDownManagerModelDateType;



@interface PYContDownManager : NSObject

/**
 * 请用这个方法（或者对应的init方法）创建对象
 * @parma countDownStartTime 剩多长时间开始倒计时
 * @parma countDownUnit 倒计时单位时间
 * @parma modelArray 需要倒计时的model数组
 * @parma modelDateKey model储存到期时间的属性名
 * @parma modelCountDownKey model储存剩余时间的属性名
 * @parma modelDateType model中储存的到期时间是否为剩余时间
 */
+ (instancetype)countDownManagerWithCountDownStartTime: (long)countDownStartTime andCountDownUnit: (double)countDownUnit andModelArray: (NSArray *)modelArray andModelDateKey: (NSString *)modelDateKey andModelCountDownKey: (NSString *)modelCountDownKey andModelDateType: (PYContDownManagerModelDateType)modelDateType;
/**
 * 请用这个方法（或者对应的init方法）创建对象
 * @parma countDownStartTime 剩多长时间开始倒计时
 * @parma countDownUnit 倒计时单位时间
 * @parma modelArray 需要倒计时的model数组
 * @parma modelDateKey model储存到期时间的属性名
 * @parma modelCountDownKey model储存剩余时间的属性名
 * @parma modelDateType model中储存的到期时间是否为剩余时间
 */
- (instancetype)initWithCountDownStartTime: (long)countDownStartTime andCountDownUnit: (double)countDownUnit andModelArray: (NSArray *)modelArray andModelDateKey: (NSString *)modelDateKey andModelCountDownKey: (NSString *)modelCountDownKey andModelDateType: (PYContDownManagerModelDateType)modelDateType;


/**
 * 没次单位时间过后就会掉一次，可以在这里刷新UI（已经回到了主线程）
 * @param countdownDataFredbackWithBlock 给外界提供了modelarray
 */
- (void)countdownDataFredbackWithBlock: (void(^)())countdownDataFredbackWithBlock;


/**
 * 取消定时器
 */
- (void)cancelTimer;
/**
 *开启定时器
 */
- (void)resumeTimer;
@end

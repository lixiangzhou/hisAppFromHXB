//
//  HXBNsTimerManager.h
//  hoomxb
//
//  Created by caihongji on 2017/12/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

//倒计时的block定义
typedef void (^CountDownBlock)(NSString* times);

@interface HXBNsTimerManager : NSObject

/**
 是否正在计时
 */
@property (nonatomic, assign, readonly) BOOL isTimerWorking;

/**
 创建定时器

 @param ti 间隔时间
 @param ts 起始时间。
 @param countDownTime 是否倒计时。
 @param countDownBlock 回调。如果是正常计时，返回累加时间； 否则，返回剩余时间
 @return 定时器管理对象
 */
+ (instancetype)createTimer:(NSTimeInterval)ti startSeconds:(NSTimeInterval)ts countDownTime:(BOOL)isCountDown notifyCall:(CountDownBlock)countDownBlock;

- (void)startTimer;

- (void)stopTimer;
@end

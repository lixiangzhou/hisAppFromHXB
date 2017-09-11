//
//  HXBBaseCountDownManager_ lightweight.m
//  hoomxb
//
//  Created by HXB on 2017/6/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseCountDownManager_lightweight.h"

#import <objc/runtime.h>

typedef void(^block) (NSString *countDownValue);

@interface HXBBaseCountDownManager_lightweight ()
@property (nonatomic,strong) dispatch_queue_t countDownManager_lightweightQueue;

@property (nonatomic,strong) dispatch_source_t timer;
///类型
@property (nonatomic,assign) HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType type;
///定时单位
@property (nonatomic,assign) CGFloat countDownUnit;
///定时结束时间
//@property (nonatomic,assign) CGFloat countDownEndTime;
///当前时间
@property (nonatomic,assign) CGFloat countDownResumeTime;
///时长
@property (nonatomic,assign) CGFloat countDownDuration;
///倒计时 时差
@property (nonatomic,assign) CGFloat countDownValue;
///倒计时回调
@property (nonatomic,copy) void(^countDownCallBack)(CGFloat countDownValue);

@end


@implementation HXBBaseCountDownManager_lightweight

+ (instancetype) countDownManagerWithCountDownEndTime: (CGFloat)countDownEndTime
                              andCountDownEndTimeType: (HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType) endTimeCompareType
                                 andCountDownDuration: (CGFloat)countDownDuration
                                     andCountDownUnit: (CGFloat) countDownUnint
{
    return [[self alloc]initWithCountDownEndTime:countDownEndTime
                         andCountDownEndTimeType:endTimeCompareType
                            andCountDownDuration:countDownDuration
                                andCountDownUnit:countDownUnint];
}

/**
 轻量倒计时管理
 * @param countDownEndTime 停止时间
 * @param endTimeCompareType 倒计时停止时间是基于 哪个时间节点，默认1970
 * @param countDownDuration 倒计时时长
 * @param countDownUnint 倒计时单位
 */
- (instancetype) initWithCountDownEndTime: (CGFloat)countDownEndTime
                  andCountDownEndTimeType: (HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType) endTimeCompareType
                     andCountDownDuration: (CGFloat)countDownDuration
                         andCountDownUnit: (CGFloat) countDownUnint

{
    if (self = [super init]) {
        self.type = endTimeCompareType;
        self.countDownEndTime = countDownEndTime;
        self.countDownDuration = countDownDuration;
        self.countDownUnit = countDownUnint;
        self.isAutoStopTimer = true;
    }
    return self;
}

- (dispatch_queue_t)countDownManager_lightweightQueue {
    if (!_countDownManager_lightweightQueue) {
        _countDownManager_lightweightQueue = dispatch_get_global_queue(0, 0);
    }
    return _countDownManager_lightweightQueue;
}

- (dispatch_source_t)timer {
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.countDownManager_lightweightQueue);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, NSEC_PER_SEC *self.countDownUnit, 0);
        dispatch_source_set_event_handler(_timer, ^{
            [self setUP];
        });
        dispatch_resume(_timer);
    }
    return _timer;
}

- (CGFloat) countDownResumeTime {
    return [NSDate date].timeIntervalSince1970;
}
- (void) resumeTimer {
    [self timer];
}

- (void) stopTimer {
    dispatch_cancel(self.timer);
    self.timer = nil;
}

- (void)setUP {
    //当前在子线程
    CGFloat actualDuration = 0.0;
    switch (self.type) {
        case HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType_Now:
            actualDuration = self.countDownEndTime --;
            break;
        case HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType_1970:
            actualDuration = self.countDownEndTime - self.countDownResumeTime;
            break;
        default:
            break;
    }
    if (actualDuration <= self.countDownDuration) {
        self.countDownValue =  actualDuration;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.countDownCallBack) {
                self.countDownCallBack(self.countDownValue);
            }
        });
        return;
    }
    if (self.isAutoStopTimer && self.countDownValue < 0) {
        [self stopTimer];
    }
}
///countDown 回调
- (void)countDownCallBackFunc: (void(^)(CGFloat countDownValue))countDownCallBackBlock {
    self.countDownCallBack = countDownCallBackBlock;
}
@end

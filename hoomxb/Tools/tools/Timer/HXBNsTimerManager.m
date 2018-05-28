//
//  HXBNsTimerManager.m
//  hoomxb
//
//  Created by caihongji on 2017/12/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBNsTimerManager.h"
#import "NSTimer+Addition.h"

@interface HXBNsTimerManager() {
    NSTimeInterval _entryBackGroundStartInterval;//记录进入后台的开始时间
    NSTimeInterval _recordTimes;//记录累加/累减时间
}

@property (nonatomic, strong) NSTimer* timer;
/**
 倒计时的回调
 */
@property (nonatomic, strong) CountDownBlock countDownBlock;

/**
 总时间
 */
@property (nonatomic, assign) NSTimeInterval totalSeconds;
/**
 间隔时间
 */
@property (nonatomic, assign) NSTimeInterval repeatSecond;
/**
 是否是倒计时
 */
@property (nonatomic, assign) BOOL isCountDown;
@end

@implementation HXBNsTimerManager

+ (instancetype)createTimer:(NSTimeInterval)ti startSeconds:(NSTimeInterval)ts countDownTime:(BOOL)isCountDown notifyCall:(CountDownBlock)countDownBlock
{
    HXBNsTimerManager* manager = [[HXBNsTimerManager alloc] init];
    manager.totalSeconds = ts;
    manager.repeatSecond = ti;
    manager.countDownBlock = countDownBlock;
    manager.isCountDown = isCountDown;
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEntryForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(entryBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)entryBackground:(NSNotification*)notify
{
    [self.timer pauseTimer];
    _entryBackGroundStartInterval = [NSDate timeIntervalSinceReferenceDate];
}

- (void)willEntryForeground:(NSNotification*)notify
{
    double diffTime = [NSDate timeIntervalSinceReferenceDate] - _entryBackGroundStartInterval;
    [self timeDeal:diffTime];
    [self.timer resumeTimer];
}

- (BOOL)isTimerWorking {
    return _timer==nil? NO : YES;
}

- (void)timeDeal:(NSTimeInterval)diffTime
{
    BOOL isStopTimer = NO;
    if(self.isCountDown) {//倒计时
        _recordTimes -= diffTime;
        if(_recordTimes <= 0) {
            _recordTimes = 0;
            isStopTimer = YES;
        }
    }
    else{
        _recordTimes += diffTime;
        if(self.totalSeconds>0 && _recordTimes>=self.totalSeconds) {
            _recordTimes = self.totalSeconds;
            isStopTimer = YES;
        }
    }
    if(_timer && self.countDownBlock) {
        self.countDownBlock([NSString stringWithFormat:@"%ld", (NSInteger)_recordTimes]);
    }
    if(isStopTimer) {
        [self stopTimer];
    }
}

- (void)timeFire
{
    [self timeDeal:self.repeatSecond];
}

- (void)startTimer
{
    if(!_timer) {
        self.timer = [NSTimer timerWithTimeInterval:self.repeatSecond target:self selector:@selector(timeFire) userInfo:nil repeats:YES];
        if(self.isCountDown){
            _recordTimes = self.totalSeconds+self.repeatSecond;
        }
        else{
            _recordTimes = 0-self.repeatSecond;
        }
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [self.timer fire];
    }
}

- (void)stopTimer
{
    if(_timer) {
        [self.timer invalidate];
        _timer = nil;
    }
}
@end

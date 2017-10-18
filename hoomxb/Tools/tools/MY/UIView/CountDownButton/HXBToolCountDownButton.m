//
//  HXBToolCountDownButton.m
//  hoomxb
//
//  Created by HXB on 2017/6/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBToolCountDownButton.h"

@interface HXBToolCountDownButton ()
///定时器
@property (nonatomic,strong) NSTimer *timer;
///倒计时的总秒数
@property (nonatomic,assign) long k_countDownNumber;
///倒计时停止的时候的回调方法
@property (nonatomic,copy) void (^timerExpireBlock)();
///倒计时时候的回调
@property (nonatomic,copy) void(^countDownBlock)(NSString *remainingTime);

@end

@implementation HXBToolCountDownButton
///选中状态
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.userInteractionEnabled = !selected;
    if (selected) {
        [self.timer fire];
    }
}

/// gtter timer
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.countDownVelocity target:self selector:@selector(countDownFunc) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

///记录倒计时最大时间
- (void)setCountDownNumber:(long)countDownNumber {
    _countDownNumber = countDownNumber;
    _k_countDownNumber = countDownNumber;
}

///倒计时的方法
- (void)countDownFunc {
    self.k_countDownNumber -= self.countDownVelocity;
    if (self.countDownBlock) {
        self.countDownBlock(@(self.k_countDownNumber).description);
    }else {
        [self setTitle:@(self.k_countDownNumber).description forState:UIControlStateNormal];
    }
    if (self.k_countDownNumber <= 0 ) {
        self.userInteractionEnabled = true;
        self.k_countDownNumber = self.countDownNumber;
        ///销毁timer
        [self deallocTimer];
    }
}

///销毁倒计时
- (void)deallocTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

///倒计时到期
- (void)timerExpireWithBlock:(void (^)())timerExpireBlock {
    self.timerExpireBlock = timerExpireBlock;
}

///倒计时时候的回调
- (void)countDownWithBlock:(void (^)(NSString * remainingTime))countDownBlock {
    self.countDownBlock = countDownBlock;
}
@end

//
//  HXBToolCountDownButton.h
//  hoomxb
//
//  Created by HXB on 2017/6/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBToolCountDownButton : UIButton
///倒计时的总秒数
@property (nonatomic,assign) long countDownNumber;
///倒计时的速度
@property (nonatomic,assign) long countDownVelocity;
///倒计时停止的时候的回调方法
- (void)timerExpireWithBlock: (void(^)())timerExpireBlock;


///倒计时时候的回调 (不实现就默认为显示剩余时间)
- (void)countDownWithBlock:(void (^)(NSString * remainingTime))countDownBlock;
@end

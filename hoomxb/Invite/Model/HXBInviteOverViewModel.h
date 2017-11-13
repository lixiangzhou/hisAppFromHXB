//
//  HXBInviteOverViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBInviteOverViewModel : NSObject

// 优惠券总张数
@property (nonatomic, assign) NSInteger couponNumber;
// 邀请总人数
@property (nonatomic, assign) NSInteger inviteNumber;
// 返现金额
@property (nonatomic, copy) NSString *cashBackAmount;

@end

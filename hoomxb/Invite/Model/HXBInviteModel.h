//
//  HXBInviteModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBInviteModel : NSObject

// 好友的手机号
@property (nonatomic, copy) NSString *invitedUserPhoneNo;
// 好友真实姓名
@property (nonatomic, copy) NSString *invitedRealName;
// 注册时间
@property (nonatomic, assign) double registTime;
// 优惠券（最大可抵扣/满减）金额
@property (nonatomic, copy) NSString *couponAmount;
// 奖励的优惠券数量
@property (nonatomic, assign) NSInteger couponCount;
// 直接返现金额
@property (nonatomic, copy) NSString *directlyCashBackAmount;
// 间接返现金额
@property (nonatomic, copy) NSString *indirectCashBackAmount;
// 邀请好友奖励（奖励文案包括红包数、红包金额、直接返现金额、间接返现金额等信息，node层进行拼接后返回，具体文案，产品确定后告知（待他们确认好ui图后确定））
@property (nonatomic, copy) NSString *rewardDesc;

// 好友真实姓名
@property (nonatomic, copy) NSString *invitedRealName_new;
// 好友的手机号
@property (nonatomic, copy) NSString *invitedUserPhoneNo_new;
// 注册时间 hxb_hiddenPhonNumberWithMid
@property (nonatomic, copy) NSString *registTime_new;

@end

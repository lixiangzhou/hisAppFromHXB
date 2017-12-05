//
//  HXBFin_LoanTruansfer_BuyResoutViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
@interface HXBFin_LoanTruansfer_BuyResoutViewModel : HXBBaseViewModel

/** 是否开启活动 */
@property (nonatomic, assign) BOOL isInviteActivityShow;
/** 邀请活动的文案 */
@property (nonatomic, copy) NSString *inviteActivityDesc;
/**
 投资金额
 */
@property (nonatomic,copy) NSString *buyAmount;

/**
 实际买入本金
 */
@property (nonatomic,copy) NSString * principal;
/**
 公允利息
 */
@property (nonatomic,copy) NSString * interest;
/**
 是否当期已还：
 1为已还，
 0为未还
 */
@property (nonatomic,assign) BOOL isRepayed;

/**
 下一个还款日
 */
@property (nonatomic,copy) NSString *nextRepayDate;
/**
 下一个还款日_new
 */
@property (nonatomic,copy) NSString *nextRepayDate_new;
/**
 投资金额_new
 */
@property (nonatomic,copy) NSString *buyAmount_new;
/**
 公允利息_new
 */
@property (nonatomic,copy) NSString *interest_new;
/**
 实际买入本金_new
 */
@property (nonatomic,copy) NSString *principal_new;

@end

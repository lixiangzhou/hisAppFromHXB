//
//  HXBFinDetailViewModel_PlanDetail.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinDetailModel_PlanDetail;
///红利计划详情页ViewModel
@interface HXBFinDetailViewModel_PlanDetail : NSObject
@property (nonatomic,strong) HXBFinDetailModel_PlanDetail *planDetailModel;
///String	单笔加入上线
@property (nonatomic,copy) NSString *singleMaxRegisterAmount;
///String	开始销售时间
@property (nonatomic,copy) NSString *beginSellingTime;
///String	进入锁定期时间
@property (nonatomic,copy) NSString *financeEndTime;

///计划期限（锁定期）
@property (nonatomic,copy) NSString *lockPeriod;
///": "理财计划服务协议",
@property (nonatomic,copy) NSString *contractName;
/// 剩余金额
@property (nonatomic,copy) NSString *remainAmount;
///剩余金额
@property (nonatomic,copy) NSString *remainAmount_constStr;
///剩余可追加金额
@property (nonatomic,copy) NSString *userRemainAmount;

///起投
@property (nonatomic,copy) NSString *minRegisterAmount;
///加入条件加入金额%@元起，%@元的整数倍递增
@property (nonatomic,copy) NSString *addCondition;

///本期计划加入上线//1.加入上限：金额随用户实际的可加入金额变动，e.g.用户第一次投该期红利计划，显示为“本期计划加入上限50,000元”,用户投资30000元后，第二次追加进到该页面，显示“本期计划加入上限20,000元”，加入上限>计划剩余可投资金额时，显示计划剩余可投资金额
@property (nonatomic,copy) NSString *hxb_singleMaxRegisterAmount;


///立即加入的String
@property (nonatomic,copy) NSString *addButtonStr;
/// 倒计时的 string
@property (nonatomic,copy) NSString *countDownStr;

///加入按钮是否置灰
@property (nonatomic,assign) BOOL isAddButtonInteraction;

///收益方式UI
@property (nonatomic,copy) NSString *profitType_UI;
///收益方式
@property (nonatomic,copy) NSString *profitType;

///已经收益
@property (nonatomic,copy) NSString *earnInterest;

///收益的 比例
@property (nonatomic,copy) NSString *totalInterest;

///总资金
@property (nonatomic,copy) NSString *amount;

/// remainAmount_const
@property (nonatomic,copy) NSString *remainAmount_const;
/// 计划期限
@property (nonatomic,copy) NSString *lockPeriodStr;
@end

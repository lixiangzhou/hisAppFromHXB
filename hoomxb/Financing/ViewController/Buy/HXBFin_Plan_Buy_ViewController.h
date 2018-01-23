//
//  HXBFin_Plan_Buy_ViewController.h
//  hoomxb
//
//  Created by 肖扬 on 2017/11/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@interface HXBFin_Plan_Buy_ViewController : HXBBaseViewController
@property (nonatomic,assign) BOOL isFirstBuy; // 是否第一次购买
@property (nonatomic,copy) NSString *availablePoint; // 待转让金额
@property (nonatomic,copy) NSString *placeholderStr; // 占位符
@property (nonatomic,copy) NSString *loanId; // 标的 id
@property (nonatomic,copy) NSString *cashType; // 收益方式
@property (nonatomic,copy) NSString *totalInterest; // 预期收益
@property (nonatomic,copy) NSString *registerMultipleAmount; // 最小倍数
@property (nonatomic,copy) NSString *minRegisterAmount; // 最小起投
/** 还款方式 */
@property (nonatomic, copy) NSString *featuredSlogan;
@property (nonatomic, copy) NSString *hasBindCard; //是否绑卡
@property (nonatomic, assign) BOOL isNewComer; // 是否是新手计划

@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;    // 用户信息
@property (nonatomic, copy) NSString *riskType;     // 风险类型
@end

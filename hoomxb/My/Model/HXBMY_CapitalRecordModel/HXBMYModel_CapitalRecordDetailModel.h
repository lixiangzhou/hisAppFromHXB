//
//  HXBMYModel_CapitalRecordDetailModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///关于资金统计的 详情页 的Model
@interface HXBMYModel_CapitalRecordDetailModel : NSObject

///资金记录显示类型
@property (nonatomic,strong) NSString *pointDisplayType;
///是否是收入
@property (nonatomic,strong) NSString *isPlus;
///收入金额
@property (nonatomic,strong) NSString *income;
///支出金额
@property (nonatomic,strong) NSString *pay;
///金额
@property (nonatomic,strong) NSString *amount;
///账户余额
@property (nonatomic,strong) NSString *balance;
///交易时间
@property (nonatomic,strong) NSString *time;
///摘要
@property (nonatomic,strong) NSString *notes;
///标id
@property (nonatomic,strong) NSString *loanId;
///标的标题
@property (nonatomic,strong) NSString *loanTitle;
///理财计划id
@property (nonatomic,strong) NSString *financePlanId;
///理财计划名称
@property (nonatomic,strong) NSString *financePlanName;
///理财计划子账户id
@property (nonatomic,strong) NSString *financePlanSubPointId;
/**
 按月分组标签
 */
@property (nonatomic, copy) NSString *tag;
@end

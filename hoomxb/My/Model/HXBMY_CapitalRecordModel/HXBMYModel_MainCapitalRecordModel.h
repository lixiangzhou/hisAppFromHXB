//
//  HXBMYModel_MainCapitalRecordModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBMYModel_MainCapitalRecordModel_dataList;
///关于资产记录的model
@interface HXBMYModel_MainCapitalRecordModel : NSObject
///总数
@property (nonatomic,copy) NSString *totalCount;
@property (nonatomic,strong) NSArray <HXBMYModel_MainCapitalRecordModel_dataList*> *dataList;
@end



/// 关于资金记录的model 里面的datalist
@interface HXBMYModel_MainCapitalRecordModel_dataList : NSObject
///资金记录显示类型
@property (nonatomic,copy) NSString *pointDisplayType;
///是否是收入
@property (nonatomic,copy) NSString *isPlus;
///收入金额
@property (nonatomic,copy) NSString *income;
///支出金额
@property (nonatomic,copy) NSString *pay;
///金额
@property (nonatomic,copy) NSString *amount;
///账户余额
@property (nonatomic,copy) NSString *balance;
///交易时间
@property (nonatomic,copy) NSString *time;
///摘要
@property (nonatomic,copy) NSString *notes;
///标id
@property (nonatomic,copy) NSString *loanId;
///标的标题
@property (nonatomic,copy) NSString *loanTitle;
///理财计划id
@property (nonatomic,copy) NSString *financePlanId;
///理财计划名称
@property (nonatomic,copy) NSString *financePlanName;
///理财计划子账户id
@property (nonatomic,copy) NSString *financePlanSubPointId;

@end

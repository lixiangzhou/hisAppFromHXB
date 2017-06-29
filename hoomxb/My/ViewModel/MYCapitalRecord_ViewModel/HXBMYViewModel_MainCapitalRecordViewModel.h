//
//  HXBMYViewModel_MainCapitalRecordViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"
@class HXBMYModel_CapitalRecordDetailModel;
/**交易记录筛选条件*/
typedef enum : NSUInteger {
    ///充值
    HXBRequestType_MY_tradlist_TopUp,
    ///提现
    HXBRequestType_MY_tradlist_WithdrawCash,
    ///散标债权
    HXBRequestType_MY_tradlist_Loan,
    ///红利计划
    HXBRequestType_MY_tradlist_Plan
} HXBRequestType_MY_tradlist;



///关于资金列表的ViewModel
@interface HXBMYViewModel_MainCapitalRecordViewModel : NSObject
@property (nonatomic,strong) HXBMYModel_CapitalRecordDetailModel *capitalRecordModel;
///账户余额
@property (nonatomic,copy) NSString *balance;
///时间
@property (nonatomic,copy) NSString *time;
///收入金额 （支出金额为负数）
@property (nonatomic,copy) NSString *income;
/// 支出为绿色，收入为红色
@property (nonatomic,strong) UIColor *inComeStrColor;
@end



//
//  HXBMYViewModel_PlanDetailViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYViewModel_PlanDetailViewModel.h"
#import "HXBRequestType_MYManager.h"

static NSString *kHXBUI = @"当日提取至红小宝账户";
static NSString *kINVESTUI = @"收益再投资";
static NSString *kHXB = @"HXB";
static NSString *kINVEST = @"INVEST";

@implementation HXBMYViewModel_PlanDetailViewModel
- (void)setPlanDetailModel:(HXBMYModel_PlanDetailModel *)planDetailModel {
    _planDetailModel = planDetailModel;
    if([planDetailModel.cashType isEqualToString:kHXB]) {
        self.cashType = kHXBUI;
    }
    if ([planDetailModel.cashType isEqualToString:kINVEST]) {
        self.cashType = kINVEST;
    }
    self.contractName = [NSString stringWithFormat:@"《%@》",planDetailModel.contractName];
}
/**
已获收益
 */
- (NSString *) inComeLable_ConstStr {
    if (!_inComeLable_ConstStr) {
        _inComeLable_ConstStr = @"已获收益";
    }
    return _inComeLable_ConstStr;
}
/**
 加入时间
 */
- (NSString *) addTime {
    if (!_addTime) {
        _addTime = [[HXBBaseHandDate sharedHandleDate] stringFromDate:self.planDetailModel.registerTime andDateFormat:@"yyyy-MM-dd"];
    }
    return _addTime;
}
/**
 期限
 */
- (NSString *) lockTime {
    if (!_lockTime) {
        
        _lockTime = [NSString stringWithFormat:@"%@个月",self.self.planDetailModel.lockPeriod];
    }
    return _lockTime;
}
/**
 收益方式
 */
- (NSString *) cashType {
    if (!_cashType){
        ///	string	处理方式 （HXB：当日提取至红小宝账户，INVEST：收益再投资）
        if ([self.planDetailModel.cashType isEqualToString:@"HXB"]) {
            _cashType = @"当日提取至红小宝账户";
        }
        if ([self.planDetailModel.cashType isEqualToString:@"INVEST"]){
            _cashType = @"收益再投资";
        }
    }
    return _cashType;
}
///以收益
- (NSString *) earnAmount {
    if(!_earnAmount) {
        _earnAmount = [NSString GetPerMilWithDouble:self.planDetailModel.earnAmount.floatValue];
    }
    return _earnAmount;
}
///年利率
- (NSString *)expectedRate {
    if (!_expectedRate) {
        _expectedRate = [NSString stringWithFormat:@"%@%",self.planDetailModel.expectedRate];
    }
    return _expectedRate;
}
@end

//
//  HXBFinDetailViewModel_PlanDetail.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDetailModel_PlanDetail.h"
@implementation HXBFinDetailViewModel_PlanDetail
- (void)setPlanDetailModel:(HXBFinDetailModel_PlanDetail *)planDetailModel {
    _planDetailModel = planDetailModel;
 
    [self setUPBeginSellingTime];///开始时间
    [self setUPFinanceEndTime];///退出时间
    [self setUPLockPeriod];///计划期限
    [self setUPUserRemainAmount];///剩余可追加金额
    [self setUPRemainAmount];///剩余可投
    [self setUPhxb_SingleMaxRegisterAmount];///本期计划加入上限
    [self setUPAddButtonStr];
}


 //加入上线

- (NSString *)singleMaxRegisterAmount {
    if (!_singleMaxRegisterAmount) {
        _singleMaxRegisterAmount = [NSString hxb_getPerMilWithDouble: self.planDetailModel.singleMaxRegisterAmount.floatValue];
    }
    return _singleMaxRegisterAmount;
}
///开始时间
- (void)setUPBeginSellingTime {
    self.beginSellingTime = [[HXBBaseHandDate sharedHandleDate] stringFromDate:self.planDetailModel.beginSellingTime andDateFormat:@"yyyy-MM-dd"];
}
///退出时间
- (void)setUPFinanceEndTime {
    self.financeEndTime = [[HXBBaseHandDate sharedHandleDate] stringFromDate:self.planDetailModel.financeEndTime andDateFormat:@"yyyy-MM-dd"];
}

- (NSString *)description {
    return [self yy_modelDescription];
}
///计划期限（锁定期）
- (void)setUPLockPeriod {
    self.lockPeriod = [NSString stringWithFormat:@"%@个月",self.planDetailModel.lockPeriod];
}

/**
服务协议
 */
- (NSString *) contractName {
    if (!_contractName) {
        _contractName = [NSString stringWithFormat:@"《%@》",self.planDetailModel.contractName];
    }
    return _contractName;
}
///剩余可投
- (void)setUPRemainAmount {
    self.remainAmount = [NSString hxb_getPerMilWithDouble:self.planDetailModel.remainAmount.floatValue];
}
///剩余可追加金额
- (void)setUPUserRemainAmount {
    self.userRemainAmount = [NSString hxb_getPerMilWithDouble:self.planDetailModel.userRemainAmount.floatValue];
}

///加入上线
- (void)setUPhxb_SingleMaxRegisterAmount {
    ///本期计划加入上线//1.加入上限：金额随用户实际的可加入金额变动，e.g.用户第一次投该期红利计划，显示为“本期计划加入上限50,000元”,用户投资30000元后，第二次追加进到该页面，显示“本期计划加入上限20,000元”，加入上限>计划剩余可投资金额时，显示计划剩余可投资金额
//    if (!self.planDetailModel.joinCount.integerValue) {
//        self.hxb_singleMaxRegisterAmount = @"本期计划加入上限50,000元";
//    }
//    if (self.planDetailModel.joinCount.integerValue == 1) {
//        self.hxb_singleMaxRegisterAmount = @"本期计划加入上限20,000元";
//    }
    NSString *str = [NSString hxb_getPerMilWithDouble:self.singleMaxRegisterAmount.floatValue];
    self.hxb_singleMaxRegisterAmount = [NSString stringWithFormat:@"本期计划加入上限%@元",str];
}

- (void)setUPAddButtonStr {
    if (self.planDetailModel.isFirst.integerValue) {
        self.addButtonStr = @"立即加入";
        self.isAddButtonNoInteraction = false;
    }else {
        self.addButtonStr = @"追加";
        self.isAddButtonNoInteraction = false;
    }
}
/**
 投标下线
 */
- (NSString *) minRegisterAmount {
    if (!_minRegisterAmount) {
        _minRegisterAmount = self.planDetailModel.minRegisterAmount;
    }
    return _minRegisterAmount;
}
/**
 加入条件
 */
- (NSString *)addCondition {
    if (!_addCondition) {
        if (self.planDetailModel.isFirst.integerValue) {
            _addCondition = [NSString stringWithFormat:@"加入金额%@元起，%@元的整数倍递增",self.minRegisterAmount,self.planDetailModel.minRegisterAmount];
        }else{
            _addCondition = [NSString stringWithFormat:@"%@元的整数倍递增",self.planDetailModel.minRegisterAmount];
        }
    }
    return _addCondition;
}
/**
 加入方式
 */
- (NSString *) profitType {
    if (!_profitType) {
        _profitType = @"收益再投资";
    }
    return _profitType;
}

/**
 已经收益
 */
- (NSString *) earnInterest {
    if (!_earnInterest) {
        _earnInterest = self.planDetailModel.earnInterest;
    }
    return _earnInterest;
}
/**
 预期收益比例
 */
- (NSString *) totalInterest {
    if (!_totalInterest) {
        _totalInterest = self.planDetailModel.totalInterest;
    }
    return _totalInterest;
}
@end

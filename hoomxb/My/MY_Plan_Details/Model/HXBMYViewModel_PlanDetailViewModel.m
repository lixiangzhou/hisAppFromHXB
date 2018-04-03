//
//  HXBMYViewModel_PlanDetailViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYViewModel_PlanDetailViewModel.h"

@implementation HXBMYViewModel_PlanDetailViewModel
- (void)setPlanDetailModel:(HXBMYModel_PlanDetailModel *)planDetailModel {
    _planDetailModel = planDetailModel;
    self.contractName = [NSString stringWithFormat:@"《%@》",planDetailModel.contractName];
}
/**
已获收益
 */
- (NSString *) inComeLable_ConstStr {
    _inComeLable_ConstStr = @"已获收益";
    return _inComeLable_ConstStr;
}
/**
 加入时间
 */
- (NSString *) addTime {
    if (self.planDetailModel.registerTime) {
        NSString *date = @(self.planDetailModel.registerTime.doubleValue).description;
        _addTime = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:date andDateFormat:@"yyyy-MM-dd"];
    } else {
        _addTime = @"--";
    }
    return _addTime;
}
/**
 期限
 */
- (NSString *) lockTime {
    if ([self.planDetailModel.novice isEqualToString:@"1"]) { //新手
        if (self.planDetailModel.lockDays) {
            _lockTime = [NSString stringWithFormat:@"%@天",self.planDetailModel.lockDays];
        }
    } else {
        if (self.planDetailModel.lockPeriod) {
            _lockTime = [NSString stringWithFormat:@"%@个月",self.planDetailModel.lockPeriod];
        }
    }
    return _lockTime;
}
/**
 收益方式
 */
//- (NSString *) cashType {
//    if (!_cashType){
//        ///    string    处理方式 （HXB：当日提取至红小宝账户，INVEST：收益再投资）
//        if ([self.planDetailModel.cashType isEqualToString:@"HXB"]) {
//            _cashType = @"当日提取至红小宝账户";
//        }
//        if ([self.planDetailModel.cashType isEqualToString:@"INVEST"]){
//            _cashType = @"收益再投资";
//        }
//    }
//    return _cashType;
//}
///以收益
- (NSString *) earnAmount {
    if(self.planDetailModel.earnAmount) {
        _earnAmount = [NSString GetPerMilWithDouble:self.planDetailModel.earnAmount.floatValue];
    } else {
        _earnAmount = @"--";
    }
    return _earnAmount;
}
///年利率
- (NSString *)expectedRate {
    if (self.planDetailModel.expectedRate) {
        //收益中&新手计划&存在贴息
        NSString *expectedRateStr = [self.planDetailModel.type isEqualToString:@"HOLD_PLAN"]&&[self.planDetailModel.novice isEqualToString:@"1"]&&self.planDetailModel.subsidyInterestRate ? [NSString stringWithFormat:@"%.1f%%+%.1f%%",self.planDetailModel.expectedRate.floatValue,self.planDetailModel.subsidyInterestRate.floatValue]: [NSString stringWithFormat:@"%.1f%%",self.planDetailModel.expectedRate.floatValue];
        _expectedRate = expectedRateStr;
    } else {
        _expectedRate = @"--";
    }
    return _expectedRate;
}
/**
 种类
 */
- (NSString *) type {
    if (self.planDetailModel.type) {
       HXBRequestType_MY_PlanRequestType typeInt = [HXBEnumerateTransitionManager myPlan_requestTypeStr:self.planDetailModel.type];
         [HXBEnumerateTransitionManager myPlan_requestType:typeInt andTypeBlock:^(NSString *typeUI, NSString *type) {
             _type = typeUI;
        }];
    } else {
        _type = @"--";
    }
    return _type;
}

/**
 statusInt
 1: 表示等待计息
 2: 表示受益中
 3: 表示退出中
 4: 表示已退出
 */
- (int) statusInt {
    [self status];
    return _statusInt;
}
/**
 是否隐藏追加
 */
- (BOOL)isAddButtonHidden {
    if (!_isAddButtonHidden) {
        [self status];
        _isAddButtonHidden = YES;
    }
    return _isAddButtonHidden;
}

/**
 计划状态
 */
- (NSString *)status {
    if (self.planDetailModel.type) {
        switch ([HXBEnumerateTransitionManager myPlan_requestTypeStr:self.planDetailModel.type]) {
                
            case HXBRequestType_MY_PlanRequestType_HOLD_PLAN: { //持有中
                [HXBEnumerateTransitionManager myPlan_requestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andTypeBlock:^(NSString *typeUI, NSString *type) {
                    if ([self.planDetailModel.status isEqualToString:MY_PlanResponsType_PURCHASE_END_Plan]) {
                        //锁定期
                        _statusInt = 10;
                    }
                    if ([self.planDetailModel.status isEqualToString:MY_PlanResponsType_PURCHASEING_Plan]) {
                        //债转匹配中
                        _statusInt = 11;
                    }
                    if ([self.planDetailModel.status isEqualToString:MY_PlanResponsType_REDEMPTION_PERIOD_Plan]) {
                        //开放期
                        _statusInt = 12;
                    }
                }];
            }
                break;
                
            case HXBRequestType_MY_PlanRequestType_EXITING_PLAN: { //退出中
                [HXBEnumerateTransitionManager myPlan_requestType:HXBRequestType_MY_PlanRequestType_EXITING_PLAN andTypeBlock:^(NSString *typeUI, NSString *type) {
                    _statusInt = 3;
                    _status = [NSString stringWithFormat:@"%@", self.planDetailModel.exitWay];
                }];
            }
                break;
                
            case HXBRequestType_MY_PlanRequestType_EXIT_PLAN: { //已经退出
                self.statusInt = 4;
                [HXBEnumerateTransitionManager myPlan_requestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andTypeBlock:^(NSString *typeUI, NSString *type) {
                    _status = [NSString stringWithFormat:@"%@", self.planDetailModel.exitWay];
                }];
            }
                break;
        }
    } else {
        _status = @"--";
    }
    return _status;
}

/**
 状态
 */
- (kHXBEnum_Fin_Plan_UnifyStatus)unifyStatus {
    return self.planDetailModel.unifyStatus;
}

/**
 加入金额
 */
- (NSString *) addAuomt {
    
    _addAuomt = [NSString hxb_getPerMilWithDouble:self.planDetailModel.amount.floatValue];
    return _addAuomt;
}
/**
 待转让金额

 */
- (NSString *) redProgressLeft {
    if (self.planDetailModel.redProgressLeft) {
        _redProgressLeft = [NSString hxb_getPerMilWithDouble:self.planDetailModel.redProgressLeft.floatValue];
    } else {
        _redProgressLeft = @"";
    }
    return _redProgressLeft;
}
/**
 退出时间
 */
- (NSString *) endLockingTime {
    if (self.planDetailModel.endLockingTime) {
        _endLockingTime = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.planDetailModel.endLockingTime andDateFormat:@"yyyy-MM-dd"];
    } else {
        _endLockingTime = @"--";
    }
    return _endLockingTime;
}

- (BOOL)isMonthyPayment {
    if ([_planDetailModel.cashType isEqualToString:@"HXB"]) {
        return YES;
    }
    return NO;
}

- (NSString *)quitStatus {
    if (self.planDetailModel.quitStatus) {
        if ([self.planDetailModel.quitStatus isEqualToString:@"QUIT"]) {
            _quitStatus = QUIT;
        } else if ([self.planDetailModel.quitStatus isEqualToString:@"ANNUL_QUIT"]) {
            _quitStatus = ANNUL_QUIT;
        } else if ([self.planDetailModel.quitStatus isEqualToString:@"STAY_QUIT"]) {
            _quitStatus = STAY_QUIT;
        } else {
            _quitStatus = @"--";
        }
    } else {
        _quitStatus = @"--";
    }
    return _quitStatus;
}

- (NSString *)quitDate {
    if (self.planDetailModel.quitDate) {
        _quitDate = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.planDetailModel.quitDate andDateFormat:@"yyyy-MM-dd"];
    } else if (self.planDetailModel.registerTime) {
        _quitDate = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.planDetailModel.registerTime andDateFormat:@"yyyy-MM-dd"];
    } else {
        _quitDate = @"--";
    }
    return _quitDate;
}

- (NSString *)repealDate {
    if (self.planDetailModel.repealDate) {
        _repealDate = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.planDetailModel.repealDate andDateFormat:@"yyyy-MM-dd"];
    } else {
        _repealDate = @"--";
    }
    return _repealDate;
}

- (NSString *)quitSubTitle {
    _quitSubTitle = self.planDetailModel.quitSubTitle ?: @"--";
    return _quitSubTitle;
}


/**
 计划退出状态：

 PURCHASE_END：          锁定期
 PURCHASEING：           债转匹配中
 REDEMPTION_PERIOD:      开放期
 */
- (NSString *)leaveStatus {
    if (self.planDetailModel.status) {
        if ([self.planDetailModel.status isEqualToString:@"PURCHASE_END"]) {
            _leaveStatus = PURCHASE_END;
        } else if ([self.planDetailModel.status isEqualToString:@"PURCHASEING"]) {
            _leaveStatus = PURCHASEING;
        } else if ([self.planDetailModel.status isEqualToString:@"REDEMPTION_PERIOD"]) {
            _leaveStatus = REDEMPTION_PERIOD;
        } else {
            _leaveStatus = @"--";
        }
    } else {
        _leaveStatus = @"--";
    }
    return _leaveStatus;
}

- (NSString *)statusImageName {
    if (self.planDetailModel.status) {
        if ([self.planDetailModel.status isEqualToString:@"PURCHASE_END"]) {
            _statusImageName = @"my_lockDate";
        } else if ([self.planDetailModel.status isEqualToString:@"PURCHASEING"]) {
            _statusImageName = @"zhaiquanpipei";
        } else if ([self.planDetailModel.status isEqualToString:@"REDEMPTION_PERIOD"]) {
            _statusImageName = @"my_open";
        } else {
            _statusImageName = @"zhaiquanpipei";
        }
    } else {
        _statusImageName = @"zhaiquanpipei";
    }
    return _statusImageName;
}
@end

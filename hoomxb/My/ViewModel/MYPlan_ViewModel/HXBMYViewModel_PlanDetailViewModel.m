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
        NSString *date = self.planDetailModel.registerTime;
        _addTime = [[HXBBaseHandDate sharedHandleDate] stringFromDate:date andDateFormat:@"yyyy-MM-dd"];
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
        _expectedRate = [NSString stringWithFormat:@"%@%@",self.planDetailModel.expectedRate,@"%"];
    }
    return _expectedRate;
}
/**
 种类
 */
- (NSString *) type {
    if (!_type) {
       HXBRequestType_MY_PlanRequestType typeInt = [HXBEnumerateTransitionManager myPlan_requestTypeStr:self.planDetailModel.type];
         [HXBEnumerateTransitionManager myPlan_requestType:typeInt andTypeBlock:^(NSString *typeUI, NSString *type) {
             _type = typeUI;
        }];
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
    if (!_statusInt) {
        [self status];
    }
    return _statusInt;
}

/**
 计划状态
 */
- (NSString *)status {
    if (!_status) {
        switch ([HXBEnumerateTransitionManager myPlan_requestTypeStr:self.planDetailModel.type]) {
            case HXBRequestType_MY_PlanRequestType_EXIT_PLAN: {
                //已经退出
                self.statusInt = 4;
               [HXBEnumerateTransitionManager myPlan_requestType:HXBRequestType_MY_PlanRequestType_EXIT_PLAN andTypeBlock:^(NSString *typeUI, NSString *type) {
                   _status = typeUI;
                }];
            }
                break;
            case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:{
                [HXBEnumerateTransitionManager myPlan_requestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andTypeBlock:^(NSString *typeUI, NSString *type) {
                    if ([self.planDetailModel.status isEqualToString:MY_PlanResponsType_PURCHASE_END_Plan]) {
                        ///受益中
                        _statusInt = 2;
                        _status = [NSString stringWithFormat:@"距离退出%@天",self.planDetailModel.lastDays];
                    }
                    if ([self.planDetailModel.status isEqualToString:MY_PlanResponsType_PURCHASEING_Plan]) {
                        ///等待计息
                        _statusInt = 1;
                        _status = typeUI;
                    }
                }];
            }
                break;
            case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:{
                [HXBEnumerateTransitionManager myPlan_requestType:HXBRequestType_MY_PlanRequestType_HOLD_PLAN andTypeBlock:^(NSString *typeUI, NSString *type) {
                    _statusInt = 3;
                    _status = typeUI;
                }];
            }
                
                break;
        }
    }
    return _status;
}
/**
 加入金额
 */
- (NSString *) addAuomt {
    if (!_addAuomt) {
        _addAuomt = [NSString hxb_getPerMilWithDouble:self.planDetailModel.finalAmount.floatValue];
    }
    return _addAuomt;
}
/**
 待转让金额

 */
- (NSString *) redProgressLeft {
    if (!_redProgressLeft) {
        _redProgressLeft = [NSString hxb_getPerMilWithDouble:self.planDetailModel.redProgressLeft.floatValue];
    }
    return _redProgressLeft;
}
/**
 退出时间
 */
- (NSString *) endLockingTime {
    if (!_endLockingTime) {
        _endLockingTime = [[HXBBaseHandDate sharedHandleDate] stringFromDate:self.planDetailModel.endLockingTime andDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _endLockingTime;
}

@end

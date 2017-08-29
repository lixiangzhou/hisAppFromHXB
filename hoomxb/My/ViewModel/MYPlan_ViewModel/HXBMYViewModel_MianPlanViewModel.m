//
//  HXBMYViewModel_MianPlanViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYViewModel_MianPlanViewModel.h"
#import "HXBMYModel_MainPlanModel.h"
@implementation HXBMYViewModel_MianPlanViewModel


#pragma mark -  ======================== 数据的转化 =============================

- (void)setPlanModelDataList:(HXBMYModel_MainPlanModel_DataList *)planModelDataList {
    _planModelDataList = planModelDataList;
    //请求类型
    self.requestType = [HXBEnumerateTransitionManager myPlan_requestTypeStr:self.planModelDataList.type];
    [HXBEnumerateTransitionManager myPlan_requestType:self.requestType andTypeBlock:^(NSString *typeUI, NSString *type) {
        self.requestType_UI = typeUI;
    }];
    //相应类型
    self.responseStatus = [HXBEnumerateTransitionManager myPlan_ResponsStatusStr:planModelDataList.status];
}
- (NSString *)description {
    return [self yy_modelDescription];
}

/**
   红利计划的状态
 */
- (NSString *) status {
    if (!_status) {
        
     NSString *statusStr = @"";
    switch (self.requestType) {
        case HXBRequestType_MY_PlanRequestType_HOLD_PLAN:
            statusStr = [self setStatus_HOLD_PLAN];
            break;
        case HXBRequestType_MY_PlanRequestType_EXITING_PLAN:
            
            break;
        case HXBRequestType_MY_PlanRequestType_EXIT_PLAN:
            statusStr = [NSString stringWithFormat:@"%@退出",[[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.planModelDataList.endLockingTime andDateFormat:@"yyyy-MM-dd"]];//计划状态
            break;
            
        default:
            break;
        }
        _status = statusStr;
    }
    return _status;
}



- (NSString *)setStatus_HOLD_PLAN {
    NSString *statusStr = @"";
    switch (self.responseStatus) {
        case HXBRequestType_MY_PlanResponseStatus_PURCHASE_END:
            statusStr = [NSString stringWithFormat:@"%@退出",[[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.planModelDataList.endLockingTime andDateFormat:@"yyyy-MM-dd"]];//计划状态
            break;
            
        case HXBRequestType_MY_PlanResponseStatus_REDEMPTION_PERIOD:
            statusStr = @"债权匹配中";
            break;
    }
            return statusStr;
}
/**
 预期年利率
 */
- (NSString *) expectedRate {
    if (!_expectedRate) {
        _expectedRate = [NSString stringWithFormat:@"%.2lf%@",self.planModelDataList.expectedRate.floatValue,@"%"];
    }
    return _expectedRate;
}




/**
 可用余额 没有元
 */
//- (NSString *) availablePoint {
//    if (!_availablePoint) {
//        [[KeyChainManage sharedInstance] availablePointWithBlock:^(NSString *availablePoint) {
//            _availablePoint = availablePoint;
//        }];
//    }
//    return _availablePoint;
//}

/**
 收益方法
 */
- (NSString *) profitType_UI {
    if (!_profitType_UI) {
        _profitType_UI = @"收益再投资";
    }
    return _profitType_UI;
}

/**
 服务协议 button str
 */
- (NSString *) contractName {
    if (!_contractName) {

        _contractName = @"《红利计划服务协议》";
    }
    return _contractName;
}

/**
 预期收益比例 计算收益
 */
- (NSString *) totalInterest {
    if (!_totalInterest) {
        _totalInterest = self.planModelDataList.expectedRate;
    }
    return _totalInterest;
}
/**
 本期余额
 */
- (NSString *) remainAmount {
    if (!_remainAmount) {
        _remainAmount = self.planModelDataList.redProgressLeft;
    }
    return _remainAmount;
}

/**
 用户余额
 */
- (NSString *) userRemainAmount {
    if (!_userRemainAmount) {
        _remainAmount = self.planModelDataList.userRemainAmount;
    }
    return _userRemainAmount;
}

/**
 amount_NOTYUAN
 */
- (NSString *) amount_NOTYUAN {
    if (!_amount_NOTYUAN) {
        _amount_NOTYUAN = [NSString GetPerMilWithDouble:self.planModelDataList.amount.floatValue];
    }
    return _amount_NOTYUAN;
}
/**
 加入金额
 */

- (NSString *) finalAmount_NOTYUAN {
    if (!_finalAmount_NOTYUAN) {
        _finalAmount_NOTYUAN = [NSString GetPerMilWithDouble:self.planModelDataList.finalAmount.floatValue];
    }
    return _finalAmount_NOTYUAN;
}
/**
 已获收益
 */
- (NSString *) earnAmount_NOTYUAN {
    if (!_earnAmount_NOTYUAN) {
        _earnAmount_NOTYUAN = [NSString GetPerMilWithDouble:self.planModelDataList.earnAmount.floatValue];
    }
    return _earnAmount_NOTYUAN;
}
@end

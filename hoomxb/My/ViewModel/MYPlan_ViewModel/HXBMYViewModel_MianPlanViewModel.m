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
    //红利计划的状态
    self.status = [HXBEnumerateTransitionManager myPlan_ResponsStatus:self.responseStatus];
}
- (NSString *)description {
    return [self yy_modelDescription];
}

/**
 预期年利率
 */
- (NSString *) expectedRate {
    if (!_expectedRate) {
        _expectedRate = self.planModelDataList.expectedRate;
    }
    return _expectedRate;
}

/**
 ￥，1000递
 */
- (NSString *) addCondition {
    if (!_addCondition) {
        _addCondition = [NSString stringWithFormat:@"￥%@递增",self.planModelDataList.amount];
    }
    return _addCondition;
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
        _profitType_UI = @"等待计息";
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
 利率
 */
//- (NSString *) totalInterest {
//    if (!_totalInterest) {
//        _totalInterest = <#obj#>
//    }
//    return _totalInterest;
//}
//@property (nonatomic,copy) NSString * totalInterest;

/**
 本期余额
 */
- (NSString *) remainAmount {
    if (!_remainAmount) {
        _remainAmount = self.planModelDataList.finalAmount;
    }
    return _remainAmount;
}

/**
 用户余额
 */
- (NSString *) userRemainAmount {
    if (!_userRemainAmount) {
        [[KeyChainManage sharedInstance] availablePointWithBlock:^(NSString *availablePoint) {
            _userRemainAmount = availablePoint;
        }];
    }
    return _userRemainAmount;
}
@end

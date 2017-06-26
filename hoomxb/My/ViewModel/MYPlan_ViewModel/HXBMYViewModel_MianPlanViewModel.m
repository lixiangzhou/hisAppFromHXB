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
        _expectedRate = [NSString stringWithFormat:@"%.2lf%@",self.planModelDataList.expectedRate.floatValue,@"%"];
    }
    return _expectedRate;
}

@end

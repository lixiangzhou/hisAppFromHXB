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
- (void)setPlanModelDataList:(HXBMYModel_MainPlanModel_DataList *)planModelDataList {
    _planModelDataList = planModelDataList;
    //请求类型
    self.requestType = [HXBRequestType_MYManager myPlan_requestTypeStr: planModelDataList.type];
    //相应类型
    self.responseStatus = [HXBRequestType_MYManager myPlan_ResponsStatusStr:planModelDataList.status];
    //红利计划的状态
    self.status = [HXBRequestType_MYManager myPlan_ResponsStatus:self.responseStatus];
}
@end

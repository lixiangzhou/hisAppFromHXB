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
- (void)setPlanModel:(HXBMYModel_MainPlanModel *)planModel{
    _planModel = planModel;
    self.requestType = [HXBRequestType_MYManager myPlan_requestTypeStr: planModel.dataList.type];
    self.responseStatus = [HXBRequestType_MYManager myPlan_ResponsStatusStr:planModel.dataList.status];
}
@end

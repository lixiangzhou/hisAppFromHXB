//
//  HXBFinancePlanDetailViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancePlanDetailViewModel.h"

@implementation HXBFinancePlanDetailViewModel

- (void)requestPlanDetailWithPlanId:(NSString *)planId resultBlock:(void (^)(HXBFinDetailViewModel_PlanDetail *model, BOOL isSuccess))resultBlock {
    HXBBaseRequest *planDetaileAPI = [[HXBBaseRequest alloc]initWithDelegate:self];
    planDetaileAPI.requestUrl = kHXBFinanc_PlanDetaileURL(planId.integerValue);
    
    [planDetaileAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        //数据是否出错
        NSString *status = responseObject[kResponseStatus];
        if (status.integerValue) {
            kNetWorkError(@"计划详情页 没有数据");
            if(resultBlock) resultBlock(nil, NO);
            return;
        }
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDetailModel_PlanDetail *planDetaileModel = [[HXBFinDetailModel_PlanDetail alloc]init];
        [planDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_PlanDetail *planDetailViewModel = [[HXBFinDetailViewModel_PlanDetail alloc]init];
        planDetailViewModel.planDetailModel = planDetaileModel;
        ///回调
        if (resultBlock) resultBlock(planDetailViewModel, YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && resultBlock) {
            kNetWorkError(@"红利计划详情")
            resultBlock(nil, NO);
        }
    }];
}

@end

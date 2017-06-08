//
//  HXBMYReqest_DetailRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYReqest_DetailRequest.h"
//MARK: ------------ API -------------------
#import "HXBRequestAPI_MYPlanDetailAPI.h"


//MARK: ------------ viewModel -------------
#import "HXBMYViewModel_LoanDetailViewModel.h"
#import "HXBMYViewModel_PlanDetailViewModel.h"



@implementation HXBMYReqest_DetailRequest
//MARK: 计划详情 接口
- (void)planListDetails_requestWithFinancePlanID: (NSString *)planID
                                 andSuccessBlock: (void(^)(HXBMYViewModel_PlanDetailViewModel *viewModel))successDateBlock
                                 andFailureBlock: (void(^)(NSError *error))failureBlock {
    
    HXBRequestAPI_MYPlanDetailAPI *planDetailAPI = [[HXBRequestAPI_MYPlanDetailAPI alloc]init];
    planDetailAPI.planID = planID;
    
    [planDetailAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"][@"dataList"];
        HXBMYModel_PlanDetailModel *planDetailModel = [[HXBMYModel_PlanDetailModel alloc]init];
        [planDetailModel yy_modelSetWithDictionary:dataDic];
        
        HXBMYViewModel_PlanDetailViewModel *planDetailViewModel = [[HXBMYViewModel_PlanDetailViewModel alloc]init];
        planDetailViewModel.planDetailModel = planDetailModel;
        
        if (successDateBlock) {
            successDateBlock(planDetailViewModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        kNetWorkError(@"我的界面的 计划详情");
    }];
}


//MARK: 资金记录详情 接口
- (void)loanListDetails_requestWithFinancePlanID: (NSString *)planID
                                  andRequestType: (NSString *)requestType
                                 andSuccessBlock: (void(^)(HXBMYViewModel_LoanDetailViewModel *viewModelArray))successDateBlock
                                 andFailureBlock: (void(^)(NSError *error))failureBlock{
    
    
}
@end

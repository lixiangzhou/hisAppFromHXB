//
//  HXBFinanceDetailViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanceDetailViewModel.h"

@implementation HXBFinanceDetailViewModel

- (void)requestPlanDetailWithPlanId:(NSString *)planId resultBlock:(void (^)(BOOL isSuccess))resultBlock {
    HXBBaseRequest *planDetaileAPI = [[HXBBaseRequest alloc]initWithDelegate:self];
    planDetaileAPI.requestUrl = kHXBFinanc_PlanDetaileURL(planId.integerValue);
    
    [planDetaileAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        //数据是否出错
        if ([responseObject[kResponseStatus] integerValue]) {
            kNetWorkError(@"计划详情页 没有数据");
            if(resultBlock) resultBlock(NO);
            return;
        }
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDetailModel_PlanDetail *planDetaileModel = [[HXBFinDetailModel_PlanDetail alloc]init];
        [planDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_PlanDetail *planDetailViewModel = [[HXBFinDetailViewModel_PlanDetail alloc]init];
        planDetailViewModel.planDetailModel = planDetaileModel;
        self.planDetailModel = planDetailViewModel;
        ///回调
        if (resultBlock) resultBlock(YES);
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (error && resultBlock) {
            kNetWorkError(@"红利计划详情")
            resultBlock(NO);
        }
    }];
}

- (void)requestLoanDetailWithLoanId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock {
    HXBBaseRequest *loanDetaileAPI = [[HXBBaseRequest alloc]initWithDelegate:self];
    loanDetaileAPI.requestUrl = kHXBFinanc_LoanDetaileURL(loanId.integerValue);
    
    [loanDetaileAPI loadDataWithSuccess:^(NYBaseRequest *request, id responseObject) {
        ///数据是否出错
        if ([responseObject[kResponseStatus] integerValue]) {
            kNetWorkError(@"散标详情页 没有数据");
            if (resultBlock) {
                resultBlock(NO);
            }
        }
        
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDatailModel_LoanDetail *loanDetaileModel = [[HXBFinDatailModel_LoanDetail alloc]init];
        [loanDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_LoanDetail *loanDetailViewModel = [[HXBFinDetailViewModel_LoanDetail alloc]init];
        loanDetailViewModel.loanDetailModel = loanDetaileModel;
        self.loanDetailModel = loanDetailViewModel;
        if (!loanDetailViewModel.loanDetailModel) {
            kNetWorkError(@"散标详情 没有数据");
            if (resultBlock) resultBlock(NO);
            return;
        }
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && resultBlock) {
            kNetWorkError(@"✘散标计划详情 - 请求没有数据")
            resultBlock(NO);
        }
    }];
}


- (void)requestLoanDetailWithLoanTruansferId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock {
    HXBBaseRequest *loanTruansferRequest = [[HXBBaseRequest alloc]initWithDelegate:self];
    loanTruansferRequest.requestUrl = kHXBFin_LoanTruansfer_DetailURL(loanId.integerValue);
    
    [loanTruansferRequest loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            if (resultBlock) {
                resultBlock(NO);
            }
            kNetWorkError(@"债转详情");
            return;
        }
        NSDictionary *dataDic = responseObject[kResponseData];
        
        HXBFinDetailViewModel_LoanTruansferDetail *viewModel = [[HXBFinDetailViewModel_LoanTruansferDetail alloc]init];
        HXBFinDetailModel_LoanTruansferDetail *loanTruansferModel = [[HXBFinDetailModel_LoanTruansferDetail alloc]init];
        [loanTruansferModel yy_modelSetWithDictionary:dataDic];
        viewModel.loanTruansferDetailModel = loanTruansferModel;
        self.loanTruansferDetailModel = viewModel;
        if (resultBlock) {
            resultBlock(YES);
        }
        
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

@end

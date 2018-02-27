//
//  HXBFinAddRecordViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/1/11.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddRecordViewModel.h"
#import "HXBBaseRequest.h"///网络数据请求

@implementation HXBFinAddRecordViewModel

- (void)requestPlanAddRecortdFinanceWithId:(NSString *)planId resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    NYBaseRequest *planAddRecortdAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    planAddRecortdAPI.showHud = YES;
    planAddRecortdAPI.requestUrl = kHXBFinanc_Plan_AddRecortdURL(planId);
    planAddRecortdAPI.requestMethod = NYRequestMethodGet;
    [planAddRecortdAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        HXBFinModel_AddRecortdModel_Plan *planAddRecortdModel = [[HXBFinModel_AddRecortdModel_Plan alloc]init];
        NSDictionary *dataDic = [responseObject valueForKey:@"data"];
        [planAddRecortdModel yy_modelSetWithDictionary:dataDic];
        weakSelf.addRecortdModel_PlanModel = planAddRecortdModel;
        if (resultBlock) {
            resultBlock(YES,nil);
        };
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO,error);
        };
    }];
}

- (void)requestLoanAddRecortdWithId:(NSString *)loanId resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    NYBaseRequest *loanAddRecortdAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    loanAddRecortdAPI.showHud = YES;
    loanAddRecortdAPI.requestUrl = kHXBFinanc_Loan_AddRecortdURL(loanId);
    loanAddRecortdAPI.requestMethod = NYRequestMethodGet;
    [loanAddRecortdAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        FinModel_AddRecortdModel_Loan *model = [[FinModel_AddRecortdModel_Loan alloc]init];
        NSDictionary *dic = [responseObject valueForKey:@"data"];
        [model yy_modelSetWithDictionary:dic];
        weakSelf.addRecortdModel_LoanModel = model;
        if (resultBlock) {
            resultBlock(YES,nil);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO,error);
        };
    }];
}

- (void)requestLoanTruaLnsferAddRecortdWithId:(NSString *)loanTruaLnsferId  resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    NYBaseRequest *loanTruansferAddRecortdAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    loanTruansferAddRecortdAPI.showHud = YES;
    loanTruansferAddRecortdAPI.requestUrl = kHXBFinanc_LoanTruansfer_AddRecortdURL(loanTruaLnsferId);
    loanTruansferAddRecortdAPI.requestMethod = NYRequestMethodGet;
    [loanTruansferAddRecortdAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSArray *array = responseObject[kResponseData][kResponseDataList];
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBFinModel_AddRecortdModel_LoanTruansfer *model = [[HXBFinModel_AddRecortdModel_LoanTruansfer alloc]init];
            [model yy_modelSetWithDictionary:obj];
            model.index = @(array.count - idx).description;
            [dataArray addObject:model];
        }];
        weakSelf.loanTruansferRecortdModelArray = dataArray;
        if (resultBlock) {
            resultBlock(YES,nil);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO,error);
        };
    }];
}

@end

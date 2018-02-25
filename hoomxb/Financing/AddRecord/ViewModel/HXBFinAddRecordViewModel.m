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

- (void)requestPlanAddRecortdFinanceWithId:(NSString *)planId planAddRecortdWithISUPLoad:(BOOL)isUPLoad andOrder: (NSString *)order resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    NYBaseRequest *planAddRecortdAPI = [[NYBaseRequest alloc] init];
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
    }];
    
    
//    HXBBaseRequest *planAddRecortdAPI = [[HXBBaseRequest alloc]initWithDelegate:self];
//    planAddRecortdAPI.isUPReloadData = isUPLoad;
//    planAddRecortdAPI.requestMethod = NYRequestMethodGet;
//    planAddRecortdAPI.requestUrl = kHXBFinanc_Plan_AddRecortdURL(planId);
//
//    [planAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
//
//        HXBFinModel_AddRecortdModel_Plan *planAddRecortdModel = [[HXBFinModel_AddRecortdModel_Plan alloc]init];
//        NSDictionary *dataDic = [responseObject valueForKey:@"data"];
//        [planAddRecortdModel yy_modelSetWithDictionary:dataDic];
//        weakSelf.addRecortdModel_PlanModel = planAddRecortdModel;
//        if (resultBlock) {
//            resultBlock(YES,nil);
//        };
//    } failure:^(HXBBaseRequest *request, NSError *error) {
//    }];
}

- (void)requestLoanAddRecortdWithId:(NSString *)loanId loadAddRecortdWithISUPLoad:(BOOL)isUPLoad andOrder: (NSString *)order resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    NYBaseRequest *loanAddRecortdAPI = [[NYBaseRequest alloc] init];
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
    }];
    
//    HXBBaseRequest *loanAddRecortdAPI = [[HXBBaseRequest alloc]initWithDelegate:self];
//    loanAddRecortdAPI.requestUrl = kHXBFinanc_Loan_AddRecortdURL(loanId);
//    [loanAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
//
//        FinModel_AddRecortdModel_Loan *model = [[FinModel_AddRecortdModel_Loan alloc]init];
//        NSDictionary *dic = [responseObject valueForKey:@"data"];
//        [model yy_modelSetWithDictionary:dic];
//        weakSelf.addRecortdModel_LoanModel = model;
//        if (resultBlock) {
//            resultBlock(YES,nil);
//        }
//    } failure:^(HXBBaseRequest *request, NSError *error) {
//    }];
}

- (void)requestLoanTruaLnsferAddRecortdWithId:(NSString *)loanTruaLnsferId loanTruansferAddRecortdWithISUPLoad: (BOOL)isUPLoad andOrder: (NSString *)order resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    
    NYBaseRequest *loanTruansferAddRecortdAPI = [[NYBaseRequest alloc] init];
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
    }];
    
//    HXBBaseRequest *loanTruansferAddRecortdAPI = [[HXBBaseRequest alloc]initWithDelegate:self];
//    loanTruansferAddRecortdAPI.requestMethod = NYRequestMethodGet;
//    loanTruansferAddRecortdAPI.isUPReloadData = isUPLoad;
//    loanTruansferAddRecortdAPI.requestArgument = @{
//                                                   @"page":@(loanTruansferAddRecortdAPI.dataPage)
//                                                   };
//    loanTruansferAddRecortdAPI.requestUrl = kHXBFinanc_LoanTruansfer_AddRecortdURL(loanTruaLnsferId);
//
//    [loanTruansferAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
//
//        NSArray *array = responseObject[kResponseData][kResponseDataList];
//        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
//
//        [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            HXBFinModel_AddRecortdModel_LoanTruansfer *model = [[HXBFinModel_AddRecortdModel_LoanTruansfer alloc]init];
//            [model yy_modelSetWithDictionary:obj];
//            model.index = @(array.count - idx).description;
//            [dataArray addObject:model];
//        }];
//        weakSelf.loanTruansferRecortdModelArray = dataArray;
//        if (resultBlock) {
//            resultBlock(YES,nil);
//        }
//    } failure:^(HXBBaseRequest *request, NSError *error) {
//
//    }];
}

@end

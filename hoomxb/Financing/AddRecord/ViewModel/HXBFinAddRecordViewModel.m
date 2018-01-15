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

//- (void)requestPlanAddRecortdFinanceWithId:(NSString *)planId planAddRecortdWithISUPLoad:(BOOL)isUPLoad andOrder: (NSString *)order resultBlock: (void(^)(BOOL isSuccess))successBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
//    kWeakSelf
//    HXBBaseRequest *planAddRecortdAPI = [[HXBBaseRequest alloc]init];
//    planAddRecortdAPI.isUPReloadData = isUPLoad;
//    planAddRecortdAPI.requestMethod = NYRequestMethodGet;
//    planAddRecortdAPI.requestUrl = kHXBFinanc_Plan_AddRecortdURL(planId);
//
//    [planAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
//        kHXBResponsShowHUD
//        HXBFinModel_AddRecortdModel_Plan *planAddRecortdModel = [[HXBFinModel_AddRecortdModel_Plan alloc]init];
//        NSDictionary *dataDic = [responseObject valueForKey:@"data"];
//        [planAddRecortdModel yy_modelSetWithDictionary:dataDic];
//        weakSelf.addRecortdModel_PlanModel = planAddRecortdModel;
//        if (successBlock) {
//            successBlock(true);
//        };
//    } failure:^(HXBBaseRequest *request, NSError *error) {
//        NSLog(@"✘ 红利计划的详情页 - 加入计划 - 网络请求失败");
//        if (error) {
//            failureBlock(error);
//        }
//    }];
//}

- (void)requestPlanAddRecortdFinanceWithId:(NSString *)planId planAddRecortdWithISUPLoad:(BOOL)isUPLoad andOrder: (NSString *)order resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    HXBBaseRequest *planAddRecortdAPI = [[HXBBaseRequest alloc]init];
    planAddRecortdAPI.isUPReloadData = isUPLoad;
    planAddRecortdAPI.requestMethod = NYRequestMethodGet;
    planAddRecortdAPI.requestUrl = kHXBFinanc_Plan_AddRecortdURL(planId);
    
    [planAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        kHXBResponsResultShowHUD
        HXBFinModel_AddRecortdModel_Plan *planAddRecortdModel = [[HXBFinModel_AddRecortdModel_Plan alloc]init];
        NSDictionary *dataDic = [responseObject valueForKey:@"data"];
        [planAddRecortdModel yy_modelSetWithDictionary:dataDic];
        weakSelf.addRecortdModel_PlanModel = planAddRecortdModel;
        if (resultBlock) {
            resultBlock(true,nil);
        };
    } failure:^(HXBBaseRequest *request, NSError *error) {
    }];
}


//- (void)requestLoanAddRecortdWithId:(NSString *)loanId loadAddRecortdWithISUPLoad:(BOOL)isUPLoad andOrder: (NSString *)order resultBlock: (void(^)(BOOL isSuccess))successBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
//    kWeakSelf
//    HXBBaseRequest *loanAddRecortdAPI = [[HXBBaseRequest alloc]init];
//    loanAddRecortdAPI.requestUrl = kHXBFinanc_Loan_AddRecortdURL(loanId);
//    [loanAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
//        kHXBResponsShowHUD
//        FinModel_AddRecortdModel_Loan *model = [[FinModel_AddRecortdModel_Loan alloc]init];
//        NSDictionary *dic = [responseObject valueForKey:@"data"];
//        [model yy_modelSetWithDictionary:dic];
//        weakSelf.addRecortdModel_LoanModel = model;
//        if (successBlock) {
//            successBlock(true);
//        }
//    } failure:^(HXBBaseRequest *request, NSError *error) {
//        kNetWorkError(@"loan 加入计划 - 网络请求失败")
//        if (error) {
//            failureBlock(error);
//        }
//    }];
//}
- (void)requestLoanAddRecortdWithId:(NSString *)loanId loadAddRecortdWithISUPLoad:(BOOL)isUPLoad andOrder: (NSString *)order resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    HXBBaseRequest *loanAddRecortdAPI = [[HXBBaseRequest alloc]init];
    loanAddRecortdAPI.requestUrl = kHXBFinanc_Loan_AddRecortdURL(loanId);
    [loanAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        kHXBResponsResultShowHUD
        FinModel_AddRecortdModel_Loan *model = [[FinModel_AddRecortdModel_Loan alloc]init];
        NSDictionary *dic = [responseObject valueForKey:@"data"];
        [model yy_modelSetWithDictionary:dic];
        weakSelf.addRecortdModel_LoanModel = model;
        if (resultBlock) {
            resultBlock(true,nil);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
    }];
}

//- (void)requestLoanTruaLnsferAddRecortdWithId:(NSString *)loanTruaLnsferId loanTruansferAddRecortdWithISUPLoad: (BOOL)isUPLoad andOrder: (NSString *)order resultBlock: (void(^)(BOOL isSuccess))successBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
//    kWeakSelf
//    HXBBaseRequest *loanTruansferAddRecortdAPI = [[HXBBaseRequest alloc]init];
//    loanTruansferAddRecortdAPI.requestMethod = NYRequestMethodGet;
//    loanTruansferAddRecortdAPI.isUPReloadData = isUPLoad;
//    loanTruansferAddRecortdAPI.requestArgument = @{
//                                                    @"page":@(loanTruansferAddRecortdAPI.dataPage)
//                                                    };
//    loanTruansferAddRecortdAPI.requestUrl = kHXBFinanc_LoanTruansfer_AddRecortdURL(loanTruaLnsferId);
//
//    [loanTruansferAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
//
//        kHXBResponsShowHUD
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
//        if (successBlock) {
//            successBlock(true);
//        }
//    } failure:^(HXBBaseRequest *request, NSError *error) {
//        if (error) {
//            failureBlock(error);
//        }
//    }];
//}
- (void)requestLoanTruaLnsferAddRecortdWithId:(NSString *)loanTruaLnsferId loanTruansferAddRecortdWithISUPLoad: (BOOL)isUPLoad andOrder: (NSString *)order resultBlock:(void (^)(BOOL, NSError *))resultBlock{
    kWeakSelf
    HXBBaseRequest *loanTruansferAddRecortdAPI = [[HXBBaseRequest alloc]init];
    loanTruansferAddRecortdAPI.requestMethod = NYRequestMethodGet;
    loanTruansferAddRecortdAPI.isUPReloadData = isUPLoad;
    loanTruansferAddRecortdAPI.requestArgument = @{
                                                   @"page":@(loanTruansferAddRecortdAPI.dataPage)
                                                   };
    loanTruansferAddRecortdAPI.requestUrl = kHXBFinanc_LoanTruansfer_AddRecortdURL(loanTruaLnsferId);
    
    [loanTruansferAddRecortdAPI loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        
        kHXBResponsResultShowHUD
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
            resultBlock(true,nil);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
    }];
}




@end

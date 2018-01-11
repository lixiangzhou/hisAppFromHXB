//
//  HXBFinAddRecordViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/1/11.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddRecordViewModel.h"

@implementation HXBFinAddRecordViewModel


- (void)requestPlanAddRecortdFinanceWithId:(NSString *)planId andResultBlock:(void (^)(id model))resultBlock{
//    [[HXBFinanctingRequest sharedFinanctingRequest] planAddRecortdWithISUPLoad:YES andFinancePlanId:self.planID andOrder:nil andSuccessBlock:^(HXBFinModel_AddRecortdModel_Plan *model) {
//        self.addRecortdTableView.addRecortdModel_Plan = model;
//    } andFailureBlock:^(NSError *error) {
//
//    }];
}


- (void)requestLoanAddRecortdWithId:(NSString *)loanId andResultBlock:(void (^)(id model))resultBlock{
    
}


- (void)requestLoanTruaLnsferAddRecortdWithId:(NSString *)loanTruaLnsferId andResultBlock:(void (^)(id model))resultBlock{
    
}





@end

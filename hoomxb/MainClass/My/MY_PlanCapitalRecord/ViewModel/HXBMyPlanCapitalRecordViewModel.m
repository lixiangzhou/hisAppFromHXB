//
//  HXBMyPlanCapitalRecordViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/2/8.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanCapitalRecordViewModel.h"

@implementation HXBMyPlanCapitalRecordViewModel


///plan 详情页的 交易记录
- (void)loanRecord_my_Plan_WithRequestUrl: (NSString *)requestUrl resultBlock: (void(^)(BOOL isSuccess))resultBlock{
    
    kWeakSelf
    NYBaseRequest *loanRecordAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    loanRecordAPI.requestUrl = requestUrl;
    loanRecordAPI.requestMethod = NYRequestMethodGet;
    loanRecordAPI.showHud = YES;
    loanRecordAPI.requestArgument = @{
                                      @"page" : @(self.planLoanRecordPage).description,
                                      };
    [loanRecordAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSArray <NSDictionary *>*dataArray = responseObject[kResponseData][@"dataList"];
        NSMutableArray <HXBMY_PlanViewModel_LoanRecordViewModel *>*viewModelArray = [[NSMutableArray alloc]init];
        
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMY_PlanModel_LoanRecordModel *planModel = [[HXBMY_PlanModel_LoanRecordModel alloc]init];
            [planModel yy_modelSetWithDictionary:obj];
            HXBMY_PlanViewModel_LoanRecordViewModel *loanRecordViewModel = [[HXBMY_PlanViewModel_LoanRecordViewModel alloc]init];
            loanRecordViewModel.planLoanRecordModel = planModel;
            [viewModelArray addObject:loanRecordViewModel];
        }];
        weakSelf.currentPageCount = viewModelArray.count;
        weakSelf.totalCount = [NSString stringWithFormat:@"%@",[responseObject[kResponseData] valueForKey:@"totalCount"]];
        
        if (resultBlock) {
            if (weakSelf.planLoanRecordPage<=1) {
                weakSelf.planLoanRecordPage=1;
                [weakSelf.planLoanRecordViewModel_array removeAllObjects];
            }
            [weakSelf.planLoanRecordViewModel_array addObjectsFromArray:viewModelArray];
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

- (NSInteger)planLoanRecordPage{
    if (_planLoanRecordPage <= 1) {
        _planLoanRecordPage = 1;
    }
    return _planLoanRecordPage;
}

- (NSMutableArray<HXBMY_PlanViewModel_LoanRecordViewModel *> *)planLoanRecordViewModel_array{
    if (!_planLoanRecordViewModel_array) {
        _planLoanRecordViewModel_array = [[NSMutableArray alloc]init];
    }
    return _planLoanRecordViewModel_array;
}

@end

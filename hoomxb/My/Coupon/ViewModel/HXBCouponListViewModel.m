//
//  HXBCouponListViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBCouponListViewModel.h"

@implementation HXBCouponListViewModel
- (void)downLoadMyAccountListInfoHUDWithParameterDict:(NSDictionary *)parameterDict completion:(void (^)(BOOL isSuccess))completion
{
    
    NYBaseRequest *myAccountListInfoAPI = [[NYBaseRequest alloc]init];
    myAccountListInfoAPI.requestUrl = kHXBMY_AccountListInfoURL;
    myAccountListInfoAPI.requestMethod = NYRequestMethodPost;
    myAccountListInfoAPI.requestArgument = parameterDict;
    myAccountListInfoAPI.hudDelegate = self;
    
    [myAccountListInfoAPI showLoading:@"加载中..."];
    [myAccountListInfoAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [myAccountListInfoAPI hideLoading];
        NSDictionary *data = [responseObject valueForKey:@"data"];
        NSArray <NSDictionary *>*dataList = [data valueForKey:@"dataList"];
        self.totalCount = data[@"totalCount"];
        self.appendCouponList = [self dataProcessingWitharr:dataList];
        if (completion) {
            completion(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [myAccountListInfoAPI hideLoading];
        if (completion) {
            completion(NO);
        }
    }];
}

- (NSMutableArray <HXBMyCouponListModel *>*)dataProcessingWitharr:(NSArray *)dataList
{
    NSMutableArray <HXBMyCouponListModel *>*planListViewModelArray = [[NSMutableArray alloc]init];
    
    [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXBMyCouponListModel *financtingPlanListModel = [[HXBMyCouponListModel alloc]init];
        //字典转模型
        [financtingPlanListModel yy_modelSetWithDictionary:obj];
        [planListViewModelArray addObject:financtingPlanListModel];
    }];
    return planListViewModelArray;
}

@end

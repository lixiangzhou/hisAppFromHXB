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
//                                     withSeccessBlock:(void(^)(NSArray<HXBMyCouponListModel *>* modelArray, NSInteger totalCount))seccessBlock andFailure: (void(^)(NSError *error))failureBlock
{
    
    NYBaseRequest *myAccountListInfoAPI = [[NYBaseRequest alloc]init];
    myAccountListInfoAPI.requestUrl = kHXBMY_AccountListInfoURL;
    myAccountListInfoAPI.requestMethod = NYRequestMethodPost;
    myAccountListInfoAPI.requestArgument = parameterDict;
    myAccountListInfoAPI.hudDelegate = self;
    
    [myAccountListInfoAPI showLoading:@"加载中..."];
    [myAccountListInfoAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [myAccountListInfoAPI hideLoading];
        if (responseObject.isSuccess) {
            NSDictionary *data = [responseObject valueForKey:@"data"];
            NSArray <NSDictionary *>*dataList = [data valueForKey:@"dataList"];
            self.totalCount = data[@"totalCount"];
            self.appendCouponList = [self dataProcessingWitharr:dataList];
        }
        completion(responseObject.isSuccess);
    } failure:^(NYBaseRequest *request, NSError *error) {
        [myAccountListInfoAPI hideLoading];
        completion(NO);
    }];
    
//    //@"加载中..."
//    [myAccountListInfoAPI startWithHUDStr:@"加载中..." Success:^(NYBaseRequest *request, id responseObject) {
//        if ([responseObject[kResponseStatus] integerValue]) {
//            kHXBResponsShowHUD
//        }
//        NSDictionary *data = [responseObject valueForKey:@"data"];
//        NSArray <NSDictionary *>*dataList = [data valueForKey:@"dataList"];
//        NSMutableArray <HXBMyCouponListModel *>*modelArray = [self dataProcessingWitharr:dataList];
//
//        if (seccessBlock) {
//            seccessBlock(modelArray, [[data valueForKey:@"totalCount"] integerValue]);
//        }
//    } failure:^(NYBaseRequest *request, NSError *error) {
//        NSLog(@"%@",error);
//        if (failureBlock) {
//            failureBlock(error);
//        }
//        kNetWorkError(@"用户请求失败");
//    }];
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

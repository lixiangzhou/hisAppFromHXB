//
//  HXBRequestAccountInfo.m
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestAccountInfo.h"
#import "HXBBaseRequest.h"
#import "HXBMyCouponListModel.h"

@implementation HXBRequestAccountInfo

+ (NSMutableArray <HXBMyCouponListModel *>*)dataProcessingWitharr:(NSArray *)dataList
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

+ (void)downLoadMyAccountListInfoNoHUDWithParameterDict:(NSDictionary *)parameterDict withSeccessBlock:(void(^)(NSArray<HXBMyCouponListModel *>* modelArray))seccessBlock andFailure: (void(^)(NSError *error))failureBlock{
    
    NYBaseRequest *myAccountListInfoAPI = [[NYBaseRequest alloc]init];
    myAccountListInfoAPI.requestUrl = kHXBMY_AccountListInfoURL;
    myAccountListInfoAPI.requestMethod = NYRequestMethodPost;
    myAccountListInfoAPI.requestArgument = parameterDict;
    
    [myAccountListInfoAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            kHXBResponsShowHUD
        }
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
        NSMutableArray <HXBMyCouponListModel *>*modelArray = [HXBRequestAccountInfo dataProcessingWitharr:dataList];
        
        if (seccessBlock) {
            seccessBlock(modelArray);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        if (failureBlock) {
            failureBlock(error);
        }
        kNetWorkError(@"用户请求失败");
    }];
}

+ (void)downLoadAccountInfoNoHUDWithSeccessBlock:(void (^)(HXBMyRequestAccountModel *))seccessBlock andFailure:(void (^)(NSError *))failureBlock{
    
    NYBaseRequest *accountInfoAPI = [[NYBaseRequest alloc]init];
    accountInfoAPI.requestUrl = kHXBUser_AccountInfoURL;
    accountInfoAPI.requestMethod = NYRequestMethodGet;
    [accountInfoAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            kHXBResponsShowHUD
        }

        HXBMyRequestAccountModel *accountInfoModel = [[HXBMyRequestAccountModel alloc]init];
        [accountInfoModel yy_modelSetWithDictionary:responseObject[@"data"]];
        
        if (seccessBlock) {
            seccessBlock(accountInfoModel);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        if (failureBlock) {
            failureBlock(error);
        }
        kNetWorkError(@"用户请求失败");
    }];
}

@end

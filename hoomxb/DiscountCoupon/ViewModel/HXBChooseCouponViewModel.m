//
//  HXBChooseCouponViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBChooseCouponViewModel.h"
#import "NYHTTPConnection.h"

@implementation HXBChooseCouponViewModel

+ (void)requestChooseCouponWithParams: (NSDictionary *)params
               andSuccessBlock: (void(^)(HXBChooseCouponModel *model))successDateBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock {
    NYBaseRequest *accountAsseAPI = [[NYBaseRequest alloc]init];
    accountAsseAPI.requestMethod = NYRequestMethodPost;
    accountAsseAPI.requestUrl = kHXB_Coupon_Query;
    accountAsseAPI.requestArgument = params;
    [accountAsseAPI startWithHUDStr:kLoadIngText Success:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        HXBChooseCouponModel *model = [[HXBChooseCouponModel alloc]init];
        [model yy_modelSetWithDictionary:baseDic];
        if (successDateBlock) {
            successDateBlock(model);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            failureBlock(error);
        }
    }];
}

// 购买匹配最优优惠券
+ (NSURLSessionDataTask *)requestBestCouponWithParams: (NSDictionary *)params
                                      andSuccessBlock: (void(^)(HXBBestCouponModel *model))successDateBlock
                                      andFailureBlock: (void(^)(NSError *error))failureBlock {
    NYBaseRequest *accountAsseAPI = [[NYBaseRequest alloc]init];
    accountAsseAPI.requestMethod = NYRequestMethodPost;
    accountAsseAPI.requestUrl = kHXB_Coupon_Best;
    accountAsseAPI.requestArgument = params;
    [accountAsseAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        HXBBestCouponModel *model = [[HXBBestCouponModel alloc]init];
        [model yy_modelSetWithDictionary:baseDic];
        if (successDateBlock) {
            successDateBlock(model);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            failureBlock(error);
        }
    }];
    return accountAsseAPI.dataTask; // 返回当前的请求任务
}
@end

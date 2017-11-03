//
//  HXBChooseCouponViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBChooseCouponViewModel.h"

@implementation HXBChooseCouponViewModel

+ (void)chooseCouponWithparams: (NSDictionary *)params
               andSuccessBlock: (void(^)(HXBChooseCouponModel *model))successDateBlock
               andFailureBlock: (void(^)(NSError *error))failureBlock {
    NYBaseRequest *accountAsseAPI = [[NYBaseRequest alloc]init];
    accountAsseAPI.requestMethod = NYRequestMethodPost;
    accountAsseAPI.requestUrl = kHXB_Coupon_Query;
    accountAsseAPI.requestArgument = params;
    [accountAsseAPI startWithHUDStr:@"加载中..." Success:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        HXBChooseCouponModel *model = [[HXBChooseCouponModel alloc]init];
        [model yy_modelSetWithDictionary:baseDic];
        if (successDateBlock) {
            successDateBlock(model);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            NSLog(@"✘ 首页资金等- 请求没有数据");
            failureBlock(error);
        }
    }];
}

// 购买匹配最优优惠券
+ (void)BestCouponWithparams: (NSDictionary *)params
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
            NSLog(@"最优优惠券请求没有数据");
            failureBlock(error);
        }
    }];
}
@end

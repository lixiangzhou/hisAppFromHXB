//
//  HXBHomeVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/1/11.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomeVCViewModel.h"
#import "HXBBaseRequest.h"
#import "HXBHomeBaseModel.h"

@implementation HXBHomeVCViewModel

- (void)homePlanRecommendCallbackBlock: (void(^)(BOOL isSuccess))callbackBlock
{
    HXBBaseRequest *homePlanRecommendAPI = [[HXBBaseRequest alloc] initWithDelegate:self];
    homePlanRecommendAPI.requestMethod = NYRequestMethodGet;
    homePlanRecommendAPI.requestUrl = kHXBHome_HomeURL;
    homePlanRecommendAPI.showHud = NO;
    homePlanRecommendAPI.requestArgument = @{
                                             @"cashType" : @"ALL"
                                             };
    kWeakSelf
    [homePlanRecommendAPI startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        int codeValue = [responseObject[@"status"] intValue];
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        weakSelf.homeBaseModel = [HXBHomeBaseModel yy_modelWithDictionary:baseDic];
        if (callbackBlock) {
            callbackBlock(!codeValue);
        }
        //对数据进行异步缓存
        [PPNetworkCache setHttpCache:responseObject URL:kHXBHome_HomeURL parameters:nil];
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (error && callbackBlock) {
            NSLog(@"✘ 首页计划列表 - 请求没有数据");
            callbackBlock(NO);
        }
    }];
}

@end

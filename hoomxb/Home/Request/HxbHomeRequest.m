//
//  HxbHomeRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomeRequest.h"
#import "HxbHomePageModel.h"
#import "HXBBaseRequest.h"///网络数据的请求
#import "HXBHomeBaseModel.h"
@implementation HxbHomeRequest

#pragma mark -  数据请求
- (void)homeAccountAssetWithUserID: (NSString *)userId andSuccessBlock: (void(^)(HxbHomePageViewModel *viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    HXBBaseRequest *accountAsseAPI = [[HXBBaseRequest alloc]init];
    accountAsseAPI.requestMethod = NYRequestMethodGet;
    accountAsseAPI.requestUrl = @"/account/asset.action";
    accountAsseAPI.requestArgument = @{
                                       @"version" : @"1.0",
                                       @"userId" : userId,
                                       @"platform" : @"IOS"
                                       };
    
    [accountAsseAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        HxbHomePageModel *homePageModel = [[HxbHomePageModel alloc]init];
        [HxbHomePageModel yy_modelSetWithDictionary:baseDic];
        HxbHomePageViewModel *homePageViewModel = [[HxbHomePageViewModel alloc]init];
        homePageViewModel.homePageModel = homePageModel;
        if (successDateBlock) {
            successDateBlock(homePageViewModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            failureBlock(error);
        }
    }];
}

- (void)homePlanRecommendWithIsUPReloadData:(BOOL)isUPReloadData
                            andSuccessBlock: (void(^)(HxbHomePageViewModel *viewModel))successDateBlock
                            andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *homePlanRecommendAPI = [[HXBBaseRequest alloc] init];
    homePlanRecommendAPI.requestMethod = NYRequestMethodGet;
    homePlanRecommendAPI.requestUrl = kHXBHome_HomeURL;
    homePlanRecommendAPI.isUPReloadData = isUPReloadData;
#if kIsNewBieDevelopVersion == YES
    homePlanRecommendAPI.requestArgument = @{
                                             @"cashType" : @"newbie"
                                             };
#else
    homePlanRecommendAPI.requestArgument = @{
                                             @"cashType" : @"all"
                                             };
#endif
    
    [homePlanRecommendAPI startWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
         NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        HxbHomePageViewModel *homePageViewModel = [[HxbHomePageViewModel alloc] init];
        homePageViewModel.homeBaseModel = [HXBHomeBaseModel yy_modelWithDictionary:baseDic];
        if (successDateBlock) {
            successDateBlock(homePageViewModel);
        }
        //对数据进行异步缓存
        [PPNetworkCache setHttpCache:responseObject URL:kHXBHome_HomeURL parameters:nil];
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            NSLog(@"✘ 首页计划列表 - 请求没有数据");
            failureBlock(error);
        }
    }];
}

@end

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
#import "HXBHomeNewbieProductModel.h"
#import "HxbHomePageModel_DataList.h"

@implementation HXBHomeVCViewModel

- (void)homePlanRecommendCallbackBlock: (void(^)(BOOL isSuccess))callbackBlock
{
    NYBaseRequest *homePlanRecommendAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    homePlanRecommendAPI.requestMethod = NYRequestMethodGet;
    homePlanRecommendAPI.requestUrl = kHXBHome_HomeURL;
    homePlanRecommendAPI.showHud = NO;
#if kIsNewBieDevelopVersion
    homePlanRecommendAPI.requestArgument = @{
                                             @"cashType" : @"newbie"
                                             };
#else
    homePlanRecommendAPI.requestArgument = @{
                                             @"cashType" : @"all"
                                             };
#endif
    kWeakSelf
    [homePlanRecommendAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        int codeValue = [responseObject[@"status"] intValue];
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        weakSelf.homeBaseModel = [HXBHomeBaseModel yy_modelWithDictionary:baseDic];
        if (!codeValue) {
            //对数据进行异步缓存
            [PPNetworkCache setHttpCache:responseObject URL:kHXBHome_HomeURL parameters:nil];
        }
        else {
            [weakSelf loadCacheData];
        }
        if (callbackBlock) {
            callbackBlock(!codeValue);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf loadCacheData];
        callbackBlock(NO);
    }];
}

- (void)loadCacheData {
    id responseObject = [PPNetworkCache httpCacheForURL:kHXBHome_HomeURL parameters:nil];
    NSDictionary *baseDic = [responseObject valueForKey:@"data"];
    self.homeBaseModel = [HXBHomeBaseModel yy_modelWithDictionary:baseDic];
}
- (void)setHomeBaseModel:(HXBHomeBaseModel *)homeBaseModel
{
    _homeBaseModel = homeBaseModel;
    self.homeDataList = [NSMutableArray array];
    if (homeBaseModel.newbieProductData.dataList.count > 0) {
        [self.homeDataList addObjectsFromArray:homeBaseModel.newbieProductData.dataList];
        homeBaseModel.newbieProductData.dataList.lastObject.isShowNewBieBackgroundImageView = YES;
    }
    [self.homeDataList addObjectsFromArray:homeBaseModel.homePlanRecommend];
}




@end

//
//  HxbHomeRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomeRequest.h"
#import "HxbAccountAssetAPI.h"
#import "HxbHomePageModel.h"
@implementation HxbHomeRequest

#pragma mark -  数据请求
- (void)homeAccountAssetWithUserID: (NSString *)userId andSuccessBlock: (void(^)(HxbHomePageViewModel *viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    HxbAccountAssetAPI *accountAsseAPI = [[HxbAccountAssetAPI alloc]init];
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
            NSLog(@"✘ 首页资金等- 请求没有数据");
            failureBlock(error);
        }
    }];
}


@end

//
//  HXBHomePopVWViewModel.m
//  hoomxb
//
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomePopVWViewModel.h"
#import "HXBHomePopVWModel.h"

@implementation HXBHomePopVWViewModel

- (void)homePopViewRequestSuccessBlock: (void(^)(id responseObject,BOOL isSuccess))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    kWeakSelf
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBHome_PopView;
    versionUpdateAPI.requestMethod = NYRequestMethodGet;
    versionUpdateAPI.showHud = NO;
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        NSInteger status =  [responseObject[@"status"] integerValue];
        
        if (status) {
            kHXBResponsShowHUD
        }
        
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]] && !responseObject[@"data"][@"id"]) {
            successDateBlock(responseObject,NO);
        }
        if (successDateBlock) {
            weakSelf.homePopModel = [HXBHomePopVWModel yy_modelWithDictionary:responseObject[@"data"]];
            successDateBlock(responseObject,YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


@end

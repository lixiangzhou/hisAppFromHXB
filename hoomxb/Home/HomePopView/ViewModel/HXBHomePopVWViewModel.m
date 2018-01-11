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

- (void)homePopViewRequestSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBHome_PopView;
    versionUpdateAPI.requestMethod = NYRequestMethodGet;
    versionUpdateAPI.showHud = NO;
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSInteger status =  [responseObject[@"status"] integerValue];
        
        if (status) {
            kHXBResponsShowHUD
        }
        
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


@end

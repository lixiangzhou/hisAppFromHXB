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

- (void)homePopViewRequestSuccessBlock: (void(^)(BOOL isSuccess))successDateBlock
{
    kWeakSelf
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBHome_PopView;
    versionUpdateAPI.requestMethod = NYRequestMethodGet;
    versionUpdateAPI.showHud = NO;
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]] && !responseObject[@"data"][@"id"]) {
            if (successDateBlock) {
                successDateBlock(NO);
            }
            return;
        }
        if (successDateBlock) {
            weakSelf.homePopModel = [HXBHomePopVWModel yy_modelWithDictionary:responseObject[@"data"]];
            successDateBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (successDateBlock) {
            successDateBlock(NO);
        }
    }];
}


@end

//
//  HXBModifyTransactionPasswordRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordRequest.h"
#import "HXBAlterLoginPasswordAPI.h"
@implementation HXBModifyTransactionPasswordRequest
/*
- (void)planDetaileWithPlanID: (NSString *)financePlanId andSuccessBlock: (void(^)(HXBFinDetailViewModel_PlanDetail* viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
*/
- (void)myTransactionPasswordWithIDcard:(NSString *)IDcard andSuccessBlock: (void(^)(NSString*viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBAlterLoginPasswordAPI *alterLoginPasswordAPI = [[HXBAlterLoginPasswordAPI alloc] init];
    alterLoginPasswordAPI.requestArgument = @{
                                       @"identity" : IDcard
                                      };
    [alterLoginPasswordAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end

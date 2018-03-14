//
//  HXBMyPlanDetailsExitViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanDetailsExitViewModel.h"
#import "HXBOpenDepositAccountAgent.h"

@implementation HXBMyPlanDetailsExitViewModel

- (void)loadPlanListDetailsExitInfoWithPlanID: (NSString *)planID
                                    resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBMY_PlanQuitURL(planID);
    request.showHud = YES;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *dataDic = responseObject[kResponseData];
        [weakSelf.myPlanDetailsExitModel yy_modelSetWithDictionary:dataDic];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

- (void)exitPlanResultRequestWithPlanID: (NSString *)planID andSmscode:(NSString *)smscode andCallBackBlock:(void(^)(BOOL isSuccess))callBackBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBMY_PlanQuitResultURL(planID);
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"smscode" : smscode,
                                         };
    versionUpdateAPI.showHud = YES;
    kWeakSelf
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *dataDic = responseObject[kResponseData];
        [weakSelf.myPlanDetailsExitResultModel yy_modelSetWithDictionary:dataDic];
        if (callBackBlock) {
            callBackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (callBackBlock) {
            [weakSelf showToast:request.responseObject[kResponseMessage]];
            callBackBlock(NO);
        }
    }];
    
}

- (void)getVerifyCodeRequesWithExitPlanWithAction:(NSString *)action andWithType:(NSString *)type andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock {
    kWeakSelf
    [HXBOpenDepositAccountAgent verifyCodeRequestWithResultBlock:^(NYBaseRequest *request) {
        request.requestArgument = @{
                                    @"action":action,
                                    @"type":type
                                    };
        request.hudDelegate = weakSelf;
        request.showHud = NO;
    } resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            callbackBlock(NO,error);
        }
        else {
            callbackBlock(YES,nil);
        }
    }];
}

@end

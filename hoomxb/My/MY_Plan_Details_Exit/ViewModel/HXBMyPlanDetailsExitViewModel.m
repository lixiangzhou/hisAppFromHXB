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
    request.requestUrl = kHXBMY_PlanDetaileURL(planID);
//    request.showHud = NO;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *dataDic = responseObject[kResponseData];
        [weakSelf.myPlanDetailsExitModel yy_modelSetWithDictionary:dataDic];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

- (void)exitPlanResultRequestWithSmscode:(NSString *)smscode andCallBackBlock:(void(^)(BOOL isSuccess))callBackBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = @"";
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"smscode" : smscode,
                                         };
    versionUpdateAPI.showHud = YES;
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        if (callBackBlock) {
            callBackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (callBackBlock) {
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
        request.showHud = YES;
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

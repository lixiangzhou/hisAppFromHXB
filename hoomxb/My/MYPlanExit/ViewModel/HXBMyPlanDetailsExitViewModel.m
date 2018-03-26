//
//  HXBMyPlanDetailsExitViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanDetailsExitViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "NSString+HxbPerMilMoney.h"
@implementation HXBMyPlanDetailsExitViewModel

//获取账户内红利计划退出信息
- (void)loadPlanListDetailsExitInfoWithPlanID: (NSString *)planID
                           inCoolingOffPeriod: (BOOL)inCoolingOffPeriod
                                  resultBlock: (void(^)(BOOL isSuccess))resultBlock
{
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = inCoolingOffPeriod?kHXBMY_PlanCancelBuyURL(planID):kHXBMY_PlanBeforeQuitURL(planID);
    request.showHud = YES;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        weakSelf.myPlanDetailsExitModel = [HXBMyPlanDetailsExitModel yy_modelWithJSON:responseObject[kResponseData]];
        if (inCoolingOffPeriod) {
            weakSelf.myPlanDetailsExitModel.cancelAmount = [NSString hxb_getPerMilWithDouble:[weakSelf.myPlanDetailsExitModel.cancelAmount doubleValue]];
            weakSelf.myPlanDetailsExitModel.cancelTime = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:weakSelf.myPlanDetailsExitModel.cancelTime andDateFormat:@"yyyy-MM-dd"];
        } else {
            NSString *earnInterestNow = weakSelf.myPlanDetailsExitModel.earnInterestNow;
            NSString *totalEarnInterest= weakSelf.myPlanDetailsExitModel.totalEarnInterest;
            if (!earnInterestNow && totalEarnInterest) {
                weakSelf.myPlanDetailsExitModel.earnInterestNow = [NSString hxb_getPerMilWithDouble:[weakSelf.myPlanDetailsExitModel.totalEarnInterest doubleValue]];
            } else if (!earnInterestNow && !totalEarnInterest) {
                weakSelf.myPlanDetailsExitModel.earnInterestNow = @"";
            }
            weakSelf.myPlanDetailsExitModel.amount = [NSString hxb_getPerMilWithDouble:[weakSelf.myPlanDetailsExitModel.amount doubleValue]];
            weakSelf.myPlanDetailsExitModel.endLockingTime = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:weakSelf.myPlanDetailsExitModel.endLockingTime andDateFormat:@"yyyy-MM-dd"];
        }
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

//获取点击账户内红利计划确认退出结果
- (void)exitPlanResultRequestWithPlanID: (NSString *)planID
                     inCoolingOffPeriod: (BOOL)inCoolingOffPeriod
                             andSmscode:(NSString *)smscode
                       andCallBackBlock:(void(^)(BOOL isSuccess))callBackBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = inCoolingOffPeriod?kHXBMY_PlanCancelBuyResultURL(planID):kHXBMY_PlanQuitResultURL(planID);
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"smscode" : smscode,
                                         };
    versionUpdateAPI.showHud = YES;
    kWeakSelf
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        weakSelf.myPlanDetailsExitResultModel = [HXBMyPlanDetailsExitResultModel yy_modelWithJSON:responseObject[kResponseData]];
        if (callBackBlock) {
            callBackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (callBackBlock) {
            callBackBlock(NO);
        }
    }];
    
}

//获取退出短验
- (void)getVerifyCodeRequesWithExitPlanWithAction:(NSString *)action
                                      andWithType:(NSString *)type
                                 andCallbackBlock: (void(^)(BOOL isSuccess,NSError *error))callbackBlock
{
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

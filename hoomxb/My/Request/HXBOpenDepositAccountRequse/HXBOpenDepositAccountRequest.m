//
//  HXBOpenDepositAccountRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountRequest.h"
#import "HXBBaseRequest.h"
#import "HXBCardBinModel.h"
@implementation HXBOpenDepositAccountRequest



- (void)accountRechargeRequestWithRechargeAmount:(NSString *)amount andWithType:(NSString *)type  andWithAction:(NSString *)action andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = [NSString stringWithFormat:@"%@",kHXBUser_smscodeURL];
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"amount" : amount,
                                         @"action":action,
                                         @"type":type
                                         };
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            kHXBResponsShowHUD
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        //        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

- (void)accountRechargeRequestWithRechargeAmount:(NSString *)amount andWithAction:(NSString *)action andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = [NSString stringWithFormat:@"%@",kHXBUser_smscodeURL];
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"amount" : amount,
                                         @"action":action
                                         };
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            kHXBResponsShowHUD
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
//        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

- (void)accountRechargeResultRequestWithSmscode:(NSString *)smscode andWithQuickpayAmount:(NSString *)amount andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBAccount_quickpay;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"smscode" : smscode,
                                         @"amount" : amount
                                         };

    [versionUpdateAPI startWithHUDStr:kLoadIngText Success:^(NYBaseRequest *request, id responseObject) {
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}


/**
 卡bin校验

 @param bankNumber 银行卡号
 @param isToast 是否需要提示信息
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)checkCardBinResultRequestWithBankNumber:(NSString *)bankNumber andisToastTip:(BOOL)isToast andSuccessBlock: (void(^)(HXBCardBinModel *cardBinModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBUser_checkCardBin;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    if (bankNumber == nil) bankNumber = @"";
    versionUpdateAPI.requestArgument = @{
                                         @"bankCard" : bankNumber
                                         };
    versionUpdateAPI.isUPReloadData = !isToast;
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            if (isToast && (status != kHXBCode_Enum_ProcessingField)) {
                [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
            }
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
        }
        
        HXBCardBinModel *cardBinModel = [HXBCardBinModel yy_modelWithDictionary:responseObject[@"data"]];
        if (successDateBlock) {
            successDateBlock(cardBinModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}

@end

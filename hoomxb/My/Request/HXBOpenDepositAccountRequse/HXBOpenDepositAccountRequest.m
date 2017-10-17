//
//  HXBOpenDepositAccountRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountRequest.h"
#import "HXBBaseRequest.h"
#import "HXBCardBinModel.h"
@implementation HXBOpenDepositAccountRequest

- (void)openDepositAccountRequestWithArgument:(NSDictionary *)requestArgument andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBOpenDepositAccount_Escrow;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = requestArgument;
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status == 5068) {
            NSString *string = [NSString stringWithFormat:@"您信息填写有误，为保障账户安全，请及时联系客服 %@", kServiceMobile];
            HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"" Massage:string force:2 andLeftButtonMassage:@"暂不联系" andRightButtonMassage:@"联系客服"];
   
                alertVC.messageHeight = 50;
            
            alertVC.isHIddenLeftBtn = NO;
            alertVC.isCenterShow = YES;
            [alertVC setClickXYRightButtonBlock:^{
                NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", kServiceMobile];
                NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
                if (compare == NSOrderedDescending || compare == NSOrderedSame) {
                    /// 大于等于10.0系统使用此openURL方法
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
                }
            }];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
            return;
        }
        if (status != 0) {
            if (failureBlock) {
                failureBlock(responseObject);
            }
            if (status == 1) {
                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            }
            return;
        }
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

- (void)bindBankCardRequestWithArgument:(NSDictionary *)requestArgument andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBAccount_Bindcard;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = requestArgument;
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            if (status == 5068) {
                [self showAlertWithMessage:@"您的绑卡操作已超限，请明日再试"];
            } else {
                if (status == 104) return;
                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            }
//            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
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

- (void)showAlertWithMessage:(NSString *)message {
    HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"" Massage:message force:2 andLeftButtonMassage:@"" andRightButtonMassage:@"知道了"];
    if (message.length > 20) {
        alertVC.messageHeight = 60;
    } else {
        alertVC.messageHeight = 40;
    }
    alertVC.isHIddenLeftBtn = YES;
    alertVC.isCenterShow = YES;
    [alertVC setClickXYRightButtonBlock:^{
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

- (void)accountRechargeRequestWithRechargeAmount:(NSString *)amount andWithAction:(NSString *)action andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = [NSString stringWithFormat:@"%@%@",kHXBAccount_quickpay_smscode,action];
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"amount" : amount
                                         };
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            if (status != 104) {
                [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            }
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
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
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBAccount_quickpay;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"smscode" : smscode,
                                         @"amount" : amount
                                         };
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
//        NSInteger status =  [responseObject[@"status"] integerValue];
//        if (status != 0) {
//            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
//            if (failureBlock) {
//                failureBlock(responseObject);
//            }
//            return;
//        }
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
 @param isTost 是否需要提示信息
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)checkCardBinResultRequestWithSmscode:(NSString *)bankNumber andisTostTip:(BOOL)isTost andSuccessBlock: (void(^)(HXBCardBinModel *cardBinModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBUser_checkCardBin;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    if (bankNumber == nil) bankNumber = @"";
    versionUpdateAPI.requestArgument = @{
                                         @"bankCard" : bankNumber
                                         };
    versionUpdateAPI.isUPReloadData = !isTost;
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            if (isTost && (status != 104)) {
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

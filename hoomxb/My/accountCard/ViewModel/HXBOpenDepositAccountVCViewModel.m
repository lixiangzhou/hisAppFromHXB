//
//  HXBOpenDepositAccountVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountVCViewModel.h"
#import "HXBCardBinModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBBankCardModel.h"
@interface HXBOpenDepositAccountVCViewModel()

@property (nonatomic, strong) NYBaseRequest *cardBinrequest;

@property (nonatomic, assign) BOOL cardBinIsShowTost;

@end

@implementation HXBOpenDepositAccountVCViewModel

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqualToString:kHXBOpenDepositAccount_Escrow]) {
        NSInteger status =  [request.responseObject[@"status"] integerValue];
        if (status == kHXBOpenAccount_Outnumber) {
            return NO;
        }
    }
    else if ([request.requestUrl isEqualToString:kHXBUser_checkCardBin] && !self.cardBinIsShowTost) {
        return NO;
    }
    return [super erroStateCodeDeal:request];
}

- (BOOL)erroResponseCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqualToString:kHXBUser_checkCardBin] && !self.cardBinIsShowTost) {
        return NO;
    } else if ([request.requestUrl isEqualToString:kHXBUserInfo_BankCard]) {
        return NO;
    }
    return [super erroStateCodeDeal:request];
}

- (void)openDepositAccountRequestWithArgument:(NSDictionary *)requestArgument andCallBack:(void(^)(BOOL isSuccess))callBackBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBOpenDepositAccount_Escrow;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = requestArgument;
    versionUpdateAPI.showHud = YES;
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        
        if (callBackBlock) {
            callBackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        
        if (request.responseObject) {
            NSInteger status =  [request.responseObject[@"status"] integerValue];
            if (status == kHXBOpenAccount_Outnumber) {
                NSString *string = [NSString stringWithFormat:@"您今日开通存管错误次数已超限，请明日再试。如有疑问可联系客服 %@", kServiceMobile];
                
                HXBGeneralAlertVC *alertVC = [[HXBGeneralAlertVC alloc] initWithMessageTitle:@"" andSubTitle:string andLeftBtnName:@"取消" andRightBtnName:@"联系客服" isHideCancelBtn:YES isClickedBackgroundDiss:NO];
                alertVC.isCenterShow = YES;
                [alertVC setRightBtnBlock:^{
                    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", kServiceMobile];
                    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0" options:NSNumericSearch];
                    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
                        /// 大于等于10.0系统使用此openURL方法
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
                    } else {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
                    }
                }];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:NO completion:nil];
                return;
            }
        }
        
        if (callBackBlock) {
            callBackBlock(NO);
        }
    }];
    
}

/**
 卡bin校验
 
 @param bankNumber 银行卡号
 @param isToast 是否需要提示信息
 @param callBackBlock 回调
 */
- (void)checkCardBinResultRequestWithBankNumber:(NSString *)bankNumber andisToastTip:(BOOL)isToast andCallBack:(void(^)(BOOL isSuccess))callBackBlock
{
    [self.cardBinrequest cancelRequest];
    if (bankNumber == nil) bankNumber = @"";
    kWeakSelf
    [HXBOpenDepositAccountAgent checkCardBinResultRequestWithResultBlock:^(NYBaseRequest *request) {
        request.hudDelegate = weakSelf;
        request.requestArgument = @{
                            @"bankCard" : bankNumber
                            };
        request.showHud = isToast;
        weakSelf.cardBinrequest = request;
        weakSelf.cardBinIsShowTost = isToast;
    } resultBlock:^(HXBCardBinModel *cardBinModel, NSError *error) {
        NSLog(@"%@",error);
        if (error) {
            callBackBlock(NO);
        }
        else {
            weakSelf.cardBinModel = cardBinModel;
            callBackBlock(YES);
        }
    }];
}

- (void)getAccountBankcardUserInformationWithCallBack:(void(^)(BOOL isSuccess))callBackBlock{
    NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
    bankCardAPI.requestMethod = NYRequestMethodGet;
    kWeakSelf
    [bankCardAPI loadData:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        weakSelf.bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
        if (callBackBlock) {
            callBackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (callBackBlock) {
            callBackBlock(NO);
            if (!request.responseObject && error.code != kHXBCode_AlreadyPopWindow) {
                [HxbHUDProgress showTextWithMessage:@"银行卡请求失败"];
            }
        }
    }];
}

@end

//
//  HXBBankCardViewModel.m
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankCardViewModel.h"
#import "HXBOpenDepositAccountAgent.h"
#import "HXBCardBinModel.h"
@interface HXBBankCardViewModel()

@property (nonatomic, strong) NYBaseRequest *cardBinrequest;

@property (nonatomic, assign) BOOL cardBinIsShowTost;

@end

@implementation HXBBankCardViewModel

- (void)requestBankDataResultBlock:(void(^)(BOOL isSuccess))resultBlock {
    
    NYBaseRequest *bankCardAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    bankCardAPI.requestUrl = kHXBUserInfo_BankCard;
    bankCardAPI.requestMethod = NYRequestMethodGet;
    bankCardAPI.showHud = YES;
    kWeakSelf
    [bankCardAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        weakSelf.bankCardModel = [HXBBankCardModel yy_modelWithJSON:responseObject[@"data"]];
        if (resultBlock) {
            resultBlock(YES);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        
        NSDictionary *responseObject = request.responseObject;
        
        if (responseObject) {
            [weakSelf showToast:@"银行卡请求失败"];
        }
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

- (BOOL)erroStateCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqualToString:kHXBAccount_Bindcard]) {
        NSInteger status =  [request.responseObject[@"status"] integerValue];
        if (status == kHXBOpenAccount_Outnumber) {
            return NO;
        }
    }
    else if ([request.requestUrl isEqualToString:kHXBUser_checkCardBin] && !self.cardBinIsShowTost) {
        return NO;
    }
    else if([request.requestUrl isEqualToString:kHXBUserInfo_UnbindBankCard]){
        return NO;
    }
    
    return [super erroStateCodeDeal:request];
}

- (BOOL)erroResponseCodeDeal:(NYBaseRequest *)request {
    if ([request.requestUrl isEqualToString:kHXBUser_checkCardBin] && !self.cardBinIsShowTost) {
        return NO;
    }
    else if([request.requestUrl isEqualToString:kHXBUserInfo_UnbindBankCard]){
        return NO;
    }
    
    return [super erroStateCodeDeal:request];
}

- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel {
    _bankCardModel = bankCardModel;
    
    _bankImageString = bankCardModel.bankCode;
    
    _bankName = bankCardModel.bankType;
    
    _bankNoStarFormat = [bankCardModel.cardId hxb_hiddenBankCard];
    
    _bankNoLast4 = [bankCardModel.cardId substringFromIndex:bankCardModel.cardId.length - 4];
    
    _bankNameNo4 = [NSString stringWithFormat:@"%@（尾号%@）", _bankName, _bankNoLast4];
    
    _userNameOnlyLast = [bankCardModel.name replaceStringWithStartLocation:0 lenght:bankCardModel.name.length - 1];
}

- (void)requestUnBindWithParam:(NSDictionary *)param finishBlock:(void (^)(BOOL, NSString *, BOOL))finishBlock
{
    NYBaseRequest *bindAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    bindAPI.requestUrl = kHXBUserInfo_UnbindBankCard;
    bindAPI.requestMethod = NYRequestMethodPost;
    bindAPI.requestArgument = param;
    bindAPI.showHud = YES;
    kWeakSelf
    [bindAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (finishBlock) {
            finishBlock(YES, responseObject.message, YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSDictionary *responseObject = request.responseObject;
        if(responseObject){
            if (responseObject.statusCode == kHXBCode_UnBindCardFail) {
                if(finishBlock) {
                    finishBlock(NO, responseObject.message, YES);
                }
            } else {
                [weakSelf showToast:responseObject.message];
                if (finishBlock) {
                    finishBlock(NO, nil, NO);
                }
            }
        }
        else{
            if (finishBlock) {
                finishBlock(NO, nil, NO);
            }
        }
    }];
}

- (void)bindBankCardRequestWithArgument:(NSDictionary *)requestArgument andFinishBlock:(void (^)(BOOL isSuccess))finishBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    versionUpdateAPI.requestUrl = kHXBAccount_Bindcard;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = requestArgument;
    versionUpdateAPI.showHud = YES;
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        if (finishBlock) {
            finishBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (request.responseObject) {
            NSInteger status =  [request.responseObject[@"status"] integerValue];
            if (status == kHXBOpenAccount_Outnumber) {
                NSString *string = [NSString stringWithFormat:@"您今日绑卡错误次数已超限，请明日再试。如有疑问可联系客服 \n%@", kServiceMobile];
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
                return ;
            }
        }
        if (finishBlock) {
            finishBlock(NO);
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

- (NSString *)validateIdCardNo:(NSString *)cardNo
{
    if (!(cardNo.length > 0)) {
        return @"身份证号不能为空";
    }
    if (cardNo.length != 18)
    {
        return @"身份证号输入有误";
    }
    return nil;
}

- (NSString *)validateTransactionPwd:(NSString *)transactionPwd
{
    if(!(transactionPwd.length > 0))
    {
        return @"交易密码不能为空";
    }
    if (transactionPwd.length != 6) {
        return @"交易密码为6位数字";
    }
    return nil;
}
@end

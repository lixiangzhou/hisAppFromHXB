//
//  HXBBankCardViewModel.m
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankCardViewModel.h"
#import "NYBaseRequest+HXB.h"

@implementation HXBBankCardViewModel

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
    [NYBaseRequest requestWithRequestUrl:kHXBUserInfo_UnbindBankCard param:param method:NYRequestMethodPost success:^(NYBaseRequest *request, NSDictionary *responseObject) {
        
        if (finishBlock == nil) {
            return;
        }
        
        if (responseObject.isSuccess) {
            finishBlock(YES, responseObject.message, YES);
        } else {
            if (responseObject.statusCode == kHXBCode_UnBindCardFail) {
                finishBlock(NO, responseObject.message, YES);
            } else {
                finishBlock(NO, responseObject.message, NO);
            }
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        
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

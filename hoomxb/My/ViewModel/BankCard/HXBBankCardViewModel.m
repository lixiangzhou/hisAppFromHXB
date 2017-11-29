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
    
    _bankNumStarFormat = [bankCardModel.cardId hxb_hiddenBankCard];
    
    _bankNumLast4 = [bankCardModel.cardId substringFromIndex:bankCardModel.cardId.length - 4];
    
    _userNameOnlyLast = [bankCardModel.name replaceStringWithStartLocation:0 lenght:bankCardModel.name.length - 1];
}

- (void)requestUnBindWithIdCardNum:(NSString *)idCardNum transactionPwd:(NSString *)transactionPwd finishBlock:(void (^)(BOOL, NSString *, BOOL))finishBlock
{
    [NYBaseRequest requestWithRequestUrl:kHXBUserInfo_UnbindBankCard param:@{@"idCardNo": idCardNum, @"cashPassword": transactionPwd} method:NYRequestMethodPost success:^(NYBaseRequest *request, NSDictionary *responseObject) {
        
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
@end

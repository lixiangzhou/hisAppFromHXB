//
//  HXBBankCardViewModel.m
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankCardViewModel.h"

@implementation HXBBankCardViewModel

- (void)setBankCardModel:(HXBBankCardModel *)bankCardModel {
    _bankCardModel = bankCardModel;
    
    _bankImageString = bankCardModel.bankCode;
    
    _bankName = bankCardModel.bankType;
    
    _bankNumStarFormat = [bankCardModel.cardId hxb_hiddenBankCard];
    
    _bankNumLast4 = [bankCardModel.cardId substringFromIndex:bankCardModel.cardId.length - 4];
    
    _userName = [bankCardModel.name replaceStringWithStartLocation:0 lenght:bankCardModel.name.length - 1];;
}

- (void)requestUnBindWithIdCardNum:(NSString *)idCardNum transactionPwd:(NSString *)transactionPwd finishBlock:(void (^)(BOOL, NSString *))finishBlock
{
    
}
@end

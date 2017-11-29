//
//  HXBBankCardViewModel.h
//  hoomxb
//
//  Created by lxz on 2017/11/29.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBankCardModel.h"

@interface HXBBankCardViewModel : NSObject
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

/// 银行图片
@property (nonatomic, copy, readonly) NSString *bankImageString;
/// 银行名
@property (nonatomic, copy, readonly) NSString *bankName;
/// 银行卡号码: **** **** **** 1234
@property (nonatomic, copy, readonly) NSString *bankNumStarFormat;
/// 银行卡后4位
@property (nonatomic, copy, readonly) NSString *bankNumLast4;
/// 持卡人名字, 只显示最后一个字: **子
@property (nonatomic, copy, readonly) NSString *userNameOnlyLast;


#pragma mark - Method


/**
 解绑银行卡

 @param idCardNum 银行卡号
 @param transactionPwd 交易密码
 @param finishBlock 完成回调，canPush 在成功或者是 statusCode == kHXBCode_UnBindCardFail 时为 YES，否则为NO，需要toast errorMessage
 */
- (void)requestUnBindWithParam:(NSDictionary *)param finishBlock:(void (^)(BOOL succeed, NSString *errorMessage, BOOL canPush))finishBlock;

@end

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
/// 持卡人名字
@property (nonatomic, copy, readonly) NSString *userName;


#pragma mark - Method

- (void)requestUnBindWithIdCardNum:(NSString *)idCardNum transactionPwd:(NSString *)transactionPwd finishBlock:(void (^)(BOOL succeed, NSString *errorMessage))finishBlock;

@end

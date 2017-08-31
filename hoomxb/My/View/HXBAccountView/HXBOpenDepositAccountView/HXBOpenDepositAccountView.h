//
//  HXBOpenDepositAccountView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBBankCardModel;
@interface HXBOpenDepositAccountView : UIView

//用户信息
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userModel;

/**
 bankCode
 */
@property (nonatomic, copy) NSString *bankCode;
/**
 银行名称
 */
@property (nonatomic, copy) NSString *bankName;

/**
 bankNameBlock
 */
@property (nonatomic, copy) void(^bankNameBlock)();
//底部按钮
@property (nonatomic, strong) UIButton *bottomBtn;
/**
 开通账户
 */
@property (nonatomic, copy)  void(^openAccountBlock)(NSDictionary *dic);
/**
 存管协议
 */
- (void)clickTrustAgreementWithBlock:(void(^)(BOOL isThirdpart))clickTrustAgreement;
//设置用户
- (void)setupUserIfoData:(HXBRequestUserInfoViewModel *)viewModel;
//设置银行卡信息
- (void)setupBankCardData:(HXBBankCardModel *)bankCardModel;
@end

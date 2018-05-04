//
//  HXBOpenDepositAccountVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBCardBinModel.h"
#import "HXBBankCardModel.h"
#import "HXBLazyCatRequestModel.h"

@interface HXBOpenDepositAccountVCViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBCardBinModel *cardBinModel;

@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@property (nonatomic, strong)  HXBLazyCatRequestModel *lazyCatReqModel;
/**
 开通存管账户
 
 @param requestArgument 存款账户的字典数据
 */
- (void)openDepositAccountRequestWithArgument:(NSDictionary *)requestArgument andCallBack:(void(^)(BOOL isSuccess))callBackBlock;

/**
 懒猫—存管开户
 */
- (void)openDepositoryWithUsrname:(NSString *)username idNo:(NSString *)idNo bankNo:(NSString *)bankNo resultBlock:(void(^)(BOOL isSuccess))resultBlock;


/**
 卡bin校验
 
 @param bankNumber 银行卡号
 @param isToast 是否需要提示信息
 @param callBackBlock 回调
 */
- (void)checkCardBinResultRequestWithBankNumber:(NSString *)bankNumber andisToastTip:(BOOL)isToast andCallBack:(void(^)(BOOL isSuccess))callBackBlock;

/**
 获取用户绑卡信息

 @param callBackBlock 回调
 */
- (void)getAccountBankcardUserInformationWithCallBack:(void(^)(BOOL isSuccess))callBackBlock;
@end

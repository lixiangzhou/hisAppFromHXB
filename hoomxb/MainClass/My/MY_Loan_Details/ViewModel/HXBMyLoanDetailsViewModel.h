//
//  HXBMyLoanDetailsViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/6.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
@class HXBTransferConfirmModel;

@interface HXBMyLoanDetailsViewModel : HXBBaseViewModel

@property (nonatomic, readonly, strong) HXBTransferConfirmModel *transferConfirmModel;
@property (nonatomic, readonly, strong) NSDictionary *responseObject;

/**
 账户内-债权转让确认页

 @param transferID 标的id号
 @param resultBlock 返回数据
 */
- (void)accountLoanTransferRequestWithTransferID: (NSString *)transferID
                                     resultBlock: (void(^)(BOOL isSuccess))resultBlock;
/**
 账户内-债权转让功能接口

 @param transferID 标的id号
 @param password 交易密码
 @param currentTransferValue 债转金额
 @param resultBlock 返回数据
 */
- (void)accountLoanTransferRequestResultWithTransferID: (NSString *)transferID
                                              password:(NSString *)password
                                  currentTransferValue:(NSString *)currentTransferValue
                                           resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end

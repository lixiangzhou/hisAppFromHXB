//
//  HXBMyTopUpVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBLazyCatRequestModel.h"
#import "HXBBankCardModel.h"

@interface HXBMyTopUpVCViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBLazyCatRequestModel *lazyCatReqModel;
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;
/**
 快捷充值接口
 */
- (void)accountQuickChargeWithAmount:(NSString *)amount resultBlock:(void(^)(BOOL isSuccess))resultBlock;

/// 请求顶部银行卡信息
- (void)requestBankData:(void(^)(BOOL isSuccess))resultBlock;
@end

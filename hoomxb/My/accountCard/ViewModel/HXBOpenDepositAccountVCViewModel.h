//
//  HXBOpenDepositAccountVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBOpenDepositAccountVCViewModel : HXBBaseViewModel

/**
 开通存管账户
 
 @param requestArgument 存款账户的字典数据
 */
- (void)openDepositAccountRequestWithArgument:(NSDictionary *)requestArgument andCallBack:(void(^)(BOOL isSuccess))callBackBlock;

/**
 更新用户信息

 @param resultBlock 结果回调
 */
- (void)downLoadUserInfoWithResultBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))resultBlock;
@end

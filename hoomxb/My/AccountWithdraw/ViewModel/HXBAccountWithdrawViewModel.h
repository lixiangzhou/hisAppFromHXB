//
//  HXBAccountWithdrawViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBAccountWithdrawViewModel : HXBBaseViewModel

/**
 账户提现

 @param parameter 请求参数
 @param resultBlock 返回结果
 */
- (void)accountWithdrawaWithParameter: (NSMutableDictionary *)parameter
                          resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end

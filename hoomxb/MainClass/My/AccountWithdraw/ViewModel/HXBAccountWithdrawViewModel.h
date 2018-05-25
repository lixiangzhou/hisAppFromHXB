//
//  HXBAccountWithdrawViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBLazyCatRequestModel.h"

@class HXBWithdrawModel;
@interface HXBAccountWithdrawViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBLazyCatRequestModel *lazyCatReqModel;

@property (nonatomic, strong) HXBWithdrawModel *withdrawModel;

- (void)accountWithdrawalWithAmount:(NSString *)amount resultBlock:(void(^)(BOOL isSuccess))resultBlock;

/**
 账户提现

 @param parameter 请求参数
 @param resultBlock 返回结果
 */
- (void)accountWithdrawaWithParameter: (NSMutableDictionary *)parameter
                     andRequestMethod: (NYRequestMethod)requestMethod
                          resultBlock: (void(^)(BOOL isSuccess))resultBlock;
@end

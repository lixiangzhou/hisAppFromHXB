//
//  HXBFincreditorChangebuyViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/8.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBLazyCatRequestModel.h"
#import "HXBBaseViewModel+HXBBankCardInfo.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBFincreditorChangebuyViewModel : HXBBaseViewModel

/**
 债转购买结果Model
 */
@property (nonatomic, strong) HXBLazyCatRequestModel *resultModel;

/**
 债权充值结果
 
 @param parameter 购买参数
 @param resultBlock 返回结果
 */
- (void)rechargeWithParameter : (NSDictionary *)parameter
                  resultBlock : (void(^)(BOOL isSuccess))resultBlock;
/**
 债权购买结果

 @param parameter 购买参数
 @param resultBlock 返回结果
 */
- (void)loanTransformBuyReslutWithParameter : (NSDictionary *)parameter
                                resultBlock : (void(^)(BOOL isSuccess))resultBlock;


@end

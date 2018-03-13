//
//  HXBMyPlanBuyViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFin_Plan_BuyViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBMyPlanBuyViewModel : HXBBaseViewModel

/**
 账户内购买成功返回的Model
 */
@property (nonatomic, strong) HXBFin_Plan_BuyViewModel *resultModel;
/**
 错误状态码
 */
@property (nonatomic, assign) NSInteger errorCode;
/**
 错误描述
 */
@property (nonatomic, copy) NSString *errorMessage;


/**
 账户内计划购买接口

 @param planID 计划id
 @param parameter 请求参数
 @param resultBlock 返回数据
 */
- (void)myPlanBuyReslutWithPlanID: (NSString *)planID
                        parameter: (NSDictionary *)parameter
                      resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end

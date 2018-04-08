//
//  HXBBaseViewModel+HXBBankCardInfo.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBaseViewModel.h"
#import "HXBBankCardModel.h"
@class HXBModifyTransactionPasswordAgent;

@interface HXBBaseViewModel (HXBBankCardInfo)

/**
 银行卡信息
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

/**
 获取银行卡信息

 @param isShowHud 是否展示加载框
 @param resultBlock 返回数据
 */
- (void)getBankCardWithHud:(BOOL)isShowHud resultBlock:(void(^)(BOOL isSuccess))resultBlock;


@end

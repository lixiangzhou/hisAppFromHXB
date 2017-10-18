//
//  HXBFin_Buy_ViewModel.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXBBankCardModel.h"

typedef void(^successBlock)(NSDictionary *dateDic);
typedef void(^successModelBlock)(HXBBankCardModel *model);
typedef void(^failureBlock)();

@interface HXBFin_Buy_ViewModel : NSObject
// 获取银行卡信息
+ (void)requestForBankCardSuccessBlock:(successModelBlock)successDateBlock;

@end

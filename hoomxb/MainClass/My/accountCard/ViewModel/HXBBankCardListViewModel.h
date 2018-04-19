//
//  HXBBankCardListViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/2/25.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBBankCardListViewModel : HXBBaseViewModel

@property (nonatomic, strong) NSMutableArray *bankListModels;

/**
 获取银行卡列表

 */
- (void)bankCardListRequestWithResultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end

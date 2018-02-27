//
//  HXBBankCardListViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/2/25.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankCardListViewModel.h"
#import "HXBBankList.h"

@implementation HXBBankCardListViewModel

- (void)bankCardListRequestWithResultBlock: (void(^)(BOOL isSuccess))resultBlock
{
    kWeakSelf
    NYBaseRequest *alterLoginPasswordAPI = [[NYBaseRequest alloc] init];
    alterLoginPasswordAPI.requestUrl = kHXBSetWithdrawals_banklistURL;
    alterLoginPasswordAPI.requestMethod = NYRequestMethodGet;
    //    alterLoginPasswordAPI.requestArgument = requestArgument;
    [alterLoginPasswordAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSArray *bankArr = responseObject[@"data"][@"dataList"];
        [bankArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakSelf.bankListModels addObject:[HXBBankList yy_modelWithJSON:obj]];
        }];
        
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        //        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

- (NSMutableArray *)bankListModels
{
    if (!_bankListModels) {
        _bankListModels = [NSMutableArray array];
    }
    return _bankListModels;
}

@end

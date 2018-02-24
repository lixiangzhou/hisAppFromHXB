//
//  HXBAccountWithdrawViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccountWithdrawViewModel.h"

@implementation HXBAccountWithdrawViewModel

- (void)accountWithdrawaWithParameter:(NSMutableDictionary *)parameter
                          resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBSetWithdrawals_withdrawURL;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = parameter;
    request.showHud = YES;
    
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}


@end

//
//  HXBMyTraderPasswordGetVerifyCodeViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyTraderPasswordGetVerifyCodeViewModel.h"

@implementation HXBMyTraderPasswordGetVerifyCodeViewModel

- (void)myTraderPasswordGetverifyCodeWithAction:(NSString *)action
                                    resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] init];
    request.requestUrl = kHXBUser_smscodeURL;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{@"action" : action};
    
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}
@end

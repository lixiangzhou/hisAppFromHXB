//
//  HXBModifyTransactionPasswordAgent.m
//  hoomxb
//
//  Created by caihongji on 2018/2/6.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBModifyTransactionPasswordAgent.h"

@implementation HXBModifyTransactionPasswordAgent

+ (void)modifyTransactionPasswordWithRequestBlock:(void(^)(NYBaseRequest *request))requestBlock resultBlock:(void (^)(BOOL isSuccess, NSError *error))resultBlock
{
    NYBaseRequest *request = [[NYBaseRequest alloc] init];
    request.requestMethod = NYRequestMethodPost;
    if (requestBlock) {
        requestBlock(request);
    }
    
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (resultBlock) {
            resultBlock(YES, nil);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if(request.responseObject){
            error = [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject];
        }
        if (resultBlock) {
            resultBlock(NO, error);
        }
    }];
}

@end

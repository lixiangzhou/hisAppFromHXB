//
//  HXBSetGesturePasswordAgent.m
//  hoomxb
//
//  Created by caihongji on 2018/2/25.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBSetGesturePasswordAgent.h"

@implementation HXBSetGesturePasswordAgent

+ (void)riskModifyScoreRequestWithScore:(void(^)(NYBaseRequest* request)) requestBlock resultBlock:(void(^)(id responseObject, NSError *error))resultBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBUser_riskModifyScoreURL;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    if(requestBlock) {
        requestBlock(versionUpdateAPI);
    }
    
    [versionUpdateAPI loadData:^(NYBaseRequest *request, id responseObject) {
        if (resultBlock) {
            resultBlock(responseObject, nil);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if(request.responseObject) {
            error = [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject];
        }
        if (resultBlock) {
            resultBlock(nil, error);
        }
    }];
}

@end

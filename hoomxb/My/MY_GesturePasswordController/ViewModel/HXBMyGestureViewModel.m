//
//  HXBMyGestureViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyGestureViewModel.h"

@implementation HXBMyGestureViewModel


- (void)accountSetGesturePasswordWithPassword:(NSString *)password
                                  resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBSetGesturePasswordRequest_CheckLoginPasswordURL;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{@"password" : password};
    
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];

}
@end

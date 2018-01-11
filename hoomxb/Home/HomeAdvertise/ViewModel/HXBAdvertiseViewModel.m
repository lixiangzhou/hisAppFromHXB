//
//  HXBAdvertiseViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAdvertiseViewModel.h"

@implementation HXBAdvertiseViewModel

- (void)requestSplashImages:(void (^)(NSString *imageUrl))resultBlock {
    // 无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    NYBaseRequest *splashTRequest = [[NYBaseRequest alloc] initWithDelegate:self];
    splashTRequest.requestUrl = kHXBSplash;
    
    [splashTRequest loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSString *imageURL = responseObject[kResponseData][@"url"];
        if (resultBlock) {
            resultBlock(imageURL);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(nil);
        }
    }];
}

@end

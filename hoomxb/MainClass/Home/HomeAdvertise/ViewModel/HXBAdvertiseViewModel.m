//
//  HXBAdvertiseViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBAdvertiseViewModel.h"
#import "HXBAdvertiseManager.h"

@implementation HXBAdvertiseViewModel

- (void)getSlash:(void (^)(BOOL isSuccess))resultBlock {
    if ([HXBAdvertiseManager shared].bannerModel) { // 如果已经请求下来数据，直接返回
        resultBlock(YES);
    } else {
        if ([HXBAdvertiseManager shared].requestCompleted) {    // 请求完成，但是没有数据，表示返回失败，返回NO
            resultBlock(NO);
        } else {    // 没有完成就等待请求完成，请求完成后 requestCompleted = YES
            __weak HXBAdvertiseManager *mgr = [HXBAdvertiseManager shared];
            [RACObserve([HXBAdvertiseManager shared], requestCompleted) subscribeNext:^(id  _Nullable x) {
                resultBlock(mgr.requestSuccess);
            }];
        }
    }
}

- (BannerModel *)bannerModel {
    [HXBAdvertiseManager shared].bannerModel.type = @"h5";
    [HXBAdvertiseManager shared].bannerModel.link = @"https:/www.baidu.com";
    return [HXBAdvertiseManager shared].bannerModel;
}

- (NSURL *)imageUrl {
    return [NSURL URLWithString:self.bannerModel.image];
}

- (BOOL)canToActivity {
    return self.bannerModel.link != nil && [self.bannerModel.link isEqualToString:@""] == NO;
}
     
@end

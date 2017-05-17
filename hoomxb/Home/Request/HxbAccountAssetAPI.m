//
//  HxbAccountAssetAPI.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbAccountAssetAPI.h"

@implementation HxbAccountAssetAPI

- (NSString *)requestUrl {
    return @"/account/asset.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

@end

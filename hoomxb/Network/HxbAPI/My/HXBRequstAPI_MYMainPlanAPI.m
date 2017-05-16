//
//  HXBRequstAPI_MYMainPlanAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequstAPI_MYMainPlanAPI.h"
///关于我的 plan 主要页面的api
////account/userfinanceplanlist.action
@implementation HXBRequstAPI_MYMainPlanAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/account/userfinanceplanlist.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

@end

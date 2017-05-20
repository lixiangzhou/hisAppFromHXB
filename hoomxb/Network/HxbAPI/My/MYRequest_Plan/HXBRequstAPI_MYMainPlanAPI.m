//
//  HXBRequstAPI_MYMainPlanAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequstAPI_MYMainPlanAPI.h"

@implementation HXBRequstAPI_MYMainPlanAPI
- (NSString *)requestUrl {
    return @"/account/userfinanceplanlist.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end

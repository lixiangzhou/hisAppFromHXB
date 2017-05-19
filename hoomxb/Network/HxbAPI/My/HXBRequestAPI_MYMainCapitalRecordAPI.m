//
//  HXBRequestAPI_MYMainCapitalRecordAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestAPI_MYMainCapitalRecordAPI.h"

@implementation HXBRequestAPI_MYMainCapitalRecordAPI
- (NSString *)requestUrl {
    return @"/account/userpointlog.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end

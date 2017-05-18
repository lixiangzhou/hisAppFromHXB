//
//  HXBRequstAPI_MYMainLoanAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequstAPI_MYMainLoanAPI.h"

@implementation HXBRequstAPI_MYMainLoanAPI
- (NSString *)requestUrl {
//    /account/userloanstatis.action
    return @"/account/userloanlist.action";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}
@end

//
//  HXBFinancing_LoanListAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_LoanListAPI.h"

@implementation HXBFinancing_LoanListAPI
//192.168.1.21:3000/lend/loanindex 散标列表 POST   散标list、

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/lend/loanindex";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

//- (id)requestArgument {
//    return @{};
//}

@end

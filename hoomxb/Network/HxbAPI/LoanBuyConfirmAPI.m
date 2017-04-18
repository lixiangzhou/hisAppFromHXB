//
//  LoanBuyConfirmAPI.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "LoanBuyConfirmAPI.h"

@implementation LoanBuyConfirmAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/confirm";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodGet;
}

- (id)requestArgument {
    return @{
             };
}

@end

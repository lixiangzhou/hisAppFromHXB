//
//  LoanBuyConfirmAPI.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "LoanBuyConfirmAPI.h"
//http://192.168.1.21:3000/loan/buy/confirm   POST   散标购买确认
@implementation LoanBuyConfirmAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/loan/buy/confirm";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

//- (id)requestArgument {
//    return @{
//             };
//}

@end

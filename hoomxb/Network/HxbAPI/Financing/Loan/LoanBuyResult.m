//
//  LoanBuyResult.m
//  hoomxb
//
//  Created by HXB on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "LoanBuyResult.h"
//192.168.1.21:3000/loan/buy/result      POST   散标购买结果
@implementation LoanBuyResult
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/loan/buy/result";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

//- (id)requestArgument {
//    return @{
//             };;
//}
@end

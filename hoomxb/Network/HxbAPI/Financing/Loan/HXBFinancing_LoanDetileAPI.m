//
//  HXBFinancing_LoanDetileAPI.m
//  hoomxb
//
//  Created by HXB on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_LoanDetileAPI.h"
///192.168.1.21:8070/lend/loanlenderallrecord
@implementation HXBFinancing_LoanDetileAPI
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/lend/loanlenderallrecord";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

- (id)requestArgument {
    return @{
             };
}
@end

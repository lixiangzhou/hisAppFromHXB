//
//  NSDictionary+HXBResponse.m
//  hoomxb
//
//  Created by lxz on 2017/12/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NSDictionary+HXBResponse.h"

@implementation NSDictionary (HXBResponse)
- (id)data {
    return self[kResponseData];
}

- (NSString *)message {
    return self[kResponseMessage];
}

- (NSInteger)statusCode {
    return [self[kResponseStatus] integerValue];
}

- (BOOL)isSuccess {
    return self.statusCode == kHXBCode_Success;
}

@end

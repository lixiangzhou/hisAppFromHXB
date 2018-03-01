//
//  NSDictionary+HXBResponse.h
//  hoomxb
//
//  Created by lxz on 2017/12/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HXBResponse)
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, assign, readonly) NSInteger statusCode;
// status == kHXBCode_Success
@property (nonatomic, assign, readonly, getter=isSuccess) BOOL success;
@end

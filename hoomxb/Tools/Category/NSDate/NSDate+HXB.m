//
//  NSDate+HXB.m
//  hoomxb
//
//  Created by lxz on 2017/11/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NSDate+HXB.h"

@implementation NSDate (HXB)

+ (NSString *)milliSecondSince1970 {
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970] * 1000;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    return [NSString stringWithFormat:@"%llu",theTime];
}

@end

//
//  NSString+CopiesTransfer.m
//  HongXiaoBao
//
//  Created by hoomsun on 2016/9/23.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "NSString+CopiesTransfer.h"

@implementation NSString (CopiesTransfer)

+ (NSString *)getCopiesStringWithCopiesValue:(double)copies
{
    // 先判断是否是整数,如果是整数直接截取小数点前数字
    int prefixNo = floor(copies);
    if (prefixNo == copies || (copies-prefixNo)<= 0.000001) {
        return [NSString stringWithFormat:@"%d",prefixNo];
    }
    
    // 截取后面的0
    NSString *copiesStr = [NSString stringWithFormat:@"%.5f",copies];
    NSInteger len = copiesStr.length;
    NSInteger subLen = 0;
    NSRange range = [copiesStr rangeOfString:@"."];
    if(range.location != NSNotFound)
    {
        subLen = len - range.location - 1;
    }
    if (subLen > 0) {
        
        for (long i = len - 1; i > range.location; i--) {
            if (![[copiesStr substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"0"]) {
                // 拿到i
                return [copiesStr substringToIndex:i+1];
            }
        }
    }
    return [NSString stringWithFormat:@"%d",prefixNo];

}



@end

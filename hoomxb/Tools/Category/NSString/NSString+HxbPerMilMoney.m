//
//  NSString+PerMilMoney.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/13.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "NSString+HxbPerMilMoney.h"

@implementation NSString (HxbPerMilMoney)

+(NSString *)GetPerMilWithDouble:(double)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    
    return formattedNumberString;
}
///后面拼接了 元
+ (NSString *)hxb_getPerMilWithDouble:(double)number {
    return [NSString stringWithFormat:@"%@元", [self GetPerMilWithDouble: number]];
}

+ (NSString *) hiddenStr: (NSString *)string MidWithFistLenth: (NSInteger)fistLenth andLastLenth: (NSInteger)lastLenth {
    if (string.length >= fistLenth + lastLenth) {
        NSString *str = [string substringWithRange:NSMakeRange(0, fistLenth)];
        NSString *strLast = [string substringWithRange:NSMakeRange(string.length - lastLenth, lastLenth)];
        NSMutableString *strMid = @"".mutableCopy;
        for (NSInteger i = (string.length - fistLenth - lastLenth); i > 0; i --) {
            [strMid appendString:@"*"];
        }
        string = [NSString stringWithFormat:@"%@%@%@",str,strMid,strLast];
    }
    return string;
}

///如果拼接的是最后一个字符串是“”，那么就默认为删除键，删除最后一个字符
- (NSString *) hxb_StringWithFormatAndDeleteLastChar: (NSString *)string {
    if (string != nil && !string.length && self.length >= 1) {
        NSMutableString *tempStr = self.mutableCopy;
        return [tempStr substringToIndex:self.length - 1].copy;
    }
    return [NSString stringWithFormat:@"%@%@",self,string];
}
@end

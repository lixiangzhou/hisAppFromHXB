//
//  NSString+PerMilMoney.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/13.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "NSString+HxbPerMilMoney.h"

@implementation NSString (HxbPerMilMoney)
///没有小数点
+ (NSString *)hxb_getPerMilWithDoubleNum:(double)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return formattedNumberString;
}

+(NSString *)GetPerMilWithDouble:(double)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    
    return formattedNumberString;
}
///后面拼接了 小数点 元
+ (NSString *)hxb_getPerMilWithDouble:(double)number {
    return [NSString stringWithFormat:@"%@元", [self GetPerMilWithDouble: number]];
}

///后面拼接了 元
+ (NSString *)hxb_getPerMilWithIntegetNumber:(double)number {
    return [NSString stringWithFormat:@"%@元", [self hxb_getPerMilWithDoubleNum: number]];
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

/// 对数字取整
+ (NSString *)getIntegerStringWithNumber:(double)number fractionDigits:(int)fractionDigits {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundFloor; // 不保留两位有效数字
    formatter.maximumFractionDigits = fractionDigits;
    return [formatter stringFromNumber:[NSNumber numberWithDouble:number]];
}

///隐藏银行卡后四位前面所有的数字 为 *
+ (NSString *)getHiddenBankNum:(NSString *)bankNum {
    if (bankNum.length > 4) {
        return [NSString stringWithFormat:@"**%@", [bankNum substringToIndex:4]];
    } else {
        return @"--";
    }
}
@end

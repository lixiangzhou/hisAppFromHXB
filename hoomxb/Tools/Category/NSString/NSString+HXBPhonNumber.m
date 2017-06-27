//
//  NSString+HXBPhonNumber.m
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NSString+HXBPhonNumber.h"

@implementation NSString (HXBPhonNumber)
- (NSString *) hxb_hiddenPhonNumberWithMid {
    if (self.length != 11) {
        NSLog(@"🌶手机号 不是11位数");
        return self;
    }
    return [self stringByReplacingOccurrencesOfString:[self substringWithRange:NSMakeRange(3,4)]withString:@"****"];
}

- (NSString *) hxb_hiddenUserNameWithleft {
    NSString *str = @"";
    for (int i = 0; i<self.length - 1; i++) {
        str = [NSString stringWithFormat:@"%@*",str];
    }
    return [self stringByReplacingOccurrencesOfString:[self substringWithRange:NSMakeRange(0,self.length - 1)]withString:str];
}

- (NSString *)hxb_hiddenBankCard
{
    return [self stringByReplacingOccurrencesOfString:[self substringWithRange:NSMakeRange(0,self.length - 4)]withString:@"**** **** **** "];
}

- (NSString *)replaceStringWithStartLocation:(NSInteger)startLocation lenght:(NSInteger)lenght
{
    
    NSString *newStr = @"";
    
    for (NSInteger i = 0; i < lenght; i++) {
        newStr = [NSString stringWithFormat:@"%@*",newStr];
    }
    NSRange range = NSMakeRange(startLocation, lenght);
    newStr = [self stringByReplacingCharactersInRange:range withString:newStr];
    
    return newStr;
}
@end

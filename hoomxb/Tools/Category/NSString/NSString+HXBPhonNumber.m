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

-(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght

{
    
    NSString *newStr = originalStr;
    
    for (int i = 0; i < lenght; i++) {
        
        NSRange range = NSMakeRange(startLocation, 1);
        
        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];
        
        startLocation ++;
        
    }
    return newStr;
}
@end

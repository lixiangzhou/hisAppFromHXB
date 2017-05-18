//
//  NSAttributedString+Util.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/12.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "NSAttributedString+Util.h"

@implementation NSAttributedString (Util)

+ (NSMutableAttributedString *)transferWithString:(NSString *)string rightLength:(NSInteger)rightLength leftFont:(UIFont *)leftFont  rightFont:(UIFont *)rightFont
{
    NSInteger length = string.length;
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc]initWithString:string];
    [attributedString addAttribute:NSFontAttributeName value:leftFont range:NSMakeRange(0, length - rightLength)];
    [attributedString addAttribute:NSFontAttributeName value:rightFont range:NSMakeRange(length - rightLength, rightLength)];
    return attributedString;
}

+ (NSMutableAttributedString *)transferColorWithString:(NSString *)string leftLength:(NSInteger)leftLength leftColor:(UIColor *)leftColor  rightColor:(UIColor *)rightColor
{
    NSInteger length = string.length;
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc]initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName value:leftColor range:NSMakeRange(0, leftLength)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rightColor range:NSMakeRange(leftLength, length - leftLength)];
    return attributedString;
}

@end

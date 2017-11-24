//
//  NSString+Mask.m
//  TR7TreesV3
//
//  Created by hoomsun on 16/6/3.
//  Copyright © 2016年 hoomsun. All rights reserved.
//

#import "NSString+HxbMask.h"

@implementation NSString (HxbMask)

/*
 用法：
 NSMutableString *idStr = [data.infoIdCard mutableCopy];
 cell.detailTextLabel.text = [NSString maskString:idStr withMaskString:@"*" inRange:NSMakeRange(3, 3)];
 
 */

+ (NSString *)maskString:(NSString *)originString withMaskString:(NSString *)maskString inRange:(NSRange)replaceRange
{

    NSInteger maskLen = replaceRange.length;
    
    NSMutableString *finalMaskStr = [NSMutableString string];
    for (int i=0; i<maskLen; i++) {
        [finalMaskStr appendString:maskString];
    }
    
    
    return [originString stringByReplacingCharactersInRange:replaceRange withString:finalMaskStr];
}

/**
 设置H5显示超过9个文字
 
 @param title 标题
 */
+ (NSString *)H5Title:(NSString *)title
{
    if (title.length > 9) {
        NSString *subtitle = [title substringToIndex:9];
        title = [subtitle stringByAppendingString:@"..."];
    }
    return title;
}


@end

//
//  NSString+Mask.h
//  TR7TreesV3
//
//  Created by hoomsun on 16/6/3.
//  Copyright © 2016年 hoomsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HxbMask)

//给字符串打默认掩码
+ (NSString *)maskString:(NSString *)originString withMaskString:(NSString *)maskString inRange:(NSRange)replaceRange;






@end

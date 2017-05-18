//
//  NSAttributedString+Util.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/12.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Util)

/**
 *  将String转换为AtrributeString，前后字符串大小不一致的情况下
 *
 *  @param string        要转换的字符串
 *  @param rightLength   右边几位需要转换
 *  @param leftFont      左边字符串的字体
 *  @param rightFont     右边字符串的字体
 *
 *  @return
 */
+ (NSMutableAttributedString *)transferWithString:(NSString *)string rightLength:(NSInteger)rightLength leftFont:(UIFont *)leftFont  rightFont:(UIFont *)rightFont;

+ (NSMutableAttributedString *)transferColorWithString:(NSString *)string leftLength:(NSInteger)leftLength leftColor:(UIColor *)leftColor  rightColor:(UIColor *)rightColor;

@end

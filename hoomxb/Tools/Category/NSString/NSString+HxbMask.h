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

/**
 设置H5显示超过9个文字
 
 @param title 标题
 */
+ (NSString *)H5Title:(NSString *)title;


/**
 H5页面拼接后台返回的h5host
 
 @param url 需要拼接的URL
 @return 返回一个拼接好的URL
 */
+ (NSString *)splicingH5hostWithURL:(NSString *)url;
@end

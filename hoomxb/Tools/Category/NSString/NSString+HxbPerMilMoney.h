//
//  NSString+PerMilMoney.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/13.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HxbPerMilMoney)
///科学技术
+(NSString *)GetPerMilWithDouble:(double)number;
///后面拼接了 元
+ (NSString *)hxb_getPerMilWithDouble:(double)number;
///有小数点
+ (NSString *)hxb_getPerMilWithDoubleNum:(double)number;
///没有小数点
+ (NSString *)hxb_getPerMilWithIntegetNumber:(double)number;
///隐藏了中间的字段 为 *
+ (NSString *) hiddenStr: (NSString *)string MidWithFistLenth: (NSInteger)fistLenth andLastLenth: (NSInteger)lastLenth;
///如果拼接的是最后一个字符串是“”，那么就默认为删除键，删除最后一个字符
- (NSString *) hxb_StringWithFormatAndDeleteLastChar: (NSString *)string;
@end

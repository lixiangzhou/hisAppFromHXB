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

///隐藏了中间的字段 为 *
+ (NSString *) hiddenStr: (NSString *)string MidWithFistLenth: (NSInteger)fistLenth andLastLenth: (NSInteger)lastLenth;
@end

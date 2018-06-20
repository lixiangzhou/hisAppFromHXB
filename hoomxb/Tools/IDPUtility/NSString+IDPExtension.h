//
//  NSString+IDPExtension.h
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IDPExtension)
/**
  解析url中的path和？后面的参数

 @param resultCall 通过block回调解析结果
 */
- (void)parseUrlParam:(void (^)(NSString* path, NSDictionary* paramDic))resultCall;

- (CGSize)caleFontSize:(UIFont *)font forMaxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 转成字典

 @return 字典
 */
- (NSDictionary*)toDictionary;
/**
 银行家算法

 @param position 小数点位数
 @return 转换后的结果
 */
- (NSString *)notRounding:(int)position;
@end

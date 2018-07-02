//
//  NSString+Extension.h
//  SCH
//
//  Created by SCH_YUH on 2017/1/10.
//  Copyright © 2017年 SCH_YUH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
///得到现在时间戳的字符串
+ (instancetype)getDateUnqueDescription;
#pragma mark - 判断一个字符串是不是空
/**
 *函数描述 : 判断一个字符串是不是空
 *@returns 为空则返回真
 */
- (BOOL)isEmpty;
-(BOOL)isNull;
+ (BOOL) isNullOrEmpty:(NSString *)string;

#pragma mark - 验证号码
#pragma mark -
/**
 *函数描述 :验证邮箱是否合法
 *返回 :YES=合法邮箱
 **/
-(BOOL)verifyEmail;
/**
 *函数描述 :验手机号是否合法
 *返回 :YES=合法手机号
 */
-(BOOL)isPhoneNumber;
/**
 验证座机
 */
-(BOOL)isTelephoneNumber;


//返回值是该字符串所占一行的width
-(CGFloat)getSingleLineTextSizeWithFont: (UIFont*)font;


/**
 拨打电话
 */
-(void)call;

/**
 随机图片名称
 
 @return 图片名称
 */
+ (NSString *)pictureNaming;
/**
 获取刻度尺
 
 @param num 数量
 @param unit 单位
 @return 返回需要的字符串
 */
+(NSString *)roundUpNum:(CGFloat)num unit:(NSString *)unit;

/**
 获取刻度尺 得到的数字之间将小数点后面一位之后的舍去
 
 @param num 数量
 @param unit 单位
 @return 返回需要的字符串
 */
+(NSString *)roundUpFloorfNum:(CGFloat )num unit:(NSString *)unit;

+(NSDictionary *)dic_roundUpNum:(CGFloat )num unit:(NSString *)unit;
+(NSString *)dic_roundUpNum:(NSDictionary *)dic;
+(NSString *)dic_roundUpUnit:(NSDictionary *)dic;
/**
 获取字符串宽
 
 @param str 文字
 @param wordFont 字体大小
 @return 文字宽度
 */
+(CGSize)getAttributeSizeWithText:(NSString *)text fontSize:(int)fontSize;
+(float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont;
@end

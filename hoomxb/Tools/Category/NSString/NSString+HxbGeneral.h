//
//  NSString+General.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (HxbGeneral)
///
//+(CGSize)getSizeWithText:(NSString*)text fontOfSize:(int)fontSize boundingRectSize:(CGSize)rectSize;


///获取版本号
+(NSString*)getAppVersionNum;
///手机号加密算法
+(NSString*)encryptRegisterNum:(NSString*)rNum;
///是否为手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
///判断是否有中文字符
+ (BOOL)isChinese:(NSString *)str;
///判断字符串是否包含数字
+ (BOOL)isStringContainNumberWith:(NSString *)str;
///判断字符串是否包含字母
+ (BOOL)isStringCOntainStringWith:(NSString *)str;
///判断字符串是否包含特殊字符
+ (BOOL)isIncludeSpecialCharact: (NSString *)str;
///验证身份证号是否合法
+ (BOOL)validateIDCardNumber:(NSString *)identityCard;
///8-20位数字和字母组成 密码
+ (BOOL)checkPassWordWithString: (NSString *)str;
///根据身份证号获取生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;

/**
 密码不对的提示信息
 
 @param passWordName 密码
 @return  提示信息
 */
+ (NSString*)isOrNoPasswordStyle:(NSString *)passWordName;
///限制UITextfield两位小数的输入
+ (BOOL)checkBothDecimalPlaces: (NSString *)str;
@end

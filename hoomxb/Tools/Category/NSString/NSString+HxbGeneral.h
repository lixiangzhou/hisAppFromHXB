//
//  NSString+General.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
///判断字符串是否包含字母
+ (BOOL)isStringContainNumberWith:(NSString *)str;
///判断字符串是否包含特殊字符
+ (BOOL)isIncludeSpecialCharact: (NSString *)str;
///验证身份证号是否合法
+ (BOOL)validateIDCardNumber:(NSString *)identityCard;
@end

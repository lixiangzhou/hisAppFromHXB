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
//+(CGSize)getSizeWithText:(NSString*)text fontOfSize:(int)fontSize boundingRectSize:(CGSize)rectSize;

+(NSString*)getAppVersionNum;

+(NSString*)encryptRegisterNum:(NSString*)rNum;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)isChinese:(NSString *)str;

+ (BOOL)isStringContainNumberWith:(NSString *)str;

+ (BOOL)isIncludeSpecialCharact: (NSString *)str;

@end

//
//  HXBCode.h
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 code 码
 */
typedef enum : NSUInteger {
    ///弹出图验
    kHXBCode_Enum_Captcha = 102,
    ///token无权限
    kHXBCode_Enum_TokenNotJurisdiction = 401,
    ///未登录
    kHXBCode_Enum_NotSigin = 402,
    ///请求超时
    kHXBCode_Enum_RequestOverrun = 412,
} kHXBCode_Enum;
@interface HXBCode : NSObject

@end

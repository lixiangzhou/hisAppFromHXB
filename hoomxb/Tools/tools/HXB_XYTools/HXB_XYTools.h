//
//  HXB_XYTools.h
//  hoomxb
//
//  Created by HXB on 2017/8/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXB_XYTools : NSObject

+ (HXB_XYTools *)shareHandle;

// 将view转为image
- (UIImage*)convertViewToImage:(UIView*)view;

// 给View添加阴影
- (void)createViewShadDow:(UIView*)view;

// 自动获取宽度
- (CGFloat)WidthWithString:(NSString *)string labelFont:(UIFont *)labelFont addWidth:(CGFloat)width;

// 自动获取高度
- (CGFloat)heightWithString:(NSString *)string labelFont:(UIFont *)labelFont Width:(CGFloat)width;

// 限制输入金额小数点后两位
- (BOOL)limitEditTopupMoneyWithTextField:(UITextField *)textField Range:(NSRange)range replacementString:(NSString *)string;

// 限制输入字符串和数字
- (BOOL)limitTextCharactorWithString:(NSString *)string;

@end

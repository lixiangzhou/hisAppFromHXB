//
//  HXB_XYTools.h
//  hoomxb
//
//  Created by HXB on 2017/8/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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

// 限制输入金额小数点后两位
- (BOOL)limitEditTopupMoneyWithTextField:(UITextField *)textField Range:(NSRange)range replacementString:(NSString *)string;

@end

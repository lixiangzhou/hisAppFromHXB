//
//  NSAttributedString+HxbAttributedString.h
//  hoomxb
//
//  Created by HXB on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface NSAttributedString (HxbAttributedString)
    /// 使用图像和文本生成上下排列的属性文本
    ///
    /// @param image      图像
    /// @param imageWH    图像宽高
    /// @param title      标题文字
    /// @param fontSize   标题字体大小
    /// @param titleColor 标题颜色
    /// @param spacing    图像和标题间距
    ///
    /// @return 属性文本
+ (instancetype)hxb_imageTextWithImage:(UIImage *)image imageWH:(CGFloat)imageWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing;

/**
 * 关于改变某段字的颜色与大小
 * @param range 范围
 * @param color 范围内的颜色
 * @param font 范围内的字体
 */
+ (NSMutableAttributedString *)setupAttributeStringWithString:(NSString *)string WithRange: (NSRange)range andAttributeColor: (UIColor *)color andAttributeFont: (UIFont *)font;

+ (NSMutableAttributedString *)setupAttributeStringWithString:(NSString *)string WithRange: (NSRange)range andAttributeColor: (UIColor *)color;

@end

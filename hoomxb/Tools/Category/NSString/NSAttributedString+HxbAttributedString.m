//
//  NSAttributedString+HxbAttributedString.m
//  hoomxb
//
//  Created by HXB on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NSAttributedString+HxbAttributedString.h"

@implementation NSAttributedString (HxbAttributedString)
    
+ (instancetype)hxb_imageTextWithImage:(UIImage *)image imageWH:(CGFloat)imageWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    
    // 文本字典
    NSDictionary *titleDict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                NSForegroundColorAttributeName: titleColor};
    NSDictionary *spacingDict = @{NSFontAttributeName: [UIFont systemFontOfSize:spacing]};
    
    // 图片文本
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, imageWH, imageWH);
    NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 换行文本
    NSAttributedString *lineText = [[NSAttributedString alloc] initWithString:@"\n\n" attributes:spacingDict];
    
    // 按钮文字
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:title attributes:titleDict];
    
    // 合并文字
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithAttributedString:imageText];
    [attM appendAttributedString:lineText];
    [attM appendAttributedString:text];
    
    return attM.copy;
}


+ (NSMutableAttributedString *)setupAttributeStringWithString:(NSString *)string WithRange: (NSRange)range andAttributeColor: (UIColor *)color andAttributeFont: (UIFont *)font{

    //添加字符串
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    //设置字体
    [attr addAttribute:NSFontAttributeName value:font range: range];
    //设置颜色
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attr;
}

+ (NSMutableAttributedString *)setupAttributeStringWithString:(NSString *)string WithRange: (NSRange)range andAttributeColor: (UIColor *)color {
    //添加字符串
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    //设置颜色
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attr;
}
@end

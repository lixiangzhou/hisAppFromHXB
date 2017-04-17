//
//  UIButton+HxbButton.h
//  hoomxb
//
//  Created by HXB on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HxbButton)
    /// 创建文本按钮
    ///
    /// @param title         文本
    /// @param fontSize      字体大小
    /// @param normalColor   默认颜色
    /// @param selectedColor 选中颜色
    ///
    /// @return UIButton
+ (instancetype)hxb_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;
@property (nonatomic,copy) void((^)(UIButton *button))tapActionBlock;

@end

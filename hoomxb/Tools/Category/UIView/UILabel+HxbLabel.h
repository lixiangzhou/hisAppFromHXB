//
//  UILabel+HxbLabel.h
//  hoomxb
//
//  Created by HXB on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HxbLabel)
    /// 创建文本标签
    ///
    /// @param text     文本
    /// @param fontSize 字体大小
    /// @param color    颜色
    ///
    /// @return UILabel
+ (instancetype)hxb_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;
@end

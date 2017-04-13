//
//  ViewController.h
//  MY_Additions
//
//  Created by 李鹏跃 on 16/12/26.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//Copyright © 2016年 itcast. All rights reserved.


#import <UIKit/UIKit.h>

@interface UIButton (Addition)

/// 创建文本按钮
///
/// @param title         文本
/// @param fontSize      字体大小
/// @param normalColor   默认颜色
/// @param selectedColor 选中颜色
///
/// @return UIButton
+ (instancetype)addition_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end

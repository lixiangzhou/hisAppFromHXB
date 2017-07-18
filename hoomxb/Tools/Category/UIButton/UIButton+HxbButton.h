//
//  UIButton+HxbButton.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
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
+(UIButton *)buttonWithImageName:(NSString *)imageName andHighlightImageName:(NSString *)hlImageName andTarget:(id)target andAction:(SEL)action andFrameByCategory:(CGRect)rect;

+(UIButton *)buttonWithTitle:(NSString*)title andTarget:(id)target andAction:(SEL)action andFrameByCategory:(CGRect)rect;
//选择器专用按钮
+(UIButton *)buttonWithTitle:(NSString*)title andFrameByCategory:(CGRect)rect;
//立即购买按钮
+(UIButton *)btnwithTitle:(NSString *)title andTarget:(id)target andAction:(SEL)action andFrameByCategory:(CGRect)rect;
//右边按钮的筛选／登录按钮
+(UIButton *)rightItemWithTitle:(NSString *)title andTarget:(id)target andAction:(SEL)action andFrameByCategory:(CGRect)rect;
//textfiled专用button
+(UIButton *)buttonWithTitle1:(NSString*)title andTarget:(id)target andAction:(SEL)action andFrameByCategory:(CGRect)rect;
//cell 专用对勾选择button
+(UIButton *)buttonWithImageName:(NSString *)imageName andSelectImageName:(NSString *)hlImageName andTarget:(id)target andAction:(SEL)action andFrameByCategory:(CGRect)rect;

//颜色
@property (nonatomic,assign) BOOL isColourGradientView;
@end

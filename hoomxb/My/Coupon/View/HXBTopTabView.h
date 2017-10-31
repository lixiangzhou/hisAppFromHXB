//
//  HXBTopTabView.h
//  hoomxb
//
//  Created by lxz on 2017/10/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBTopTabView;
@protocol HXBTopTabViewDelegate <NSObject>
- (void)topTabView:(HXBTopTabView *)topTabView didClickIndex:(NSInteger)index;
@end

@interface HXBTopTabView : UIView

/**
 快速创建tab

 @param frame frame
 @param titles 标题数组
 @param font 字体
 @param normalColor 正常颜色
 @param selectedColor 选中颜色
 @param sepLineColor 分割线颜色
 @param sepLineWidth 分割线宽度
 @param sepLineHeight 分割线高度
 @param bottomLineColor 底部线颜色
 @param bottomLineHeight 底部线高度
 @param bottomLineWidthAdjustTitle 是否根据文字调整底部线宽度
 @param bottomLineWidthPading 底部线宽的padding
 @param selectedIndex 选中的索引
 */
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                         font:(UIFont *)font
                  normalColor:(UIColor *)normalColor
                selectedColor:(UIColor *)selectedColor
                 sepLineColor:(UIColor *)sepLineColor
                 sepLineWidth:(CGFloat)sepLineWidth
                sepLineHeight:(CGFloat)sepLineHeight
              bottomLineColor:(UIColor *)bottomLineColor
             bottomLineHeight:(CGFloat)bottomLineHeight
   bottomLineWidthAdjustTitle:(BOOL)bottomLineWidthAdjustTitle
        bottomLineWidthPading:(CGFloat)bottomLineWidthPading
                selectedIndex:(NSInteger)selectedIndex;

@property (nonatomic, weak) id<HXBTopTabViewDelegate> delegate;
@property (nonatomic, assign) NSUInteger selectedIndex;
@end

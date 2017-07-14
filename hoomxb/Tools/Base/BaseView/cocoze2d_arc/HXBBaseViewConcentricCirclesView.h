//
//  HXBBaseViewConcentricCirclesView.h
//  hoomxb
//
//  Created by HXB on 2017/7/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 同心圆的view
 */
@interface HXBBaseViewConcentricCirclesView : UIView

/**
 第几个后就是空心圆了
 */
@property (nonatomic,assign) NSInteger stage;
/**
 圆线的宽度
 */
@property (nonatomic,assign) CGFloat circularWidth;
/**
 圆形 与线的颜色
 默认（HXBC_Red_Light(r:0.96 g:0.32 b:0.32 a:1.00)）
 */
@property (nonatomic,strong) UIColor *circularColor;
///线的颜色
@property (nonatomic,strong) UIColor *lineColor;
///同心圆的内间距
@property (nonatomic,assign) CGFloat concentricCircles_spacing;
///同心圆 外圆直径
@property (nonatomic,assign) CGFloat circularDiameter;
///同心圆 内圆直径
@property (nonatomic,assign) CGFloat insideCircularDiameter;
///同心圆的个数
@property (nonatomic,assign) NSInteger circularCount;
///线高
@property (nonatomic,assign) CGFloat lineHeight;
@end

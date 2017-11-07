
//  Created by 李鹏跃 on 17/7/15.
//  Copyright © 2017年 13lipengyue. All rights reserved.
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
 内切圆 的颜色
 默认（HXBC_Red_Light(r:0.96 g:0.32 b:0.32 a:1.00)）
 */
@property (nonatomic,strong) UIColor *inscribedCircleColor;
/**
 外切圆 线圈的颜色
 */
@property (nonatomic,strong) UIColor *excircleLineColor;
/**
 外切圆的颜色
 */
@property (nonatomic,strong) UIColor *excircleColor;
///线的颜色
@property (nonatomic,strong) UIColor *lineColor;

/**
 圆线的宽度
 */
@property (nonatomic,assign) CGFloat excircleLineWidth;
///同心圆的内间距
@property (nonatomic,assign,readonly) CGFloat concentricCircles_spacing;
///同心圆 外圆直径
@property (nonatomic,assign) CGFloat excircleDiameter;
///同心圆 内圆直径
@property (nonatomic,assign) CGFloat insideCircularDiameter;
///线高
@property (nonatomic,assign) CGFloat lineHeight;
///圆的个数
@property (nonatomic,assign) NSInteger circularCount;
///画不画最后一个圆形
@property (nonatomic,assign) BOOL isDontDrowLastArtCount;
///后面有几个圆与线不画
@property (nonatomic,assign) NSInteger dontDrowArtCount;
@end

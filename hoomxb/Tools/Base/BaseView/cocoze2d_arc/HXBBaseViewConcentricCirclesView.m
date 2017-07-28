//
//  HXBBaseViewConcentricCirclesView.m
//  hoomxb
//
//  Created by 李鹏跃 on 17/7/15.
//  Copyright © 2017年 13lipengyue. All rights reserved.
//
#import "HXBBaseViewConcentricCirclesView.h"
@interface HXBBaseViewConcentricCirclesView ()
/**
 同心圆位置
 */
@property (nonatomic,strong) NSMutableArray *concentricCirclesLocationArray;
/**
 线的位置
 */
@property (nonatomic,strong) NSMutableArray *lineLocationArray;
/**
 中间圆的直径
 */
@property (nonatomic,assign) CGFloat midDiameter;
/**
 两个外切圆之间的距离
 */
@property (nonatomic,assign) CGFloat excircleSpacing;
@end
@implementation HXBBaseViewConcentricCirclesView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUP];
    }
    return self;
}

- (void)setUP {
    /**
     圆线的宽度
     */
    _excircleLineWidth = 2;
    ///同心圆 外圆直径
    _excircleDiameter = 30;
    ///同心圆 内圆直径
    _insideCircularDiameter = 20;
    ///线高
    _lineHeight = 2;
    
    _excircleColor = [UIColor whiteColor];
    _inscribedCircleColor = [UIColor whiteColor];
    _lineColor = [UIColor redColor];
    _inscribedCircleColor = [UIColor whiteColor];
    _excircleLineColor = [UIColor redColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self calculateLocation];
}



- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    [self layoutIfNeeded];
//    NSAssert(self.stage < self.circularCount,@"🌶注意，同心圆的个数不能为负数stage = %ld，circularCount = %ld",(long)self.stage,(long)self.circularCount);
    for (int i = 0; i < self.concentricCirclesLocationArray.count - self.isDontDrowLastArt; i ++) {
        //画圆
        BOOL isConcentricCircles = NO;
        if (i < self.stage) {
            isConcentricCircles = true;
        }
        CGRect location_Arc = [self.concentricCirclesLocationArray[i] CGRectValue];
        [self drawRectArcWithIsConcentricCircles:isConcentricCircles andContext:context andRect:location_Arc];
        //画线
        if (i == self.circularCount - 1) continue;
        CGRect location_Line = [self.lineLocationArray[i] CGRectValue];
        [self drawLineWithContext:context andLineRect:location_Line];
    }
}
///画线
- (void)drawLineWithContext: (CGContextRef)context andLineRect: (CGRect)lineRect {
    ///划线
    CGContextSetLineWidth(context, self.excircleLineWidth); //设置线的宽度
    CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
    CGContextAddRect(context, lineRect);
    CGContextDrawPath(context, kCGPathFill);
}


///画一个圆形，是否为同心圆
- (void)drawRectArcWithIsConcentricCircles:(BOOL)isConcentricCircles andContext:(CGContextRef)context andRect:(CGRect)rect{
    
    ///画最外层的圆
    [self draw_Arc_Outside_WihtContext:context andRect:rect andConcentricCircles_spacing:0 andArcColor:self.excircleLineColor];
    
    ///画 外切圆与内切圆中间的圆
    [self draw_Arc_Outside_WihtContext:context andRect:rect andConcentricCircles_spacing:self.excircleLineWidth andArcColor:self.excircleColor];
    
    ///话内切圆
    if (!isConcentricCircles) return;
    [self draw_Arc_Outside_WihtContext:context andRect: rect andConcentricCircles_spacing:self.concentricCircles_spacing andArcColor:self.inscribedCircleColor];
}

///话内切圆
- (void) draw_Arc_Outside_WihtContext:(CGContextRef)context andRect:(CGRect)rect andConcentricCircles_spacing:(CGFloat)concentricCircles_spacing andArcColor:(UIColor *)color{
    CGFloat X,Y,H,W;
    X = rect.origin.x + concentricCircles_spacing;
    Y = rect.origin.y + concentricCircles_spacing;
    W = rect.size.width - concentricCircles_spacing * 2;
    H = rect.size.height - concentricCircles_spacing * 2;
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGRect insideEllipseLocation = CGRectMake(X, Y, W, H);
    CGContextAddEllipseInRect(context, insideEllipseLocation);
    CGContextDrawPath(context, kCGPathFill);
}

///MARK:计算位置
- (void)calculateLocation {
    ///直线的位置
    NSMutableArray *arrayM_line = [[NSMutableArray alloc]init];
    ///圆形的位置
    NSMutableArray *arrayM_Circular = [[NSMutableArray alloc]init];
    //计算两个外切圆之间的距离
    [self setUP_excircleSpacing];
    
    CGFloat lineY = self.frame.size.height / 2 - self.lineHeight / 2;
    CGFloat circularY = self.frame.size.height / 2 - self.excircleDiameter / 2;
    for (int i = 0; i < self.circularCount; i ++) {
        ///圆形的位置
        CGFloat circularX = i * (self.excircleSpacing + self.excircleDiameter);
        CGRect circularRect = CGRectMake(circularX, circularY, self.excircleDiameter, self.excircleDiameter);
        NSValue *circularRect_Number = [NSValue valueWithCGRect:circularRect];
        [arrayM_Circular addObject: circularRect_Number];
        
        ///线的位置 (注意 线比圆总是少一个)
        if (i == self.circularCount - 1) continue;
        CGFloat lineX = i * (self.excircleSpacing + self.excircleDiameter) + self.excircleDiameter - self.excircleLineWidth;
        CGRect rect = CGRectMake(lineX, lineY, self.excircleSpacing + self.excircleLineWidth * 2, self.lineHeight);
        NSValue *rectNumber = [NSValue valueWithCGRect:rect];
        [arrayM_line addObject:rectNumber];
    }
    self.concentricCirclesLocationArray = arrayM_Circular;
    self.lineLocationArray = arrayM_line;
}
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self setNeedsDisplay];
}
//外圆颜色
- (void)setExcircleColor:(UIColor *)excircleColor {
    _excircleColor = excircleColor;
    [self setNeedsDisplay];
}

///同心圆 外圆直径
- (void)setExcircleDiameter:(CGFloat)excircleDiameter {
    _excircleDiameter = excircleDiameter;
    [self setUP_excircleSpacing];
    [self calculateLocation];
    [self setNeedsDisplay];
}
///同心圆 内圆直径
- (void)setInsideCircularDiameter:(CGFloat)insideCircularDiameter {
    _insideCircularDiameter = insideCircularDiameter;
    [self calculateLocation];
    [self setNeedsDisplay];
}
///同心圆的个数
- (void) setCircularCount:(NSInteger)circularCount {
    _circularCount = circularCount;
    [self setUP_excircleSpacing];
    [self calculateLocation];
    [self setNeedsDisplay];
}
///线高
- (void) setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
    [self calculateLocation];
    [self setNeedsDisplay];
}
- (void)setExcircleLineWidth:(CGFloat)excircleLineWidth {
    _excircleLineWidth = excircleLineWidth;
    [self setNeedsDisplay];
}

///到底几个view 后面的都是空心圆
- (void)setStage:(NSInteger)stage {
    _stage = stage;
    [self setNeedsDisplay];
}

- (CGFloat) concentricCircles_spacing {
    return (self.excircleDiameter - self.insideCircularDiameter)/2;
}
- (CGFloat) midDiameter {
    return self.excircleDiameter - self.concentricCircles_spacing;
}

/**
 两个外切圆之间的距离
 */
- (CGFloat)excircleSpacing {
    if (_excircleSpacing) {
        [self setUP_excircleSpacing];
    }
    return _excircleSpacing;
}
//计算两个外切圆之间的距离
- (void)setUP_excircleSpacing {
    _excircleSpacing = (self.frame.size.width - self.circularCount * self.excircleDiameter) / (self.circularCount - 1);
}
@end

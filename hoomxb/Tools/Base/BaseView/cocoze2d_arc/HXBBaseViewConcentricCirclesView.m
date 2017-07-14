//
//  HXBBaseViewConcentricCirclesView.m
//  hoomxb
//
//  Created by HXB on 2017/7/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
@end
@implementation HXBBaseViewConcentricCirclesView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUP {
    self.circularWidth = kScrAdaptationW(2);
    self.lineColor = HXBC_Red_Light;
    self.circularColor = HXBC_Red_Light;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self calculateLocation];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self layoutIfNeeded];
    for (int i = 0; i < self.concentricCirclesLocationArray.count; i ++) {
        //画圆
        BOOL isConcentricCircles = NO;
        if (i < _stage) {
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
    CGContextFillRect(context, lineRect);
    CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
    CGContextDrawPath(context, kCGPathFill);
}


///画一个圆形，是否为同心圆
- (void)drawRectArcWithIsConcentricCircles:(BOOL)isConcentricCircles andContext:(CGContextRef)context andRect:(CGRect)rect{
    CGContextSetStrokeColorWithColor(context, self.circularColor.CGColor);//设置填充颜色
    CGContextAddEllipseInRect(context, rect); //画一个椭圆或者圆
    CGContextDrawPath(context, kCGPathStroke);
    CGContextSetFillColorWithColor(context, self.circularColor.CGColor);
    CGContextSetLineWidth(context, self.circularWidth); //设置线的宽度
    CGContextAddEllipseInRect(context, CGRectMake(10, 30, 60, 60)); //画一个椭圆或者圆
    CGContextDrawPath(context, kCGPathFillStroke);

    
    if (!isConcentricCircles) return;
    
    CGFloat X,Y,H,W;
    X = rect.origin.x + self.concentricCircles_spacing;
    Y = rect.origin.y + self.concentricCircles_spacing;
    W = rect.size.width - self.concentricCircles_spacing;
    H = rect.size.height - self.concentricCircles_spacing;
    CGContextSetFillColorWithColor(context, self.circularColor.CGColor);
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
    
    
    CGFloat lineWidth = (self.frame.size.width - 2 - (self.circularCount * self.circularDiameter)) / (self.circularCount - 1);
    CGFloat lineY = self.frame.size.height / 2 - self.lineHeight / 2;
    CGFloat circularY = self.frame.size.height / 2 - self.circularDiameter / 2;
    for (int i = 0; i < self.circularCount; i ++) {
        ///圆形的位置
        CGFloat circularX;
        if (i == 0) {
            circularX = 1;
        }else {
            circularX = i * (lineWidth + self.circularDiameter);
        }
        CGRect circularRect = CGRectMake(circularX, circularY, self.circularDiameter, self.circularDiameter);
        NSValue *circularRect_Number = [NSValue valueWithCGRect:circularRect];
        [arrayM_Circular addObject: circularRect_Number];
        
        ///线的位置 (注意 线比圆总是少一个)
        if (i == self.circularCount - 1) continue;
        CGFloat lineX = i * (lineWidth + self.circularDiameter) + self.circularDiameter;
        CGRect rect = CGRectMake(lineX, lineY, lineWidth, self.lineHeight);
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
- (void) setCircularColor:(UIColor *)circularColor {
    _circularColor = circularColor;
    [self setNeedsDisplay];
}
///同心圆的内间距
- (void) setConcentricCircles_spacing:(CGFloat)concentricCircles_spacing {
    _concentricCircles_spacing = concentricCircles_spacing;
    [self calculateLocation];
    [self setNeedsDisplay];
}
///同心圆 外圆直径
- (void) setCircularDiameter:(CGFloat)circularDiameter {
    _circularDiameter = circularDiameter;
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
    [self calculateLocation];
    [self setNeedsDisplay];
}
///线高
- (void) setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
    [self calculateLocation];
    [self setNeedsDisplay];
}
- (void)setCircularWidth:(CGFloat)circularWidth {
    _circularWidth = circularWidth;
    [self setNeedsDisplay];
}
@end

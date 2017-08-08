//
//  HXBProportionalBarView.m
//  画图
//
//  Created by HXB-C on 2017/8/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBProportionalBarView.h"

@interface HXBProportionalBarView ()
//比例数组
@property (nonatomic, strong) NSArray *ratioArr;
//颜色数组
@property (nonatomic, strong) NSArray *colorArr;
@end

@implementation HXBProportionalBarView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self drawing];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)drawLineWithRatioArr:(NSArray *)ratioArr andWithColorArr:(NSArray *)colorArr
{
    self.ratioArr = ratioArr;
    self.colorArr = colorArr;
    [self setNeedsDisplay];
}


- (void)drawLine
{
    // 1.取得和当前视图相关联的图形上下文(因为图形上下文决定绘制的输出目标)/
    
    // 如果是在drawRect方法中调用UIGraphicsGetCurrentContext方法获取出来的就是Layer的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.绘图(绘制直线), 保存绘图信息
    CGFloat withRatio = 0.0;
    for (int i = 0; i < self.ratioArr.count; i++) {
        // 设置起点
        CGContextMoveToPoint(ctx,  withRatio * self.frame.size.width, 0);
        withRatio += [self.ratioArr[i] doubleValue];
        // 设置终点
        CGContextAddLineToPoint(ctx, withRatio * self.frame.size.width, 0);
        // 设置绘图状态
        // 设置线条颜色 红色
        UIColor *color = self.colorArr[i];
        CGContextSetStrokeColorWithColor(ctx, color.CGColor);
        // 设置线条宽度
        CGContextSetLineWidth(ctx, self.frame.size.height * 2);
        // 绘制一条空心的线
        CGContextStrokePath(ctx);
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawLine];
}


- (void)drawing
{
    //创建一个路径对象
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    //  起点
    [linePath moveToPoint:(CGPoint){0,0}];
    // 其他点
    [linePath addLineToPoint:(CGPoint){self.frame.size.width,0}];
    
    //  设置路径画布
    //    CAGradientLayer *lineLayer = [CAGradientLayer layer];
    //    lineLayer.bounds = (CGRect){0,0,200,200};
    //    lineLayer.position = CGPointMake(0, 0);
    //    lineLayer.anchorPoint = CGPointMake(0, 0);
    
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.bounds = (CGRect){0,0,200,200};
    lineLayer.position = CGPointMake(0, 0);
    lineLayer.anchorPoint = CGPointMake(0, 0);
    lineLayer.lineWidth = 15.0;
    lineLayer.strokeColor = [UIColor orangeColor].CGColor; //   边线颜色
    lineLayer.strokeStart = 0;
    lineLayer.strokeEnd = 1;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor  = nil;   //  默认是black
    
    //  添加到图层上
    [self.layer addSublayer:lineLayer];
//    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    checkAnimation.duration = 1.0f;
//    checkAnimation.fromValue = @(0.0f);
//    checkAnimation.toValue = @(1.0f);
//    [lineLayer addAnimation:checkAnimation forKey:@"checkAnimation"];
}

@end

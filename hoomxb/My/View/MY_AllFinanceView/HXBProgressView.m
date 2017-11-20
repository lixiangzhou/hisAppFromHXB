//
//  ProgressView.m
//  XzbTest
//
//  Created by xzb on 2017/5/25.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "HXBProgressView.h"

static const CGFloat kLineWidth = 5.0f;
static const CGFloat kFrontLineWidth = 5.0f;
#define kColor_Top [UIColor colorWithRed:34/255.0 green:44/255.0 blue:87/255.0 alpha:1]
#define kColor_Bottom [UIColor colorWithRed:223/255.0 green:157/255.0 blue:16/255.0 alpha:1]
#define kColor_Background [UIColor colorWithRed:225/255.0 green:224/255.0 blue:233/255.0 alpha:1]


@interface HXBProgressView ()



@property (strong, nonatomic) CAShapeLayer *frontShapeLayer;
@property (strong, nonatomic) CAShapeLayer *backShapeLayer;
@property (strong, nonatomic) UIBezierPath *circleBezierPath;
//渐变用
@property (nonatomic, strong) CAGradientLayer *rightGradLayer;
@property (nonatomic, strong) CAGradientLayer *leftGradLayer;
@property (nonatomic, strong) CALayer *gradLayer;

@end

@implementation HXBProgressView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    CGFloat kWidth = rect.size.width;
    CGFloat kHeight = rect.size.height;
    
    if (!self.circleBezierPath){
        self.circleBezierPath = ({
            CGPoint pCenter = CGPointMake(kWidth * 0.5, kHeight * 0.5);
            CGFloat radius = MIN(kWidth, kHeight);
            radius = radius - kFrontLineWidth;
            UIBezierPath *circlePath = [UIBezierPath bezierPath];
            [circlePath addArcWithCenter:pCenter radius:radius * 0.5 startAngle:270 * M_PI / 180 endAngle:269 * M_PI / 180 clockwise:YES];
            [circlePath closePath];
            circlePath;
        });
    }
    if (!self.backShapeLayer) {
        self.backShapeLayer = ({
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = rect;
            shapeLayer.path = self.circleBezierPath.CGPath;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.lineWidth = kLineWidth;
            shapeLayer.strokeColor = BACKGROUNDCOLOR.CGColor;
            shapeLayer.lineCap = kCALineCapRound;
            [self.layer addSublayer:shapeLayer];
            shapeLayer;
        });
    }
    
    if (!self.frontShapeLayer){
        self.frontShapeLayer = ({
            CAShapeLayer  *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = rect;
            shapeLayer.path = self.circleBezierPath.CGPath;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.lineWidth = kFrontLineWidth;
            //颜色设置
            shapeLayer.strokeColor = self.progressColor.CGColor;
            shapeLayer;
        });
        if (self.gradual) {
            [self addGradLayerWithRect:rect];
            self.frontShapeLayer.lineCap = kCALineCapRound;
            _gradLayer.mask = self.frontShapeLayer;
            [self.layer addSublayer:_gradLayer];
        }else{
            [self.layer addSublayer:self.frontShapeLayer];
        }
    }
    
     [self startAnimationValue:self.progress];
}
- (void)addGradLayerWithRect:(CGRect)rect{
    CGFloat kHeight = rect.size.height;
    CGRect viewRect = CGRectMake(0, 0, kHeight, kHeight);
    CGPoint centrePoint = CGPointMake(kHeight/2, kHeight/2);
    
    _leftGradLayer = ({
        CAGradientLayer *leftGradLayer = [CAGradientLayer layer];
        leftGradLayer.bounds = CGRectMake(0, 0, kHeight/2, kHeight);
        leftGradLayer.locations = @[@0.1];
        [leftGradLayer setColors:@[(id)kColor_Top.CGColor,(id)kColor_Bottom.CGColor]];
        leftGradLayer.position = CGPointMake(leftGradLayer.bounds.size.width/2, leftGradLayer.bounds.size.height/2);
        leftGradLayer;
    });
    _rightGradLayer = ({
        CAGradientLayer *rightGradLayer = [CAGradientLayer layer];
        rightGradLayer.locations = @[@0.1];
        rightGradLayer.bounds = CGRectMake(kHeight/2, 0, kHeight/2, kHeight);
        [rightGradLayer setColors:@[(id)kColor_Top.CGColor,(id)kColor_Bottom.CGColor]];
        rightGradLayer.position = CGPointMake(rightGradLayer.bounds.size.width/2+kHeight/2, rightGradLayer.bounds.size.height/2);
        rightGradLayer;
    });
    _gradLayer = ({
        CALayer *gradLayer = [CALayer layer];
        gradLayer.bounds = viewRect;
        gradLayer.position = centrePoint;
        gradLayer.backgroundColor = [UIColor clearColor].CGColor;
        gradLayer;
    });
    [_gradLayer addSublayer:_leftGradLayer];
    [_gradLayer addSublayer:_rightGradLayer];
}
- (void)startAnimationValue:(CGFloat)value{
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 1.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:value];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.frontShapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

- (void)setGradual:(BOOL)gradual{
    _gradual = gradual;
    if (gradual) {
        [self.frontShapeLayer removeFromSuperlayer];
        self.frontShapeLayer = nil;
    }else{
        [_gradLayer removeFromSuperlayer];
        _gradLayer = nil;
        [self.frontShapeLayer removeFromSuperlayer];
        self.frontShapeLayer = nil;
    }
}
- (void)setProgress:(CGFloat)progress{
    // 暂时处理为超出1就按1处理（肖扬、聪聪）
    if (progress > 1) progress = 1;
    NSAssert(progress >= 0 && progress <=1, @"超出范围");
    _progress = progress;
    [self setNeedsDisplay];
}

@end

//
//  HXBNavWaterView.m
//  HXBAccount
//
//  Created by 牛严 on 2016/12/16.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "HXBNavWaterView.h"

@interface HXBNavWaterView ()
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic,strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation HXBNavWaterView
{
    CGFloat _waveAmplitude;      //!< 振幅
    CGFloat _waveCycle;          //!< 周期
    CGFloat _waveSpeed;          //!< 速度
    CGFloat _waterWaveHeight;
    CGFloat _waterWaveWidth;
    CGFloat _wavePointY;
    CGFloat _waveOffsetX;            //!< 波浪x位移
    UIColor *_waveColor;             //!< 波浪颜色
    CGFloat _randomPar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR(251, 91, 91,1);
        self.layer.masksToBounds = YES;
        [self ConfigParams];
        [self.layer addSublayer:self.gradientLayer];
        [self startWave];
        [self.layer setMask:self.waveLayer];
    }
    return self;
}

#pragma mark 配置参数
- (void)ConfigParams
{
    _waterWaveWidth = self.frame.size.width;
    _waterWaveHeight = self.frame.size.height;
    _waveColor = COLOR(100, 100, 100,0.1);
    _waveSpeed = (0.05+((arc4random() % 100)/1000.0 - 0.05)*0.5)/M_PI;
    _waveOffsetX = 0;
    _waveAmplitude = 20;
    _waveCycle =  1.29 * M_PI / _waterWaveWidth;
    _randomPar = ((arc4random() % 100)/100.0 - 0.5) * 20;
}

#pragma mark 加载layer ，绑定runloop 帧刷新
- (void)startWave
{
    [self.layer addSublayer:self.waveLayer];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark 帧刷新事件
- (void)getCurrentWave
{
    _waveOffsetX += _waveSpeed;
    [self setwaveLayerPath];
}

#pragma mark shapeLayer动画
- (void)setwaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = 0;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= _waterWaveWidth; x ++) {
        y = _waveAmplitude * sin(_waveCycle * x + _waveOffsetX + _randomPar) + _waterWaveHeight-_waveAmplitude*2;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waterWaveWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    CGPathCloseSubpath(path);
    
    _waveLayer.path = path;

    CGPathRelease(path);
}

- (CGFloat)randomParameter
{
    return ((arc4random() % 100)/100.0 - 0.5) * 20;
}

#pragma mark Get
- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc]init];
        _gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _gradientLayer.colors = @[(__bridge id)COLOR(255, 126, 55, 1.0).CGColor,(__bridge id)COLOR(235, 68, 56, 1.0).CGColor];
        _gradientLayer.locations = @[@0.0, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0);
    }
    return _gradientLayer;
}

- (CAShapeLayer *)waveLayer
{
    if (!_waveLayer) {
        _waveLayer = [CAShapeLayer layer];
    }
    return _waveLayer;
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    }
    return _displayLink;
}

@end

//
//  HXBFinBase_FlowChartView.m
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBase_FlowChartView.h"

@interface HXBFinBase_FlowChartView ()
/**
 加入
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *addView;
/**
 开始收益
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *beginView;
/**
 到期退出view
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *levaeView;
/**
 同心圆位置
 */
@property (nonatomic,strong) NSMutableArray *concentricCirclesLocationArray;
@end
@implementation HXBFinBase_FlowChartView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}

- (void)setUP {
    self.color = HXBC_Red_Light;
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(20));
        make.top.equalTo(self).offset(kScrAdaptationH(15));
        make.height.equalTo(@(kScrAdaptationH(35)));
    }];
    [self.beginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.addView);
        make.height.equalTo(@(kScrAdaptationH(35)));
    }];
    [self.levaeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kScrAdaptationW(-20));
        make.top.equalTo(self.addView);
        make.height.equalTo(@(kScrAdaptationH(35)));
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.concentricCirclesLocationArray) return;
    if (!self.concentricCircles_spacing) {
        self.concentricCircles_spacing = self.circularDiameter - self.insideCircularDiameter;
    }
    ///直线的位置
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
    ///圆形的位置
    NSMutableArray *arrayM_Circular = [[NSMutableArray alloc]init];
    
    
    CGFloat lineWidth = (self.frame.size.width - (self.circularCount * self.circularDiameter)) / (self.circularCount - 1);
    CGFloat Y = self.frame.size.height / 2;
    for (int i = 0; i < self.circularCount; i ++) {
        CGFloat X = i * (lineWidth + self.circularDiameter);
        CGRect rect = CGRectMake(X, Y, lineWidth, self.lineHeight);
        NSValue *rectNumber = [NSValue valueWithCGRect:rect];
        [arrayM addObject:rectNumber];
    }
    
}
- (void)drawRect:(CGRect)rect {
    
    
}
///画一个圆形，是否为同心圆
- (void)drawRectArcWithIsMedicine:(BOOL)isConcentricCircles andContext:(CGContextRef)context andRect:(CGRect)rect{
    //MARK:画有线圈的圆饼
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);//设置填充颜色
    CGContextAddEllipseInRect(context, rect); //画一个椭圆或者圆
    CGContextDrawPath(context, kCGPathStroke);
    
    if (!isConcentricCircles) return;
    
    CGFloat X,Y,H,W;
    X = rect.origin.x + self.concentricCircles_spacing;
    Y = rect.origin.y + self.concentricCircles_spacing;
    W = rect.size.width - self.concentricCircles_spacing;
    H = rect.size.height - self.concentricCircles_spacing;
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGRect insideEllipseLocation = CGRectMake(X, Y, W, H);
    CGContextAddEllipseInRect(context, insideEllipseLocation);
    CGContextDrawPath(context, kCGPathFill);
}

/**
 加入
 */
- (HXBBaseView_TwoLable_View *) addView {
    if (!_addView) {
        _addView = [[HXBBaseView_TwoLable_View alloc] init];
        [self addSubview:_addView];
    }
    return _addView;
}
/**
 开始收益
 */
- (HXBBaseView_TwoLable_View *) beginView {
    if (!_beginView) {
        _beginView = [[HXBBaseView_TwoLable_View alloc]init];
        [self addSubview:_beginView];
    }
    return _beginView;
}
/**
 到期退出
 */
- (HXBBaseView_TwoLable_View *) levaeView {
    if (!_levaeView) {
        _levaeView = [[HXBBaseView_TwoLable_View alloc] init];
        [self addSubview:_levaeView];
    }
    return _levaeView;
}
@end

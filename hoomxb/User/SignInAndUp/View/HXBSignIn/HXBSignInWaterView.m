//
//  HXBNavWaterView.m
//  hoomxb
//
//  Created by HXB on 2017/7/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignInWaterView.h"
#import "HXBNavWaterView.h"

@interface HXBSignInWaterView ()
@property (nonatomic, strong) UIView *waveView;
@end

@implementation HXBSignInWaterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
        
    }
    return self;
}
- (void)setUP {
    HXBNavWaterView *wave1 = [[HXBNavWaterView alloc]initWithFrame:CGRectMake(0, 0, self.waveView.frame.size.width, 120)];
    wave1.alpha = 0.65;
    [self addSubview:wave1];
    
    HXBNavWaterView *wave2 = [[HXBNavWaterView alloc]initWithFrame:CGRectMake(0, 0, self.waveView.frame.size.width, 105)];
    [self addSubview:wave2];
    wave2.alpha = 0.75;
    
    HXBNavWaterView *wave3 = [[HXBNavWaterView alloc]initWithFrame:CGRectMake(0, 0, self.waveView.frame.size.width, 90)];
    [self addSubview:wave3];
    wave3.alpha = 0.85;
}
- (UIView *)waveView
{
    if (!_waveView) {
        _waveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _waveView;
}
@end

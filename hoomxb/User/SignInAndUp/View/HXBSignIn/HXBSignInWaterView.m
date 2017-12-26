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
    
    HXBNavWaterView *wave1 = [[HXBNavWaterView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120 + HXBStatusBarAdditionHeight)];
    wave1.alpha = 0.65;
    [self addSubview:wave1];
    
    HXBNavWaterView *wave2 = [[HXBNavWaterView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 105 + HXBStatusBarAdditionHeight)];
    [self addSubview:wave2];
    wave2.alpha = 0.75;
    
    HXBNavWaterView *wave3 = [[HXBNavWaterView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 90 + HXBStatusBarAdditionHeight)];
    [self addSubview:wave3];
    wave3.alpha = 0.85;
}

@end

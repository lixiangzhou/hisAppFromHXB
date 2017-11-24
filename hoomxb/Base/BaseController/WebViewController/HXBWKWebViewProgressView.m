//
//  HXBWKWebViewProgressView.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/24.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWKWebViewProgressView.h"

@interface HXBWKWebViewProgressView ()

@property (nonatomic) UIView *progressBarView;
@property (nonatomic) NSTimeInterval barAnimationDuration;
@property (nonatomic) NSTimeInterval fadeAnimationDuration;
@property (nonatomic) NSTimeInterval fadeOutDelay;

@end

@implementation HXBWKWebViewProgressView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setProgress:(float)progress
{
    [self setProgress:progress animated:NO];
}


#pragma mark - UI

- (void)setUI {
    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressBarView = [[UIView alloc] initWithFrame:self.bounds];
    _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIColor *tintColor = COR29;
    _progressBarView.backgroundColor = tintColor;
    [self addSubview:_progressBarView];
    
    _barAnimationDuration = 0.5f;
    _fadeAnimationDuration = 0.3f;
    _fadeOutDelay = 0.1f;
}

#pragma mark - Action


#pragma mark - Setter / Getter / Lazy
- (void)setProgress:(float)progress animated:(BOOL)animated
{
    BOOL isGrowing = progress > 0.0;
    [UIView animateWithDuration:(isGrowing && animated) ? _barAnimationDuration : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = _progressBarView.frame;
        frame.size.width = progress * kScreenWidth;
        _progressBarView.frame = frame;
        NSLog(@"进度%lf",_progressBarView.width);
    } completion:nil];
    
    if (progress >= 1.0) {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.0 delay:_fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 0.5;
        } completion:^(BOOL completed){
            if (self.HXBPageLoadStateSuccessBlock) {
                self.HXBPageLoadStateSuccessBlock();
            }
        }];
    }
}

#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end

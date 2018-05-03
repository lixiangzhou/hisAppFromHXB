//
//  HXBWKWebViewProgressView.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/24.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWKWebViewProgressView.h"

@interface HXBWKWebViewProgressView ()

@property (nonatomic, strong) UIView *progressBarView;
@property (nonatomic, assign) NSTimeInterval barAnimationDuration;

@end

@implementation HXBWKWebViewProgressView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        _barAnimationDuration = 0.5f;
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
}

- (UIView *)progressBarView {
    if(!_progressBarView) {
        _progressBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
        _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _progressBarView.backgroundColor = COR29;
        [self addSubview:_progressBarView];
    }
    
    return _progressBarView;
}
#pragma mark - Action


#pragma mark - Setter / Getter / Lazy
- (void)setProgress:(float)progress animated:(BOOL)animated
{
    BOOL isGrowing = progress > 0.0;
    
    [UIView animateWithDuration:(isGrowing && animated) ? _barAnimationDuration : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.progressBarView.frame;
        frame.size.width = progress * self.width;
        self.progressBarView.frame = frame;
        NSLog(@"进度%lf",self.progressBarView.width);
    } completion:^(BOOL finished) {
        if (progress>=1.0 && self.progressBarView.frame.size.width==self.width) {
            if (self.webViewLoadSuccessBlock) {
                self.webViewLoadSuccessBlock();
            }
            //完成加载之后需要将进度条重置为0
            [self.progressBarView removeFromSuperview];
            self.progressBarView = nil;
        }
    }];
}

#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end

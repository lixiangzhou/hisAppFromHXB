//
//  HXBWebViewProgress.m
//  DemoApp
//
//  Created by caihongji on 2018/5/3.
//  Copyright © 2018年 Satoshi Asano. All rights reserved.
//

#import "HXBWebViewProgress.h"
#import "HXBNsTimerManager.h"

@interface HXBWebViewProgress() {
    double _initedProgress;
    double _interactiveProgress;
    double _completeProgress;
    int _totalSeconds;
}

@property (nonatomic, assign) BOOL isStartProgress;
@property (nonatomic, assign) double progress;

@property (nonatomic, strong) HXBNsTimerManager* timerManager;

@end

@implementation HXBWebViewProgress

- (instancetype)init
{
    self = [super init];
    if (self) {
        _initedProgress = 0.2;
        _interactiveProgress = 0.5;
        _completeProgress = 1;
        _totalSeconds = 10;
    }
    return self;
}

- (void)dealloc
{
    if(self.timerManager) {
        [self.timerManager stopTimer];
    }
}

- (void)setProgress:(double)progress {
    _progress = progress;

    if(self.isStartProgress && [self.progressDelegate respondsToSelector:@selector(webViewProgress:updateProgress:)]) {
        [self.progressDelegate webViewProgress:self updateProgress:self.progress];
    }
}

- (void)reSet {
    if(self.timerManager) {
        [self.timerManager stopTimer];
        self.timerManager = nil;
    }
    self.progress = 0;
    
}

- (void)startProgress {
    if(self.isStartProgress) {
        [self reSet];
    }
    self.isStartProgress = YES;
    
    __weak typeof (self) weakSelf = self;
    self.timerManager = [HXBNsTimerManager createTimer:1 startSeconds:_totalSeconds countDownTime:NO notifyCall:^(NSString *times) {
        if(times.integerValue == _totalSeconds) {
            weakSelf.progress = _completeProgress;
        }
        else{
            double percent = times.integerValue*1.0/_totalSeconds;
            weakSelf.progress = _initedProgress+percent*_interactiveProgress;
        }
        
    }];
    [self.timerManager startTimer];
    self.progress = _initedProgress;
    
}

- (void)completeProgress{
    self.progress = _completeProgress;
    
    self.isStartProgress = NO;
    [self reSet];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if([self.webViewProxyDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.webViewProxyDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if([self.webViewProxyDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.webViewProxyDelegate webViewDidStartLoad:webView];
    }
    [self startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if([self.webViewProxyDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.webViewProxyDelegate webViewDidFinishLoad:webView];
    }
    [self completeProgress];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if([self.webViewProxyDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.webViewProxyDelegate webView:webView didFailLoadWithError:error];
    }
    [self completeProgress];
}

@end



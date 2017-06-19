//
//  HXBBaseViewController.m
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//


///注意ios8不能用

#import "HXBBaseViewController.h"
#import <WebKit/WebKit.h>

@interface HXBBaseViewController () <WKUIDelegate,WKNavigationDelegate>
@end

@implementation HXBBaseViewController{
    WKWebView * _webView;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //解决侧滑手势失效
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (UIScrollView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
        self.automaticallyAdjustsScrollViewInsets = NO;
//        self.edgesForExtendedLayout = UIRectEdgeNone;
        _hxbBaseVCScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
        [_hxbBaseVCScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _hxbBaseVCScrollView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self.view endEditing:true];
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
    }
}

//MARK: 销毁
- (void)dealloc {
    [self.hxbBaseVCScrollView removeObserver: self forKeyPath:@"contentOffset"];
    NSLog(@"✅被销毁 %@",self);
}
#pragma mark - gtter 方法
///隐藏导航条
- (void)setIsHiddenNavigationBar:(BOOL)isHiddenNavigationBar {
    _isHiddenNavigationBar = isHiddenNavigationBar;
    self.navigationController.navigationBarHidden = isHiddenNavigationBar;
}
///是否禁止scrollView自动向下平移64
- (void)setHxb_automaticallyAdjustsScrollViewInsets:(BOOL)hxb_automaticallyAdjustsScrollViewInsets {
    _hxb_automaticallyAdjustsScrollViewInsets = hxb_automaticallyAdjustsScrollViewInsets;
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = hxb_automaticallyAdjustsScrollViewInsets;
    };
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = self.hxb_automaticallyAdjustsScrollViewInsets;
    [self.navigationController setNavigationBarHidden:self.isHiddenNavigationBar animated:false];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavigationBar animated:false];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:false];
}

@end

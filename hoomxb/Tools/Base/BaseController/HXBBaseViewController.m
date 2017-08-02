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
#import "SVGKImage.h"
@interface HXBBaseViewController () <WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);
@property (nonatomic,strong) HXBColourGradientView *colorGradientView;
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
    
    [self setupLeftBackBtn];
}


/**
 统一设置返回按钮
 */
- (void)setupLeftBackBtn
{
    UIButton *leftBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
//    [leftBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBackBtn setImage:[SVGKImage imageNamed:@"back.svg"].UIImage forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    leftBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBackBtn addTarget:self action:@selector(leftBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBackBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackBtn];
}



- (void)leftBackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setIsScroll:(BOOL)isScroll {
    _isScroll = isScroll;
    if (isScroll) {
        _hxbBaseVCScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    }
}
- (UITableView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
//        self.automaticallyAdjustsScrollViewInsets = true;
//        self.edgesForExtendedLayout = UIRectEdgeAll;
        _hxbBaseVCScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
//        self.view.frame = _hxbBaseVCScrollView.bounds;
        [_hxbBaseVCScrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _hxbBaseVCScrollView.tableFooterView = [[UIView alloc]init];
        _hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    }
    return _hxbBaseVCScrollView;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        NSNumber *tracking = change[NSKeyValueChangeNewKey];
        if (tracking.integerValue == UIGestureRecognizerStateBegan && self.trackingScrollViewBlock) {
            self.trackingScrollViewBlock(self.hxbBaseVCScrollView);
        }
        return;
    }
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSNumber *offsetNumb = change[NSKeyValueChangeNewKey];
        CGPoint offsetPoint = [offsetNumb CGPointValue];
        self.colorGradientView.frame = CGRectMake(0, 0, kScreenWidth, self.colorGradientView.height + offsetPoint.y);
        self.colorGradientView.endPoint = CGPointMake(kScreenWidth, self.colorGradientView.frame.size.height);
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
}

//MARK: 销毁
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_StopAllRequest object:nil];
    [self.hxbBaseVCScrollView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
    NSLog(@"✅被销毁 %@",self);
}
#pragma mark - gtter 方法
///隐藏导航条
- (void)setIsHiddenNavigationBar:(BOOL)isHiddenNavigationBar {
    _isHiddenNavigationBar = isHiddenNavigationBar;
    self.navigationController.navigationBarHidden = isHiddenNavigationBar;
}

///透明naveBar
- (void)setIsTransparentNavigationBar:(BOOL)isTransparentNavigationBar {
    _isTransparentNavigationBar = isTransparentNavigationBar;
    if (isTransparentNavigationBar) {
        self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}
- (void)setIsColourGradientNavigationBar:(BOOL)isColourGradientNavigationBar {
    if (isColourGradientNavigationBar) {
        self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = true;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top"]];
        [self.view addSubview:imageView];
        imageView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    }
}

- (void)setIsBlueGradientNavigationBar:(BOOL)isBlueGradientNavigationBar
{
    if (isBlueGradientNavigationBar) {
        self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = true;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav_top_blue"]];
        [self.view addSubview:imageView];
        imageView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    }
}

///是否禁止scrollView自动向下平移64
- (void)setHxb_automaticallyAdjustsScrollViewInsets:(BOOL)hxb_automaticallyAdjustsScrollViewInsets {
    _hxb_automaticallyAdjustsScrollViewInsets = hxb_automaticallyAdjustsScrollViewInsets;
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = hxb_automaticallyAdjustsScrollViewInsets;
    };
//    if (hxb_automaticallyAdjustsScrollViewInsets) {
//        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }
}
#pragma mark - 隐藏导航条
- (void)viewWillAppear:(BOOL)animated{
    //设置电池栏的颜色
    [super viewWillAppear:animated];
    self.isTransparentNavigationBar = _isTransparentNavigationBar;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.automaticallyAdjustsScrollViewInsets = self.hxb_automaticallyAdjustsScrollViewInsets;
    [self.navigationController setNavigationBarHidden:self.isHiddenNavigationBar animated:false];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:true];
    [self.navigationController setNavigationBarHidden:self.isHiddenNavigationBar animated:false];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:false];
}
///tracking ScrollView
- (void) trackingScrollViewBlock: (void(^)(UIScrollView *scrollView)) trackingScrollViewBlock {
    self.trackingScrollViewBlock = trackingScrollViewBlock;
}
///白色的电池栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end

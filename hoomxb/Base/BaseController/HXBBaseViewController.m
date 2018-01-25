//
//  HXBBaseViewController.m
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//


///注意ios8不能用

#import "HXBBaseViewController.h"
#import <WebKit/WebKit.h>
#import "SVGKit/SVGKImage.h"
#import "HXBNoNetworkStatusView.h"

@interface HXBBaseViewController () <UIGestureRecognizerDelegate>

@property (nonatomic,strong) HXBColourGradientView *colorGradientView;
@property (nonatomic,strong) UIImageView *nacigationBarImageView;
@property (nonatomic, strong, readwrite) HXBNoDataView *noDataView;

@property (nonatomic, strong) HXBNoNetworkStatusView *noNetworkStatusView;

@property (nonatomic, strong) UIButton *leftBackBtn;
@end

@implementation HXBBaseViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLeftBackBtn];
    
    [self loadNoNetworkView];
}

- (void)viewWillAppear:(BOOL)animated{
    //适配iphoneX上的tabbar
    if(HXBIPhoneX) {
        int height = self.tabBarController.tabBar.height;
        if(height != 83){
            self.tabBarController.tabBar.hidden = YES;
            self.tabBarController.tabBar.height = 83;
        }
    }
    
    //设置电池栏的颜色
    [super viewWillAppear:animated];
    if (self.leftBackBtn){
        if(!self.leftBackBtn.superview){
            [self setupLeftBackBtn];
        }
    }
    self.isTransparentNavigationBar = _isTransparentNavigationBar;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    if(!_isHiddenNavigationBar) {
        [self.navigationController setNavigationBarHidden:self.isHiddenNavigationBar animated:NO];
    }
    //保障无网络时， 该子视图能在最上方
    [self.view bringSubviewToFront:self.noNetworkStatusView];
    
    self.noNetworkStatusView.hidden = self.ignoreNetwork;
}

- (void)viewDidAppear:(BOOL)animated {
    //是否需要重新加载页面
    HXBBaseNavigationController* navVC = (HXBBaseNavigationController*)self.navigationController;
    if (!navVC.occurRightGestureAction) {
        [self reLoadWhenViewAppear];
    }
    else {
        navVC.occurRightGestureAction = NO;
    }
    
    [super viewDidAppear:animated];
    //双重保障无网络时， 该子视图能在最上方
    [self.view bringSubviewToFront:self.noNetworkStatusView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    [self.navigationController setNavigationBarHidden:self.isHiddenNavigationBar animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI

- (void)setupLeftBackBtn
{
    UIButton *leftBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    self.leftBackBtn = leftBackBtn;
    [leftBackBtn setImage:[SVGKImage imageNamed:@"back.svg"].UIImage forState:UIControlStateNormal];
    [leftBackBtn setImage:[SVGKImage imageNamed:@"back.svg"].UIImage forState:UIControlStateHighlighted];
    
    [leftBackBtn addTarget:self action:@selector(leftBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    if (@available(iOS 11.0, *)) {
        leftBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else {
        spaceItem.width = -15;
    }
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,[[UIBarButtonItem alloc] initWithCustomView:leftBackBtn]];
}


#pragma mark - 加载无网络视图

- (BOOL)loadNoNetworkView {
    if (self.navigationController.childViewControllers.count > 1) {
        if (!KeyChain.ishaveNet) {
            self.noNetworkStatusView.hidden = KeyChain.ishaveNet;
            [self.view addSubview:self.noNetworkStatusView];
            return YES;
        } else {
            self.noNetworkStatusView.hidden = KeyChain.ishaveNet;
        }
    }
    
    return NO;
}

- (void)leftBackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter 方法

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
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = YES;
        self.nacigationBarImageView.image = [UIImage imageNamed:@"top"];
        [self.view bringSubviewToFront: self.nacigationBarImageView];
    }
}

- (void)setIsWhiteColourGradientNavigationBar:(BOOL)isWhiteColourGradientNavigationBar {
    if (isWhiteColourGradientNavigationBar) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = YES;
        self.nacigationBarImageView.backgroundColor = [UIColor whiteColor];
        self.nacigationBarImageView.image = [UIImage imageNamed:@""];
        [self.view bringSubviewToFront: self.nacigationBarImageView];
    }
}
- (void)setIsRedColorWithNavigationBar: (BOOL) isRedColorWithNavigationBar {
    
    if (isRedColorWithNavigationBar) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = YES;
        self.nacigationBarImageView.image = [UIImage imageNamed:@"NavigationBar"];
        [self.view bringSubviewToFront: self.nacigationBarImageView];
    }
}
- (void)setIsBlueGradientNavigationBar:(BOOL)isBlueGradientNavigationBar
{
    if (isBlueGradientNavigationBar) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = YES;
        self.nacigationBarImageView.image = [UIImage imageNamed:@"nav_top_blue"];
        [self.view bringSubviewToFront: self.nacigationBarImageView];
    }
}

#pragma mark - Other
///白色的电池栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// 子类实现的方法
- (void)getNetworkAgain {
    
}

#pragma mark - Lazy

- (HXBNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[HXBNoDataView alloc] initWithFrame:CGRectZero];
        _noDataView.imageName = @"Fin_NotData";
        _noDataView.noDataMassage = @"暂无数据";
        _noDataView.hidden = YES;
    }
    return _noDataView;
}

- (UIImageView *)nacigationBarImageView {
    if (!_nacigationBarImageView) {
        _nacigationBarImageView = [[UIImageView alloc]init];
        _nacigationBarImageView.frame = CGRectMake(0, 0, kScreenWidth, HXBStatusBarAndNavigationBarHeight);
        [self.view addSubview:_nacigationBarImageView];
        [self.view bringSubviewToFront:_nacigationBarImageView];
    }
    return _nacigationBarImageView;
}

/**
 无网界面显示
 */
- (HXBNoNetworkStatusView *)noNetworkStatusView {
    
    kWeakSelf
    if (!_noNetworkStatusView) {
        _noNetworkStatusView = [HXBNoNetworkStatusView noNetworkStatusView];
        _noNetworkStatusView.getNetworkAgainBlock = ^{
            weakSelf.noNetworkStatusView.hidden = KeyChain.ishaveNet;
            if (KeyChain.ishaveNet) {
                [weakSelf getNetworkAgain];
            }else{
                [HxbHUDProgress showMessageCenter:kNoNetworkText inView:nil];
            }
        };
    }
    return _noNetworkStatusView;
}

/**
 隐藏导航栏，仅能在派生类的viewWillAppear方法中调用
 调用条件：如果需要隐藏导航栏就调用调用该方法
 @param animated 是否动画
 */
- (void)hideNavigationBar:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    _isHiddenNavigationBar = YES;
    //设置背景色为透明
    self.isTransparentNavigationBar = YES;
    //设置文本颜色透明
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor clearColor]};
    //清空左侧按钮
    self.navigationItem.leftBarButtonItems = nil;
}

/**
 设置导航栏title颜色透明， 仅能在派生类的viewWillAppear方法中调用
 调用条件：如果当前页面有presentedViewController这个方法的调用， 那就需要调用该方法
 */
- (void)transparentNavigationTitle
{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor clearColor]};
}

/**
 替代viewDidAppear方法，子类如果需要重新加载页面，只需重写这个方法就可以
 注意：这个方法处理了滑动返回时的种种情况，要将所有的重新加载操作，放在这个方法里
 */
- (void)reLoadWhenViewAppear {
    
}
@end

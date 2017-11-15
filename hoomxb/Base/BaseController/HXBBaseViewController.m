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
//@property (nonatomic, assign) BOOL isCanSideBack;
//@property (nonatomic, strong) HXBNoNetworkStatusView *noNetworkStatusView;

@property (nonatomic, strong) UIButton *leftBackBtn;
@end

@implementation HXBBaseViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLeftBackBtn];
    
    [self loadNoNetwork];
}

- (void)viewWillAppear:(BOOL)animated{
    //设置电池栏的颜色
    [super viewWillAppear:animated];
    if (self.leftBackBtn){
        if(!self.leftBackBtn.superview){
            [self setupLeftBackBtn];
        }
    }
    self.isTransparentNavigationBar = _isTransparentNavigationBar;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController setNavigationBarHidden:self.isHiddenNavigationBar animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.view bringSubviewToFront:self.noNetworkStatusView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:true];
    
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


#pragma mark - Action

- (void)loadNoNetwork {
    if (self.navigationController.childViewControllers.count <= 1) return;
    
    if (!KeyChain.ishaveNet) {
        self.noNetworkStatusView.hidden = KeyChain.ishaveNet;
        [self.view addSubview:self.noNetworkStatusView];
    } else {
        self.noNetworkStatusView.hidden = KeyChain.ishaveNet;
    }
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
        self.isTransparentNavigationBar = true;
        self.nacigationBarImageView.image = [UIImage imageNamed:@"top"];
        [self.view addSubview:self.nacigationBarImageView];
    }
}

- (void)setIsWhiteColourGradientNavigationBar:(BOOL)isWhiteColourGradientNavigationBar {
    if (isWhiteColourGradientNavigationBar) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = true;
        self.nacigationBarImageView.backgroundColor = [UIColor whiteColor];
        self.nacigationBarImageView.image = [UIImage imageNamed:@""];
        [self.view addSubview:self.nacigationBarImageView];
    }
}
- (void)setIsRedColorWithNavigationBar: (BOOL) isRedColorWithNavigationBar {
    
    if (isRedColorWithNavigationBar) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = true;
        self.nacigationBarImageView.image = [UIImage imageNamed:@"NavigationBar"];
        [self.view addSubview:self.nacigationBarImageView];
    }
}
- (void)setIsBlueGradientNavigationBar:(BOOL)isBlueGradientNavigationBar
{
    if (isBlueGradientNavigationBar) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
        self.isTransparentNavigationBar = true;
        self.nacigationBarImageView.image = [UIImage imageNamed:@"nav_top_blue"];
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

- (UIImageView *)nacigationBarImageView {
    if (!_nacigationBarImageView) {
        _nacigationBarImageView = [[UIImageView alloc]init];
        if (LL_iPhoneX) {
            _nacigationBarImageView.frame = CGRectMake(0, 0, kScreenWidth, 88);
        } else {
            _nacigationBarImageView.frame = CGRectMake(0, 0, kScreenWidth, 64);
        }
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
                [HxbHUDProgress showMessageCenter:@"暂无网络，请稍后再试" inView:nil];
            }
        };
    }
    return _noNetworkStatusView;
}

@end

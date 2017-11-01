//
//  HXBMyCouponViewController.m
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyCouponViewController.h"

#import "HXBTopTabView.h"
#import "HXBMyCouponListViewController.h"
#import "HXBMyCouponExchangeViewController.h"



@interface HXBMyCouponViewController () <HXBTopTabViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) HXBMyCouponListViewController *couponListVC;
@property (nonatomic, strong) HXBMyCouponExchangeViewController *couponExchangeVC;

@property (nonatomic, strong) HXBTopTabView *topTabView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation HXBMyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.isReadColorWithNavigationBar = YES;
    
       self.isColourGradientNavigationBar = true;
    
//    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
//    self.topImageView.image = [UIImage imageNamed:@"NavigationBar"];
//    [self.view addSubview:self.topImageView];
    
    self.title = @"优惠券";
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - UI
- (void)setUI {
    [self addChildVC];
    [self.view addSubview:self.topTabView];
    [self.view addSubview:self.scrollView];
    
    [self setupSubViewFrame];
}

- (void)setupSubViewFrame{
    
}

- (void)addChildVC {
    self.couponListVC = [HXBMyCouponListViewController new];
    self.couponExchangeVC = [HXBMyCouponExchangeViewController new];
    
    [self addChildViewController:self.couponListVC];
    [self addChildViewController:self.couponExchangeVC];
}
- (HXBTopTabView *)topTabView{
    if (!_topTabView) {
        _topTabView = [[HXBTopTabView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)
                                                    titles:@[@"优惠券", @"兑换优惠券"]
                                                      font:kHXBFont_PINGFANGSC_REGULAR_750(30)
                                               normalColor:RGBA(51, 51, 51, 1)
                                             selectedColor:RGBA(253, 54, 54, 1)
                                              sepLineColor:[UIColor whiteColor]
                                              sepLineWidth:1
                                             sepLineHeight:1
                                           bottomLineColor:RGBA(253, 54, 54, 1)
                                          bottomLineHeight:1
                                bottomLineWidthAdjustTitle:YES
                                     bottomLineWidthPading:5
                                             selectedIndex:0];
        _topTabView.delegate = self;
    }
    return _topTabView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topTabView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.topTabView.frame))];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        self.scrollView = _scrollView;
        
        self.couponListVC.view.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        self.couponExchangeVC.view.frame = CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        [_scrollView addSubview:self.couponListVC.view];
        [_scrollView addSubview:self.couponExchangeVC.view];
    }
    return _scrollView;
}

#pragma mark - HXBTopTabViewDelegate
- (void)topTabView:(HXBTopTabView *)topTabView didClickIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.frame.size.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.topTabView.selectedIndex = (NSInteger)(scrollView.contentOffset.x / scrollView.frame.size.width);
}
@end

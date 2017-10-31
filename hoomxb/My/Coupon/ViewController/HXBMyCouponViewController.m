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

@property (nonatomic, weak) HXBTopTabView *topTabView;
@property (nonatomic, assign) UIScrollView *scrollView;
@end

@implementation HXBMyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优惠券";
    [self setUI];
}

#pragma mark - UI
- (void)setUI {
    [self addChildVC];
    [self setTab];
    [self setScrollView];
}

- (void)addChildVC {
    self.couponListVC = [HXBMyCouponListViewController new];
    self.couponExchangeVC = [HXBMyCouponExchangeViewController new];
    
    [self addChildViewController:self.couponListVC];
    [self addChildViewController:self.couponExchangeVC];
}

- (void)setTab {
    HXBTopTabView *tabView = [[HXBTopTabView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)
                                                           titles:@[@"优惠券", @"兑换优惠券"]
                                                             font:[UIFont systemFontOfSize:16]
                                                      normalColor:[UIColor darkGrayColor]
                                                    selectedColor:[UIColor redColor]
                                                     sepLineColor:[UIColor whiteColor]
                                                     sepLineWidth:1
                                                    sepLineHeight:1
                                                  bottomLineColor:[UIColor redColor]
                                                 bottomLineHeight:1
                                       bottomLineWidthAdjustTitle:YES
                                            bottomLineWidthPading:5
                                                    selectedIndex:0];
    self.topTabView = tabView;
    tabView.delegate = self;
    [self.view addSubview:tabView];
}

- (void)setScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topTabView.frame), self.view.frame.size.width, self.view.size.height - CGRectGetMaxY(self.topTabView.frame) - 64)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [scrollView addSubview:self.couponListVC.view];
    [scrollView addSubview:self.couponExchangeVC.view];
    
    self.couponListVC.view.backgroundColor = [UIColor redColor];
    self.couponExchangeVC.view.backgroundColor = [UIColor yellowColor];
    
    self.couponListVC.view.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    self.couponExchangeVC.view.frame = CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
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

//
//  HXBMyCouponListViewController.m
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyCouponListViewController.h"
#import "HXBMyCouponListView.h"
#import "HXBMyCouponListModel.h"
#import "AppDelegate.h"
#import "HXBInviteListViewController.h"
#import "HXBRootVCManager.h"
#import "HXBBannerWebViewController.h"
#import "HXBCouponListViewModel.h"

@interface HXBMyCouponListViewController ()

@property (nonatomic, strong) HXBMyCouponListView *myView;
@property (nonatomic, strong) HXBCouponListViewModel *viewModel;
@end

@implementation HXBMyCouponListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf
    self.viewModel = [[HXBCouponListViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    self.view.backgroundColor = RGBA(244, 243, 248, 1);
    [self.view addSubview:self.myView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData_myCouponListInfo:YES];
}

#pragma mark - 加载数据
- (void)loadData_myCouponListInfo:(BOOL)isNew {
    
    kWeakSelf
    [self.viewModel downLoadMyAccountListInfo:isNew completion:^(BOOL isSuccess) {
        weakSelf.myView.isStopRefresh_Home = YES;
        
        if (isSuccess) {
            weakSelf.myView.myCouponListModelArray = weakSelf.viewModel.dataSource;
            
            if (weakSelf.viewModel.showPullup) {
                [weakSelf.myView.mainTableView hxb_footerWithRefreshBlock:^{
                    [weakSelf loadData_myCouponListInfo:NO];
                }];
            } else {
                weakSelf.myView.mainTableView.mj_footer = nil;
            }
            
            if (weakSelf.viewModel.showNoMoreData) {
                [weakSelf.myView.mainTableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [weakSelf.myView.mainTableView.mj_footer endRefreshing];
            }
            
        }
    }];
}

- (void)getNetworkAgain{
    [self loadData_myCouponListInfo:YES];
}

#pragma mark - Setter / Getter / Lazy

- (void)setAccountModel:(HXBMyRequestAccountModel *)accountModel {
    _accountModel = accountModel;
    if (accountModel) {
        self.myView.isDisplayInvite = accountModel.isDisplayInvite;
    }
}

-(HXBMyCouponListView *)myView{
    if (!_myView) {
        _myView = [[HXBMyCouponListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - HXBStatusBarAndNavigationBarHeight - 44)];
        kWeakSelf
        _myView.block = ^{
            HXBBannerWebViewController *webViewVC = [[HXBBannerWebViewController alloc] init];
            webViewVC.pageUrl = kHXBH5_InviteDetailURL;
            [weakSelf.navigationController pushViewController:webViewVC animated:YES];
        };
        _myView.userInteractionEnabled = YES;
        /**
         点击cell中按钮的回调的Block
         */
        _myView.actionButtonClickBlock = ^(){
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            //红利计划列表页
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_PlanAndLoan_Fragment object:@{@"selectedIndex" : @0}];
            [[HXBRootVCManager manager].mainTabbarVC setSelectedIndex:1];
        };
        _myView.homeRefreshHeaderBlock = ^(){
            [weakSelf loadData_myCouponListInfo:YES];
        };
    }
    return _myView;
}


@end

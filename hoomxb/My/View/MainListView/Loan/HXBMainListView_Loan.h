//
//  HXBMainListView_Loan.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBMYViewModel_MainLoanViewModel.h"
@class HXBMYModel_AssetStatistics_Loan;
@interface HXBMainListView_Loan : UIView

#pragma mark - 数据源
///资产统计model
@property (nonatomic,strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel*> *repaying_ViewModelArray;
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel*> *bid_ViewModelArray;

#pragma mark - 事件的传递
///中间的toolBarView 的 select将要改变的时候
- (void)changeMidSelectOptionFuncWithBlock:(void (^)(UIButton *button, NSString *title, NSInteger index, HXBRequestType_MY_LoanRequestType requestType))changeMidSelectOptionBlock;

///repaying - cell的点击事件
///点击了Loan list cell
- (void)clickLoan_bid_CellFuncWithBlock: (void(^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock;
- (void)clickLoan_repaying_CellFuncWithBlock:(void (^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock;

//MARK: 刷新的传递
- (void)erpaying_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock;
- (void)bid_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock;
- (void)endRefresh;

///资产统计的刷新
- (void)requestAssetStatisticsWithBlockFunc: (void(^)())assetStatisticsWithBlock;

/// 将要切换底部的scrollView的时候调用
- (void)switchBottomScrollViewCallBackFunc: (void(^)(NSInteger index, NSString *title, UIButton *option))switchBottomScrollViewBlock;
@end

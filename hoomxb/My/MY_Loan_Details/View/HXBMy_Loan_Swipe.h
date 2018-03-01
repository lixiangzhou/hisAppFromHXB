//
//  HXBMy_Loan_Swipe.h
//  hoomxb
//
//  Created by HXB on 2017/6/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "SwipeTableView.h"
#import "HXBMYViewModel_MainLoanViewModel.h"
@class HXBMYModel_AssetStatistics_Loan;
@class HXBMYModel_Loan_LoanRequestModel;
@interface HXBMy_Loan_Swipe : SwipeTableView
/**
 0： 表示收益中
 */
//- (void)swipeLoadDataWithBlock: ((void)(^)(NSInteger index))block;

#pragma mark - 数据源
///资产统计model
@property (nonatomic,strong) HXBMYModel_Loan_LoanRequestModel *loanAccountModel;
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

//
//  HXBMainListView_Loan.h
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBMYViewModel_MainLoanViewModel.h"
@class HXBMYModel_AssetStatistics_Loan;
@class HXBMYModel_Loan_LoanRequestModel;
@class HXBMY_LoanTruansferViewModel;
@interface HXBMainListView_Loan : UIView

#pragma mark - 数据源
///资产统计model
@property (nonatomic,strong) HXBMYModel_Loan_LoanRequestModel *loanAccountModel;
@property (nonatomic,strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel*> *repaying_ViewModelArray;
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel*> *bid_ViewModelArray;
@property (nonatomic,strong) NSArray <HXBMY_LoanTruansferViewModel *>* loanTruansferViewModelArray;

///loan 收益中
@property (nonatomic, assign) BOOL isRepayingLastPage; //收益中是否最后一页
@property (nonatomic, assign) BOOL isRepayingShowLoadMore; //收益中是否显示加载更多

/// loan 投标中
@property (nonatomic, assign) BOOL isBidLastPage; //投标中是否最后一页
@property (nonatomic, assign) BOOL isBidShowLoadMore; //投标中是否显示加载更多

///转让中
@property (nonatomic, assign) BOOL isTruanfserLastPage; //转让中是否最后一页
@property (nonatomic, assign) BOOL isTruanfserShowLoadMore; //转让中是否显示加载更多

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
- (void)loanTruansfer_RefreashWithDownBlock:(void (^)())downBlock andUPBlock:(void (^)())UPBlock;
- (void)endRefresh;

///资产统计的刷新
- (void)requestAssetStatisticsWithBlockFunc: (void(^)())assetStatisticsWithBlock;

/// 将要切换底部的scrollView的时候调用
- (void)switchBottomScrollViewCallBackFunc: (void(^)(NSInteger index, NSString *title, UIButton *option))switchBottomScrollViewBlock;
@end

//
//  HXBMY_LoanListViewModel.h
//  hoomxb
//
//  Created by caihongji on 2018/1/30.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMYViewModel_MainLoanViewModel.h"
#import "HXBMY_LoanTruansferViewModel.h"
#import "HXBMYModel_Loan_LoanRequestModel.h"

@interface HXBMY_LoanListViewModel : NSObject

///loan 收益中
@property (nonatomic, strong) NSMutableArray <HXBMYViewModel_MainLoanViewModel *> *repaying_Loan_array;
@property (nonatomic, assign) BOOL isRepayingLastPage; //收益中是否最后一页
@property (nonatomic, assign) BOOL isRepayingShowLoadMore; //收益中是否显示加载更多

/// loan 投标中
@property (nonatomic, strong) NSMutableArray <HXBMYViewModel_MainLoanViewModel *> *bid_Loan_array;
@property (nonatomic, assign) BOOL isBidLastPage; //投标中是否最后一页
@property (nonatomic, assign) BOOL isBidShowLoadMore; //投标中是否显示加载更多

///转让中
@property (nonatomic, strong) NSMutableArray <HXBMY_LoanTruansferViewModel *> *loanTruanfserViewModelArray;
@property (nonatomic, assign) BOOL isTruanfserLastPage; //转让中是否最后一页
@property (nonatomic, assign) BOOL isTruanfserShowLoadMore; //转让中是否显示加载更多

///loan  账户内散标资产
@property (nonatomic, strong) HXBMYModel_Loan_LoanRequestModel *loanAcccountModel;


/**
 账户内散标资产

 @param isShowHug 是否显示加载框
 @param resultBlock 结果回调
 */
- (void)loanAssets_AccountRequestSuccessBlock:(BOOL)isShowHug andResultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 散标列表的 请求

 @param loanRequestType 债转类型
 @param isUPData 是否下拉
 @param resultBlock 结果回调
 */
- (void)myLoan_requestWithLoanType:(HXBRequestType_MY_LoanRequestType)loanRequestType
                         andUpData: (BOOL)isUPData
                    andResultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 转让中 列表的网络数据的请求

 @param isUPData 是否下拉
 @param resultBlock 结果回调
 */
- (void)myLoanTruansfer_requestWithLoanTruansferWithIsUPData: (BOOL)isUPData
                                              andResultBlock: (void(^)(BOOL isSuccess))resultBlock;
@end

//
//  HXBDataManager.h
//  hoomxb
//
//  Created by HXB on 2017/8/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinHomePageViewModel_PlanList;
@interface HXBDataManager : NSObject

#pragma mark - 理财页
///获取 理财页 plan 列表
+ (NSArray <HXBFinHomePageViewModel_PlanList *>*) getFin_PlanListViewModelArray;
///获取 理财页 loan 列表
+ (NSArray *) getFin_LoanListViewModelArray;
///获取 理财页 loanTransfer 列表
+ (NSArray *) getFin_LoanTransferListViewModelArray;

///储存 理财页 plan 列表
+ (void) setFin_PlanListViewModelArrayWithArray:(NSArray *)planArray;
///储存 理财页 loan 列表
+ (void) setFin_LoanListViewModelArray:(NSArray *)loanArray;
///储存 理财页 loanTransfer 列表
+ (void) setFin_LoanTransferListViewModelArrayWithArray:(NSArray *)loanTransferArray;



#pragma mark - 首页
///获取 理财页 plan 列表
+ (NSArray *) getHomePage_PlanListViewModelArray;

///储存 理财页 plan 列表
+ (void) setHomePage_PlanListViewModelArrayWithArray:(NSArray *)homePagePlanArray;
@end

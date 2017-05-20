//
//  HXBBaseTableView_MYPlanList_TableView.h
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_MianPlanViewModel;
@class HXBMYViewModel_MainLoanViewModel;
///底部的TableView
@interface HXBBaseTableView_MYPlanList_TableView : HXBBaseTableView
///数据源
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*mainPlanViewModelArray;
///数据源 loan
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel *>*mainLoanViewModelArray;
///点击了cell
- (void)clickLoanCellFuncWithBlock: (void(^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock;
- (void)clickPlanCellFuncWithBlock: (void(^)(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickPlanCellIndex))clickPlanCellBlock;
@end

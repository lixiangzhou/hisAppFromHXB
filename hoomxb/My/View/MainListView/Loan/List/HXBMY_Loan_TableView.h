//
//  HXBMY_Loan_TableView.h
//  hoomxb
//
//  Created by HXB on 2017/8/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_MainLoanViewModel;
@interface HXBMY_Loan_TableView : UITableView
///数据源 loan
@property (nonatomic,strong) NSArray <HXBMYViewModel_MainLoanViewModel *>*mainLoanViewModelArray;
///点击了cell
- (void)clickLoanCellFuncWithBlock: (void(^)(HXBMYViewModel_MainLoanViewModel *loanViewModel, NSIndexPath *clickLoanCellIndex))clickLoanCellBlock;
@end

//
//  HXBFin_DetailLoanTruansfer_ViewController.h
//  hoomxb
//
//  Created by HXB on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@class HXBFinHomePageViewModel_LoanTruansferViewModel;
@class HXBFinDetail_TableViewCellModel;
@class HXBFinHomePageViewModel_LoanList;

@interface HXBFin_DetailLoanTruansfer_ViewController : HXBBaseViewController
@property (nonatomic,strong) HXBFinHomePageViewModel_LoanTruansferViewModel *loanTransfer_ViewModel;

///剩余可投是否分为左右两个
@property (nonatomic,assign) BOOL isFlowChart;

///底部的tableView的模型数组
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*modelArray;

///loanID
@property (nonatomic,copy) NSString *loanID;

@property (nonatomic,strong) HXBFinHomePageViewModel_LoanTruansferViewModel *loanTruansferListViewMode;
@end

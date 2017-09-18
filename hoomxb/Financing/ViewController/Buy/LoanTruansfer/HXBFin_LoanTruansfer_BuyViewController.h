//
//  HXBFin_LoanTruansfer_BuyViewController.h
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class
HXBFinDetailViewModel_LoanTruansferDetail,
HXBFin_JoinimmediateView_Loan_ViewModel;

@interface HXBFin_LoanTruansfer_BuyViewController : HXBBaseViewController
@property (nonatomic,strong) HXBFinDetailViewModel_LoanTruansferDetail *loanTruansferViewModel;
@property (nonatomic,copy) NSString *availablePoint;//可用余额；
@end

//
//  HXBLoan_JoinImmediatelyViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class HXBFinDetailViewModel_LoanDetail;
@class HXBFin_JoinimmediateView_Loan_ViewModel;
@interface HXBFin_Loan_BuyViewController : HXBBaseViewController
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) HXBFinDetailViewModel_LoanDetail *loanViewModel;
@end

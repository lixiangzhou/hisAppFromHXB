//
//  HXBFinBuy_Loan_ViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Loan_BuyViewController.h"
#import "HXBFinDetailViewModel_LoanDetail.h"

@interface HXBFinBuy_Loan_ViewController : HXBFin_Loan_BuyViewController
@property (nonatomic,strong) HXBFinDetailViewModel_LoanDetail *loanViewModel;
@property (nonatomic,copy) NSString *availablePoint;//可用余额；
@end

//
//  HXBMY_LoanList_DetailViewController.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class HXBMYViewModel_MainLoanViewModel;
@interface HXBMY_LoanList_DetailViewController : HXBBaseViewController
/**
 数据源
 */
@property (nonatomic,strong)HXBMYViewModel_MainLoanViewModel *loanDetailViewModel;
@end

//
//  HXBFin_creditorChange_buy_ViewController.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class
HXBFinDetailViewModel_LoanTruansferDetail,
HXBFin_JoinimmediateView_Loan_ViewModel;

typedef enum : NSUInteger {
    HXB_Plan,
    HXB_Loan,
    HXB_Creditor,
} HXB_Fin_Type;
@interface HXBFin_creditorChange_buy_ViewController : HXBBaseViewController

@property (nonatomic,copy) NSString *availablePoint; // 可用余额
@property (nonatomic,copy) NSString *placeholderStr; // 占位符
@property (nonatomic,copy) NSString *loanId; // 标的 id

@property (nonatomic, assign) HXB_Fin_Type  type; // 标的类型


@end

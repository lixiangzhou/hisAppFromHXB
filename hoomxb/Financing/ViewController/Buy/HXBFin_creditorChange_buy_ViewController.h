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

@property (nonatomic,copy) NSString *availablePoint; // topViewLabel
@property (nonatomic,copy) NSString *placeholderStr; // 占位符
@property (nonatomic,copy) NSString *loanId; // 标的 id
@property (nonatomic,copy) NSString *cashType; // 收益方式
@property (nonatomic,copy) NSString *totalInterest; // 预期收益
@property (nonatomic,copy) NSString *registerMultipleAmount; // 最小倍数
@property (nonatomic,copy) NSString *minRegisterAmount; // 最小起投

@property (nonatomic, assign) HXB_Fin_Type  type; // 标的类型



@end

//
//  HXBFin_creditorChange_buy_ViewController.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class
HXBFinDetailViewModel_LoanTruansferDetail,
HXBFin_JoinimmediateView_Loan_ViewModel;
@interface HXBFin_creditorChange_buy_ViewController : HXBBaseViewController

@property (nonatomic,copy) NSString *availablePoint; // 待转让金额
@property (nonatomic,copy) NSString *placeholderStr; // 占位符
@property (nonatomic,copy) NSString *loanId; // 标的 id
@property (nonatomic,copy) NSString *cashType; // 收益方式
@property (nonatomic,copy) NSString *registerMultipleAmount; // 最小倍数
@property (nonatomic,copy) NSString *minRegisterAmount; // 最小起投
@property (nonatomic, copy) NSString *hasBindCard; //是否绑卡

@end

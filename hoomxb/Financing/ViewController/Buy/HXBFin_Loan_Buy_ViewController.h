//
//  HXBFin_Loan_Buy_ViewController.h
//  hoomxb
//
//  Created by 肖扬 on 2017/11/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@interface HXBFin_Loan_Buy_ViewController : HXBBaseViewController

@property (nonatomic,copy) NSString *availablePoint; // 待转让金额
@property (nonatomic,copy) NSString *placeholderStr; // 占位符
@property (nonatomic,copy) NSString *loanId; // 标的 id
@property (nonatomic,copy) NSString *cashType; // 收益方式
@property (nonatomic,copy) NSString *totalInterest; // 预期收益
@property (nonatomic,copy) NSString *registerMultipleAmount; // 最小倍数
@property (nonatomic,copy) NSString *minRegisterAmount; // 最小起投

@end

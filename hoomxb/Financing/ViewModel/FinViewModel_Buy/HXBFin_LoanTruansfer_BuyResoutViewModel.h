//
//  HXBFin_LoanTruansfer_BuyResoutViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBFinModel_BuyResout_LoanTruansferModel.h"
@interface HXBFin_LoanTruansfer_BuyResoutViewModel : HXBBaseViewModel
/**
 model
 */
@property (nonatomic,strong) HXBFinModel_BuyResout_LoanTruansferModel *loanTruansferModel;
/**
 投资金额
 */
@property (nonatomic,copy) NSString *buyAmount;

/**
 实际买入本金
 */
@property (nonatomic,copy) NSString * principal;
/**
 公允利息
 */
@property (nonatomic,copy) NSString * interest;
/**
 是否当期已还：
 1为已还，
 0为未还
 */
@property (nonatomic,assign) BOOL isRepayed;

/**
 下一个还款日
 */
@property (nonatomic,copy) NSString *nextRepayDate;
@end

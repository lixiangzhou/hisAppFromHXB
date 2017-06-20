//
//  HXBFinBuy_Loan_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBuy_Loan_ViewController.h"
#import "HXBJoinImmediateView.h"
#import "HXBFinDetailViewModel_LoanDetail.h"

@class HXBJoinImmediateView_Model;

@implementation HXBFinBuy_Loan_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) setUPValueWithJoinImmediateView_Model:(HXBJoinImmediateView_Model *)model {
    kWeakSelf
    ///预计收益Const
    model.profitLabel_consttStr = @"预期收益";
    ///服务协议
    model.negotiateLabelStr = @"我已阅读并同意";
    ///余额 title
    model.balanceLabel_constStr = @"可用余额";
    ///充值的button str
    model.rechargeButtonStr = @"充值";
    ///一键购买的str
    model.buyButtonStr = @"一键购买";
    ///收益方式
//    model.profitTypeLable_ConstStr = @"收益处理方式";
    ///加入上限
//    model.upperLimitLabel_constStr = @"本期计划加入上限";
    /// ￥1000起投，1000递增 placeholder
    model.rechargeViewTextField_placeholderStr = weakSelf.loanViewModel.addCondition;
    ///余额展示
    model.balanceLabelStr = weakSelf.loanViewModel.surplusAmount;
    ///服务协议 button str
    model.negotiateButtonStr = weakSelf.loanViewModel.agreementTitle;
    model.totalInterest = weakSelf.loanViewModel.totalInterestPer100;
    ///加入上线
    model.upperLimitLabelStr = weakSelf.loanViewModel.unRepaid;
    ///确认加入的Buttonstr
    model.addButtonStr = @"确认加入";
}
@end

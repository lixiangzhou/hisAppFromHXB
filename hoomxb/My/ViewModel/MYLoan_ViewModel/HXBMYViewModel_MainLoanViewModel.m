//
//  HXBMYViewModel_MainLoanViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYViewModel_MainLoanViewModel.h"
#import "HXBMyModel_MainLoanModel.h"
@implementation HXBMYViewModel_MainLoanViewModel
- (void)setLoanModel:(HXBMyModel_MainLoanModel *)loanModel {
    _loanModel = loanModel;
    self.status = _status;
}
- (void)setStatus:(NSString *)status {
    _status = status;
    if (self.status.integerValue == 1) {
        ///收益中
        _toRepayCellValue = [NSString hxb_getPerMilWithDouble:self.loanModel.toRepay.floatValue];
        //下一还款日
        _nextRepayDateCellValue = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.loanModel.nextRepayDate andDateFormat:@"MM-dd"];
        ///一换期数
        _goBackLoanTimeCellValue = [NSString stringWithFormat:@"已还期数%@/%@",self.loanModel.termsLeft,self.loanModel.termsInTotal];
        
        self.investmentAmountLable_const = @"投资金额(元)";
        self.toBeReceived_const = @"待收本息(元)";
        self.nextRepaymentDay_const = @"下一还款日";
    }else if (self.status.integerValue == 2){
        
        ///   如果是收益中（待收本息） ： 投标中（利率）
        _toRepayCellValue = [NSString stringWithFormat:@"%ld%@",self.loanModel.interest.integerValue,@"%"];
       
        //如果为收益中 （下一还款日） ： 投标中（投资进度）
        _nextRepayDateCellValue = [NSString stringWithFormat:@"%.2lf%@",self.loanModel.progress.floatValue,@"%"] ;
        
        ///如果为收益中 （已还期数） ： 投标中（期限）
        _goBackLoanTimeCellValue = [NSString stringWithFormat:@"期限  %@个月",self.loanModel.termsInTotal];
        
        self.investmentAmountLable_const = @"投资金额(元)";
        self.toBeReceived_const = @"利率";
        self.nextRepaymentDay_const = @"投资进度";
    }
}
/**
 待收本息
 */
- (NSString *) toRepay {
    if (!_toRepay) {
        _toRepay = [NSString hxb_getPerMilWithDouble:self.loanModel.toRepay.floatValue];
    }
    return _toRepay;
}

/**
 还款期数
 */
- (NSString *)goBackLoanTime  {
    if (!_goBackLoanTime) {
        _goBackLoanTime = [NSString stringWithFormat:@"已还期数%@/%@",self.loanModel.termsLeft,self.loanModel.termsInTotal];
    }
    return _goBackLoanTime;
}

/**
 下次还款日
 */
- (NSString *) nextRepayDate {
    if (!_nextRepayDate) {
        _nextRepayDate = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.loanModel.nextRepayDate andDateFormat:@"MM-dd"];
    }
    return _nextRepayDate;
}

/**
 月收本息(元)
 */
- (NSString *) monthlyRepay {
    if (!_monthlyRepay) {
        _monthlyRepay = [NSString hxb_getPerMilWithDouble:self.loanModel.monthlyRepay.floatValue];
    }
    return _monthlyRepay;
}
/**
 投资金额
 */

- (NSString *) amount {
    if (!_amount) {
        _amount = [NSString hxb_getPerMilWithDouble:self.loanModel.amount.floatValue];
    }
    return _amount;
}

/**
 利率
 */
- (NSString *) interest {
    if (!_interest) {
        _interest = [NSString stringWithFormat:@"%.2lf%@",self.loanModel.interest.floatValue,@"%"];
    }
    return _interest;
}

/**
 期限
 */

- (NSString *) termsInTotal {
    if (!_termsInTotal) {
        _termsInTotal = self.loanModel.termsInTotal;
    }
    return _termsInTotal;
}

/**
 还款方式
 */
- (NSString *) loanType {
    if (!_loanType) {
//        HXBRequestType_MY_LoanRequestType type = [HXBEnumerateTransitionManager myLoan_RequestTypeStr:self.loanModel.loanType];
//        [HXBEnumerateTransitionManager myLoan_requestType:type andReturnParamBlock:^(NSString *type, NSString *UI_Type) {
//            _loanType = UI_Type;
//        }];
        _loanType = @"等额本息";
    }
    return _loanType;
}
/**
 已收本息
 */
- (NSString *) repaid {
    if (!_repaid) {
        _repaid = [NSString hxb_getPerMilWithDouble:self.loanModel.repaid.floatValue];
    }
    return _repaid;
}
/**
 请求
 */
- (HXBRequestType_MY_LoanRequestType) requestType {
    if (!_requestType) {
        _requestType = [HXBEnumerateTransitionManager myLoan_RequestTypeStr:self.loanModel.loanType];
    }
    return _requestType;
}
@end

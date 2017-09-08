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
        ///剩余期数
        NSInteger terms = [self.loanModel.termsLeft integerValue];
        NSInteger termsInTotal = [self.loanModel.termsInTotal integerValue];
        _goBackLoanTimeCellValue = [NSString stringWithFormat:@"剩余期数%ld/%ld",(long)terms,(long)termsInTotal];
        
        self.investmentAmountLable_const = @"投资金额(元)";
        self.toBeReceived_const = @"待收本息(元)";
        self.nextRepaymentDay_const = @"下一还款日";
    }else if (self.status.integerValue == 2){
        
        ///   如果是收益中（待收本息） ： 投标中（利率）
        _toRepayCellValue = [NSString stringWithFormat:@"%.2lf%@",self.loanModel.interest.floatValue,@"%"];
       
        //如果为收益中 （下一还款日） ： 投标中（投资进度）
        _nextRepayDateCellValue = [NSString stringWithFormat:@"%.0lf%@",self.loanModel.progress.floatValue,@"%"] ;
        
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
        _nextRepayDate = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.loanModel.nextRepayDate andDateFormat:@"YYYY-MM-dd"];
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
        _interest = [NSString stringWithFormat:@"%.1lf%@",self.loanModel.interest.floatValue,@"%"];
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
        _loanType = @"按月等额本息";
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
/**
 amount_NOTYUAN
 */
- (NSString *) amount_NOTYUAN {
    if (!_amount_NOTYUAN) {
        _amount_NOTYUAN = [NSString GetPerMilWithDouble:self.loanModel.amount.floatValue];
    }
    return _amount_NOTYUAN;
}
/**
 加入金额
 */

- (NSString *) finalAmount_NOTYUAN {
    if (!_finalAmount_NOTYUAN) {
        _finalAmount_NOTYUAN = [NSString GetPerMilWithDouble:self.loanModel.transferable.floatValue];
    }
    return _finalAmount_NOTYUAN;
}
/**
 已获收益
 */
- (NSString *) earnAmount_NOTYUAN {
    if (!_earnAmount_NOTYUAN) {
        _earnAmount_NOTYUAN = [NSString GetPerMilWithDouble:self.loanModel.repaid.floatValue];
    }
    return _earnAmount_NOTYUAN;
}

- (NSString *)loanTitle {
    if (!_loanTitle) {
        _loanTitle = self.loanModel.loanTitle;
    }
    return _loanTitle;
}


/**
 剩余期数: 4/12(收益中使用)
 */
- (NSString *)title_RemainTime {
    if (!_title_RemainTime) {
        _title_RemainTime = [NSString stringWithFormat:@"剩余期数:%@/%@",self.loanModel.termsLeft,self.loanModel.termsInTotal];
    }
    return _title_RemainTime;
}
/**
 期限：12个月（投标中用）
 */
- (NSString *) title_TermsInTotal_YUE {
    if (!_title_TermsInTotal_YUE) {
        _title_TermsInTotal_YUE = [NSString stringWithFormat:@"期限:%@个月",self.loanModel.termsInTotal];
    }
    return _title_TermsInTotal_YUE;
}
/**
 （债权匹配中 || 2017-08-01退出） 债转中使用
 */
- (NSString *) title_Truansfer {
    if (!_title_Truansfer) {
        _title_Truansfer = [NSString stringWithFormat:@"  "];
    }
    return _title_Truansfer;
}
- (NSString *)progress
{
    if (self.loanModel.progress.doubleValue>0 && self.loanModel.progress.doubleValue < 1) {
        _progress = @"1%";
    }else if(self.loanModel.progress.doubleValue > 99 && self.loanModel.progress.doubleValue < 100)
    {
        _progress = @"99%";
    }else
    {
        _progress = [NSString stringWithFormat:@"%1.f%%",self.loanModel.progress.doubleValue];
    }
    return _progress;
}

@end

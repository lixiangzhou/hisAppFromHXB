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
    self.responsType = [HXBEnumerateTransitionManager myLoan_ResponsType:loanModel.loanType];
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

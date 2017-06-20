//
//  HXBFinDetailViewModel_LoanDetail.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailViewModel_LoanDetail.h"
#import "HXBFinDatailModel_LoanDetail.h"
@implementation HXBFinDetailViewModel_LoanDetail
- (void)setLoanDetailModel:(HXBFinDatailModel_LoanDetail *)loanDetailModel {
    _loanDetailModel = loanDetailModel;
    [self setUP_totalInterestPer100];

    [self setUP_leftMonths];
}

///预期年利率
- (void)setUP_totalInterestPer100 {
   
    
    
}

///左边的月数
- (void)setUP_leftMonths {
    self.leftMonths = [NSString stringWithFormat:@"%@个月",self.loanDetailModel.loanVo.leftMonths];
}


/**
剩余可投金额
 */
- (NSString *) surplusAmount {
    if (!_surplusAmount) {
        _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.surplusAmount.floatValue];
    }
    return _surplusAmount;
}

/**
左边的月数
 */
- (NSString *) leftMonths {
    if (!_leftMonths) {
        _leftMonths =[NSString stringWithFormat:@"%@个月",self.loanDetailModel.loanVo.leftMonths];
    }
    return _leftMonths;
}


/**
收益方法
 */
- (NSString *) loanType{
    if (!_loanType) {
//        _loanType = _loanType
    }
    return _loanType;
}

/**
￥1000起投，1000递增 placeholder
 */
- (NSString *) addCondition {
    if (!_addCondition) {
        _addCondition = [NSString stringWithFormat:@"￥ %@元起投，%@递增",self.loanDetailModel.minInverst,self.loanDetailModel.minInverst];
    }
    return _addCondition;
}

/**
 预计收益 比例
 */
- (NSString *) totalInterestPer100 {
    if (!_totalInterestPer100) {
        _totalInterestPer100 = [NSString GetPerMilWithDouble:self.loanDetailModel.loanVo.interest.floatValue];
    }
    return _totalInterestPer100;
}


/**
 服务协议 button str
 */
- (NSString *) agreementTitle {
    if (!_agreementTitle) {
        _agreementTitle = [NSString stringWithFormat:@"《%@》",self.loanDetailModel.agreementTitle];
    }
    return _agreementTitle;
}

@end

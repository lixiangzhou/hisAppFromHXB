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
    [self setUP_surplusAmount];
    [self setUP_leftMonths];
}

///预期年利率
- (void)setUP_totalInterestPer100 {
    self.totalInterestPer100 = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.totalInterestPer100.floatValue];
    
    
}
///string	剩余可投金额
- (void)setUP_surplusAmount {
    self.surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.surplusAmount.floatValue];
}
///左边的月数
- (void)setUP_leftMonths {
    self.leftMonths = [NSString stringWithFormat:@"%@个月",self.loanDetailModel.loanVo.leftMonths];
}
@end

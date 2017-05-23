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
    self.responsType = [HXBRequestType_MYManager myLoan_ResponsType:loanModel.loanType];
}
@end

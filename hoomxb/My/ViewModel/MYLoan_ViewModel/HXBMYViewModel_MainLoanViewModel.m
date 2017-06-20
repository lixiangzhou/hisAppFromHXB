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
    self.responsType = [HXBMYViewModel_MainLoanViewModel myLoan_ResponsType:loanModel.loanType];
}





#pragma mark -  loan 界面
/// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan界面
+ (HXBRequestType_MY_LoanRequestType)myLoan_RequestTypeStr: (NSString *)typeStr {
    if ([typeStr isEqualToString:HXBRequestType_MY_FINISH_LOAN]) return HXBRequestType_MY_LoanRequestType_FINISH_LOAN;
    if ([typeStr isEqualToString:HXBRequestType_MY_BID_LOAN]) return HXBRequestType_MY_LoanRequestType_BID_LOAN;
    if ([typeStr isEqualToString:HXBRequestType_MY_REPAYING_LOAN]) return HXBRequestType_MY_LoanRequestType_REPAYING_LOAN;
    NSLog(@"%@， - 我的Loan主界面 -- 对应的相应参数字符串 输入错误，",self.class);
    return LONG_MAX;
}

+ (HXBRequestType_MY_LoanResponsType)myLoan_ResponsType: (NSString *)responsType {
    if ([responsType isEqualToString:HXBRequestType_MY_XYRZ_Loan]) return HXBRequestType_MY_LoanResponsType_XYRZ;
    if ([responsType isEqualToString:HXBRequestType_MY_SDRZ_Loan]) return HXBRequestType_MY_LoanResponsType_SDRZ;
    NSLog(@"%@ - 我的loan 列表 -- 转化 收益和 等待计息失败",self.class);
    return LONG_MAX;
}

/// 根据枚举值返回对应的请求参数字符串 ———— 我的Loan主界面
+ (void)myLoan_requestType: (HXBRequestType_MY_LoanRequestType)type andReturnParamBlock: (void(^)(NSString *type, NSString *UI_Type))returnParamBlock{
    switch (type) {
        case HXBRequestType_MY_LoanRequestType_REPAYING_LOAN:
            returnParamBlock(HXBRequestType_MY_REPAYING_LOAN,HXBRequestType_MY_REPAYING_LOAN_UI);
            break;
        case HXBRequestType_MY_LoanRequestType_FINISH_LOAN:
            returnParamBlock(HXBRequestType_MY_FINISH_LOAN,HXBRequestType_MY_FINISH_LOAN_UI);
            break;
        case HXBRequestType_MY_LoanRequestType_BID_LOAN:
            returnParamBlock(HXBRequestType_MY_BID_LOAN,HXBRequestType_MY_BID_LOAN_UI);
            break;
    }
}
@end

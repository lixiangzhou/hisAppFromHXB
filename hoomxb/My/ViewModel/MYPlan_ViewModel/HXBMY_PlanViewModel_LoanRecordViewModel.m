//
//  HXBMY_PlanViewModel_LoanRecordViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanViewModel_LoanRecordViewModel.h"

@implementation HXBMY_PlanViewModel_LoanRecordViewModel

/**
 投资金额
 */

- (NSString *) amount {
    if (!_amount) {
        _amount = [NSString GetPerMilWithDouble:self.planLoanRecordModel.amount.floatValue];
    }
    return _amount;
}

/**
 投资时间
 */
- (NSString *) lendTime {
    if (!_lendTime) {
        _lendTime = [[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.planLoanRecordModel.lendTime andDateFormat:@"yyyy-MM-dd"];
    }
    return _lendTime;
}

/**
 散标id
 */
- (NSString *) loanId {
    if (!_loanId) {
        _loanId = self.planLoanRecordModel.loanId;
    }
    return _loanId;
}

/**
 状态
 */
- (NSString *) status {
    if (!_status) {
        ///String	投标中
        NSString *str = self.planLoanRecordModel.status;
        if ( [self.planLoanRecordModel.status isEqualToString:@"OPEN"]){
            _status = @"立即投标";
        }
        ///	String	已满标
        if ([str isEqualToString:@"READY"]){
            _status = @"已满标";
            
        }
        ///	String	已流标
        if ([str isEqualToString:@"FAILED"]){
            _status = @"立即投标";

        }
        ///	String	收益中
        if ([str isEqualToString:@"IN_PROGRESS"]){
            _status = @"收益中";
        }
        ///	String	逾期
        if ([str isEqualToString:@"OVER_DUE"]){
            _status = @"逾期";

            
        }
        ///	String	坏账
        if ([str isEqualToString:@"BAD_DEBT"]){
            _status = @"坏账";
        }
        
        ///	String	已结清
        if ([str isEqualToString:@"CLOSED"]){
            _status = @"已结清";
        }
        
        ///	String	新申请
        if ([str isEqualToString:@"FIRST_APPLY"]){
            _status = @"立即投标";
        }
        
        ///	String	已满标
        if ([str isEqualToString:@"FIRST_READY"]){
            _status = @"已满标";
        }
        
        ///	String	预售
        if ([str isEqualToString:@"PRE_SALES"]){
            _status = @"立即投标";
        }
        
        ///	String	等待招标
        if ([str isEqualToString:@"WAIT_OPEN"]){
            _status = @"立即投标";
        }
        
        ///	String	放款中
        if ([str isEqualToString:@"FANGBIAO_PROCESSING"]){
            _status = @"立即投标";
        }
        
        ///	String	流标中
        if ([str isEqualToString:@"LIUBIAO_PROCESSING"]){
            _status = @"立即投标";
        }
    }
    return _status;
}

@end

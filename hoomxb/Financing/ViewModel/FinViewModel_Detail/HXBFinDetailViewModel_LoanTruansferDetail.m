//
//  HXBFinDetailViewModel_LoanTruansferDetail.m
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailViewModel_LoanTruansferDetail.h"

@implementation HXBFinDetailViewModel_LoanTruansferDetail

- (void)setLoanTruansferDetailModel:(HXBFinDetailModel_LoanTruansferDetail *)loanTruansferDetailModel {
    _loanTruansferDetailModel = loanTruansferDetailModel;
    [self status];
}
- (NSString *)status {
    if (!_status) {
        [self setUPAddButtonColorWithType:true];
        if ([self.loanTruansferDetailModel.transferDetail.status isEqualToString:@"TRANSFERING"]) {
            _status = @"转让中";
            [self setUPAddButtonColorWithType:false];
        }
        if ([self.loanTruansferDetailModel.transferDetail.status isEqualToString:@"TRANSFERED"]) {
            _status = @"转让完毕";
        }
        if ([self.loanTruansferDetailModel.transferDetail.status isEqualToString:@"CANCLE"]) {
            _status = @"已取消";
        }
        if ([self.loanTruansferDetailModel.transferDetail.status isEqualToString:@"CLOSED_CANCLE"]) {
            _status = @"结标取消";
        }
        if ([self.loanTruansferDetailModel.transferDetail.status isEqualToString:@"OVERDUE_CANCLE"]) {
            _status = @"逾期取消";
        }
        if ([self.loanTruansferDetailModel.transferDetail.status isEqualToString:@"PRESALE"]) {
            _status = @"转让预售";
        }
    }
    return _status;
}
- (void)setUPAddButtonColorWithType:(BOOL) isSelected {
    if (isSelected) {
        ///设置addbutton的颜色
        self.isUserInteractionEnabled = false;
        self.addButtonTitleColor = kHXBColor_Grey_Font0_2;
        self.addButtonBackgroundColor = kHXBColor_Font0_6;
        self.addButtonBorderColor = kHXBColor_Grey_Font0_2;
        return;
    }
    self.isUserInteractionEnabled = true;
    self.addButtonTitleColor = [UIColor whiteColor];
    self.addButtonBackgroundColor = kHXBColor_Red_090303;
    self.addButtonBorderColor = kHXBColor_Red_090303;
}
/**
 1000 起投 1000递增
 */
- (NSString *)startIncrease_Amount {
    if (!_startIncrease_Amount) {
        _startIncrease_Amount = [NSString stringWithFormat:@"%.0lf起投%.0lf递增",self.loanTruansferDetailModel.minInverst.floatValue,self.loanTruansferDetailModel.loanVo.finishedRatio.floatValue];
    }
    return _startIncrease_Amount;
}
/**
 状态
 */
- (NSString *) status_UI {
    if (!_status_UI) {
        _status_UI = [HXBEnumerateTransitionManager Fin_LoanTruansfer_StatusWith_request:self.status];
    }
    return _status_UI;
}


/**
 剩余期数
 */
- (NSString *) leftMonths {
    if (!_leftMonths) {
        _leftMonths = [NSString stringWithFormat:@"%@个月",self.loanTruansferDetailModel.loanVo.leftMonths];
    }
    return _leftMonths;
}
/**
 贷款期数
 */
- (NSString *) loanMonths {
    if (!_loanMonths) {
        _loanMonths = [NSString stringWithFormat:@"%@个月",self.loanTruansferDetailModel.loanMonths];
    }
    return _loanMonths;
}
/**
 初始转让金额
 */
- (NSString *) creatTransAmount {
    if (!_creatTransAmount) {
        _creatTransAmount = [NSString hxb_getPerMilWithDouble:self.loanTruansferDetailModel.transferDetail.creatTransAmount.floatValue];
    }
    return _creatTransAmount;
}
/**
 剩余金额
 */
- (NSString *) leftTransAmount {
    if (!_leftTransAmount) {
        _leftTransAmount = [NSString hxb_getPerMilWithDouble:self.loanTruansferDetailModel.transferDetail.leftTransAmount.floatValue];
    }
    return _leftTransAmount;
}
/**
 借款协议
 */
- (NSString *) agreementTitle {
    if (!_agreementTitle) {
        _agreementTitle = [NSString stringWithFormat:@"《%@》",self.loanTruansferDetailModel.agreementTitle];
    }
    return _agreementTitle;
}
/**
 借款协议
 */
- (NSString *) agreementURL {
    if (!_agreementURL) {
        _agreementURL = kHXB_Negotiate_LoanTruansferURL;
    }
    return _agreementURL;
}
/**
 是否可以点击确认加入
 */
- (BOOL) isAddButtonEditing {
    if (!_isAddButtonEditing) {
        _isAddButtonEditing = true;
    }
    return _isAddButtonEditing;
}

- (NSString *) repaymentType {
    if (!_repaymentType) {
        _repaymentType = self.loanTruansferDetailModel.loanVo.repaymentType;
    }
    return _repaymentType;
}

- (NSString *)nextRepayDate {
    if (!_nextRepayDate) {
        NSDate *nextDate = [[HXBBaseHandDate sharedHandleDate] returnDateWithOBJ:self.loanTruansferDetailModel.loanVo.nextRepayDate andDateFormatter:@"yyyy-MM-dd"];
        _nextRepayDate = [[HXBBaseHandDate sharedHandleDate] stringFromDate:nextDate andDateFormat:@"MM-dd"];
    }
    return _nextRepayDate;
}

@end

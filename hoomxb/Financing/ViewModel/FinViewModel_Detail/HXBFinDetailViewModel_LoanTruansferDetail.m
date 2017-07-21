//
//  HXBFinDetailViewModel_LoanTruansferDetail.m
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailViewModel_LoanTruansferDetail.h"

@implementation HXBFinDetailViewModel_LoanTruansferDetail

/**
 1000 起投 1000递增
 */
- (NSString *)startIncrease_Amount {
    if (!_startIncrease_Amount) {
        _startIncrease_Amount = [NSString stringWithFormat:@"%@起投%@递增",self.loanTruansferDetailModel.creatTransAmount,self.loanTruansferDetailModel.loanVo.finishedRatio];
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
 状态
 */
- (NSString *) status {
    if (!_status) {
        _status = self.loanTruansferDetailModel.status;
    }
    return _status;
}

/**
 剩余期数
 */
- (NSString *) leftMonths {
    if (!_leftMonths) {
        _leftMonths = [NSString stringWithFormat:@"%@个月",self.loanTruansferDetailModel.leftMonths];
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
@end

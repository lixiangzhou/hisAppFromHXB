//
//  HXBMY_LoanTruansferViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/8/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_LoanTruansferViewModel.h"
@implementation HXBMY_LoanTruansferViewModel
/**
 @"剩余期限(月)"
 */
- (NSString *) remainMonthStr {
    if (!_remainMonthStr) {
        _remainMonthStr = [NSString stringWithFormat:@"%@个月",self.my_truanfserModel.leftMonths];
    }
    return _remainMonthStr;
}
/**
 @"年利率"
 */
- (NSString *) interest {
    if (!_interest) {
        _interest = [NSString stringWithFormat:@"%@%@",self.my_truanfserModel.interest,@"%"];
    }
    return _interest;
}

/**
 状态
 */
- (NSString *) status_UI {
    if (!_status_UI) {
        _status_UI = [HXBEnumerateTransitionManager Fin_LoanTruansfer_StatusWith_request:self.my_truanfserModel.status];
    }
    return _status_UI;
}

/**
 待转金额
 */
- (NSString *) amountTransferStr {
    if (!_amountTransferStr) {
        _amountTransferStr = [NSString GetPerMilWithDouble:self.my_truanfserModel.leftTransAmount.floatValue];
    }
    return _amountTransferStr;
}


/**
 消费借款
 */
- (NSString *)loanTitle {
    if (!_loanTitle) {
        _loanTitle = self.my_truanfserModel.title;
    }
    return _loanTitle;
}

/// 加入按钮的颜色
- (UIColor *)addButtonBackgroundColor {
    if (!_addButtonTitleColor) {
        _addButtonTitleColor = [UIColor redColor];
    }
    return _addButtonTitleColor;
}
///加入按钮的字体颜色
- (UIColor *)addButtonTitleColor {
    if (!_addButtonTitleColor) {
        _addButtonTitleColor = [UIColor blackColor];
    }
    return _addButtonTitleColor;
}
///addbutton 边缘的颜色
- (UIColor *)addButtonBorderColor {
    if (!_addButtonBorderColor) {
        _addButtonBorderColor = [UIColor redColor];
    }
    return _addButtonBorderColor;
}

@end

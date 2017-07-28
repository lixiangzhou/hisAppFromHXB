//
//  HXBFinHomePageViewModel_LoanTruansferViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"

@implementation HXBFinHomePageViewModel_LoanTruansferViewModel

- (void)setLoanTruansferListModel:(HXBFinHomePageModel_LoanTruansferList *)loanTruansferListModel {
    _loanTruansferListModel = loanTruansferListModel;
    [self status];
}
/**
 transferId	int	转让id
 */
- (NSString *) transferId {
    return  self.loanTruansferListModel.transferId;
}
/**
 借款标题
 */
- (NSString *) title {
    return  self.loanTruansferListModel.title;
}

/**
 利率
 */
- (NSString *) interest {
    if (!_interest) {
        _interest = [NSString stringWithFormat:@"%.2lf%@",self.loanTruansferListModel.interest.floatValue,@"%"];
    }
    return _interest;
}
/**
 利率
 */
- (NSAttributedString *) interestAttibute {
    if (!_interestAttibute) {
        NSString *interestStr = [NSString stringWithFormat:@"%.2lf%@",self.loanTruansferListModel.interest.floatValue,@"%"];
        NSRange range = NSMakeRange(interestStr.length - 1, 1);
        _interestAttibute = [NSAttributedString setupAttributeStringWithString:interestStr WithRange:range andAttributeColor:[UIColor whiteColor] andAttributeFont:kHXBFont_PINGFANGSC_REGULAR(20)];
        
    }
    return _interestAttibute;
}
/**
 剩余期数 (包含  汉字 个月)
 */
- (NSString *)leftMonths {
    if (!_leftMonths) {
        _leftMonths = [NSString stringWithFormat:@"%ld个月",self.loanTruansferListModel.leftMonths.integerValue];
    }
    return _leftMonths;
}
/**
 借款期数
 */
- (NSString *)loanMonths {
    if (!_loanMonths) {
        _loanMonths = [NSString stringWithFormat:@"%ld个月",self.loanTruansferListModel.loanMonths.integerValue];
    }
    return _loanMonths;
}
/**
 初始转让金额
 */
- (NSString *) transAmount {
    if (!_transAmount) {
        _transAmount = [NSString hxb_getPerMilWithDouble:self.loanTruansferListModel.transAmount.floatValue];
    }
    return _transAmount;
}
/**
转让金额
 */
- (NSString *) leftTransAmount {
    if (!_leftTransAmount) {
        _leftTransAmount = [NSString hxb_getPerMilWithDouble:self.loanTruansferListModel.leftTransAmount.floatValue];
    }
    return _leftTransAmount;
}
/**
剩余金额 (元)
 */
- (NSString *) leftTransAmount_YUAN {
    if (!_leftTransAmount_YUAN) {
         _leftTransAmount_YUAN = [NSString stringWithFormat:@"待转让金额：%@",self.leftTransAmount];
    }
    return _leftTransAmount_YUAN;
}
/**
 状态
 TRANSFERING：正在转让，
 TRANSFERED：转让完毕，
 CANCLE：已取消，
 CLOSED_CANCLE：结标取消，
 OVERDUE_CANCLE：逾期取消，
 PRESALE：转让预售
 */
- (NSString *) status {
    if (!_status) {
        [self setUPAddButtonColorWithType:true];
        if ([self.loanTruansferListModel.status isEqualToString:@"TRANSFERING"]) {
            _status = @"转让中";
            [self setUPAddButtonColorWithType:false];
        }
        if ([self.loanTruansferListModel.status isEqualToString:@"TRANSFERED"]) {
            _status = @"转让完毕";
        }
        if ([self.loanTruansferListModel.status isEqualToString:@"CANCLE"]) {
            _status = @"已取消";
        }
        if ([self.loanTruansferListModel.status isEqualToString:@"CLOSED_CANCLE"]) {
            _status = @"结标取消";
        }
        if ([self.loanTruansferListModel.status isEqualToString:@"OVERDUE_CANCLE"]) {
            _status = @"逾期取消";
        }
        if ([self.loanTruansferListModel.status isEqualToString:@"PRESALE"]) {
            _status = @"转让预售";
        }
    }
    return _status;
}
- (void)setUPAddButtonColorWithType:(BOOL) isSelected {
    if (isSelected) {
        self.addButtonTitleColor = kHXBColor_Font0_6;
        self.addButtonBackgroundColor = kHXBColor_Grey090909;
        self.addButtonBorderColor = kHXBColor_Font0_6;
        return;
    }
    self.addButtonTitleColor = [UIColor whiteColor];
    self.addButtonBackgroundColor = kHXBColor_Red_090303;
    self.addButtonBorderColor = kHXBColor_Red_090303;
    
}
@end

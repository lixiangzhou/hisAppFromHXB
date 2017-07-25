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
    [self status];
    [self setUP_leftMonths];
}

- (BOOL)isAddButtonEndEditing {
    return true;
}

/**
 剩余期限
 */
//- (NSString *) loanPeriodStr {
//    if (!_loanPeriodStr) {
//        _loanPeriodStr = [NSString stringWithFormat:@"%@%@",self.loanDetailModel]
//    }
//    return <#obj#>
//}
/**
 标的状态
 */
- (NSString *) status {
    if (!_status) {
        NSString *status = self.loanDetailModel.loanVo.status;
        ///String	投标中
        [self setUPAddButtonColorWithType:true];
        if ( [status isEqualToString:@"OPEN"]){
            self.addButtonStr = @"立即投标";
            [self setUPAddButtonColorWithType:false];
             _surplusAmount_ConstStr = @"剩余金额";
            _isAddButtonEditing = true;
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.surplusAmount.floatValue];
        }
        ///	String	已满标
        if ([status isEqualToString:@"READY"]){
            self.addButtonStr = @"已满标";
            _surplusAmount_ConstStr = @"标的总金额";
            _isAddButtonEditing = false;
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
            
        }
        ///	String	已流标
        if ([status isEqualToString:@"FAILED"]){
            self.addButtonStr = @"立即投标";
            _isAddButtonEditing = false;
        }
        ///	String	收益中
        if ([status isEqualToString:@"IN_PROGRESS"]){
            self.addButtonStr = @"收益中";
            _isAddButtonEditing = false;
            _surplusAmount_ConstStr = @"标的总金额";
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        ///	String	逾期
        if ([status isEqualToString:@"OVER_DUE"]){
            self.addButtonStr = @"逾期";
            _isAddButtonEditing = false;
            _surplusAmount_ConstStr = @"标的总金额";
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
            
        }
        ///	String	坏账
        if ([status isEqualToString:@"BAD_DEBT"]){
            self.addButtonStr = @"坏账";
            _surplusAmount_ConstStr = @"标的总金额";
             _isAddButtonEditing = false;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	已结清
        if ([status isEqualToString:@"CLOSED"]){
            self.addButtonStr = @"已结清";
            _surplusAmount_ConstStr = @"标的总金额";
             _isAddButtonEditing = false;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	新申请
        if ([status isEqualToString:@"FIRST_APPLY"]){
            self.addButtonStr = @"立即投标";
            _surplusAmount_ConstStr = @"标的总金额";
             _isAddButtonEditing = false;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	已满标
        if ([status isEqualToString:@"FIRST_READY"]){
            self.addButtonStr = @"已满标";
            _surplusAmount_ConstStr = @"标的总金额";
             _isAddButtonEditing = false;
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	预售
        if ([status isEqualToString:@"PRE_SALES"]){
            self.addButtonStr = @"立即投标";
            _surplusAmount_ConstStr = @"标的总金额";
            _isAddButtonEditing = true;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	等待招标
        if ([status isEqualToString:@"WAIT_OPEN"]){
            self.addButtonStr = @"立即投标";
            _surplusAmount_ConstStr = @"标的总金额";
            _isAddButtonEditing = true;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	放款中
        if ([status isEqualToString:@"FANGBIAO_PROCESSING"]){
            self.addButtonStr = @"立即投标";
            _surplusAmount_ConstStr = @"标的总金额";
            _isAddButtonEditing = true;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	流标中
        if ([status isEqualToString:@"LIUBIAO_PROCESSING"]){
            self.addButtonStr = @"立即投标";
            _surplusAmount_ConstStr = @"标的总金额";
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }

    }
    return _status;
}

- (void)setUPAddButtonColorWithType:(BOOL) isSelected {
    if (isSelected) {
        ///设置addbutton的颜色
        self.isAddButtonEditing = false;
        self.addButtonTitleColor = kHXBColor_Grey_Font0_2;
        self.addButtonBackgroundColor = kHXBColor_Font0_6;
        self.addButtonBorderColor = kHXBColor_Grey_Font0_2;
        return;
    }
    self.isAddButtonEditing = true;
    self.addButtonTitleColor = [UIColor whiteColor];
    self.addButtonBackgroundColor = kHXBColor_Red_090303;
    self.addButtonBorderColor = kHXBColor_Red_090303;
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
        if (self.loanDetailModel.loanVo.surplusAmount.floatValue <= 0) {
            _surplusAmount_ConstStr = @"标的总金额";
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }else {
            [self status];
        }    
    }
    return _surplusAmount;
}
/**
 剩余可投 字符
 */
- (NSString *) surplusAmount_ConstStr {
    if (!_surplusAmount_ConstStr) {
        if (self.loanDetailModel.loanVo.surplusAmount.floatValue <= 0) {
            _surplusAmount_ConstStr = @"标的总金额";
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }else {
            [self status];
        }
    }
    return _surplusAmount_ConstStr;
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
        _addCondition = [NSString stringWithFormat:@"%@起投，%@递增",self.loanDetailModel.minInverst,self.loanDetailModel.minInverst];
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
/**
 服务协议 button str
 */
- (NSString *) agreementURL {
    if (!_agreementURL) {
        _agreementURL = kHXB_Negotiate_ServeLoanURL;
    }
    return _agreementURL;
}
- (NSString *)remainTime {
    if (!_remainTime) {
        _remainTime  = self.loanDetailModel.remainTime;
    }
    return _remainTime;
}
@end

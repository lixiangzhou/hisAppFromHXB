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
//    [self setUP_totalInterestPer100];
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
//    return obj
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
            
            _isAddButtonEditing = true;
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.surplusAmount.floatValue];
        }
        ///	String	已满标
        if ([status isEqualToString:@"READY"]){
            self.addButtonStr = @"已满标";
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
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        ///	String	逾期
        if ([status isEqualToString:@"OVER_DUE"]){
            self.addButtonStr = @"逾期";
            _isAddButtonEditing = false;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
            
        }
        ///	String	坏账
        if ([status isEqualToString:@"BAD_DEBT"]){
            self.addButtonStr = @"坏账";
             _isAddButtonEditing = false;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	已结清
        if ([status isEqualToString:@"CLOSED"]){
            self.addButtonStr = @"已结清";
             _isAddButtonEditing = false;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	新申请
        if ([status isEqualToString:@"FIRST_APPLY"]){
            self.addButtonStr = @"立即投标";
             _isAddButtonEditing = false;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	已满标
        if ([status isEqualToString:@"FIRST_READY"]){
            self.addButtonStr = @"已满标";
             _isAddButtonEditing = false;
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	预售
        if ([status isEqualToString:@"PRE_SALES"]){
            self.addButtonStr = @"立即投标";
            _isAddButtonEditing = true;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	等待招标
        if ([status isEqualToString:@"WAIT_OPEN"]){
            self.addButtonStr = @"立即投标";
            _isAddButtonEditing = true;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	放款中
        if ([status isEqualToString:@"FANGBIAO_PROCESSING"]){
            self.addButtonStr = @"立即投标";
            _isAddButtonEditing = true;
              _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }
        
        ///	String	流标中
        if ([status isEqualToString:@"LIUBIAO_PROCESSING"]){
            self.addButtonStr = @"立即投标";
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
//- (void)setUP_totalInterestPer100 {
//
//}

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
            _surplusAmount_ConstStr = @"标的金额";
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }else {
            _surplusAmount_ConstStr = @"剩余可投";
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
            _surplusAmount_ConstStr = @"标的金额";
            _surplusAmount = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.loanVo.amount.floatValue];
        }else {
            _surplusAmount_ConstStr = @"剩余可投";
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
 标的期限
 */
- (NSString *) months {
    if (!_months) {
        _months =[NSString stringWithFormat:@"%@个月",self.loanDetailModel.loanVo.months];
    }
    return _months;
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

/**
婚姻状态
 */
- (NSString *) marriageStatus {
    if (!_marriageStatus) {
        if ([self.loanDetailModel.userVo.marriageStatus isEqualToString:@"MARRIED"]) {
            
            _marriageStatus = @"已婚";
            
        }else if ([self.loanDetailModel.userVo.marriageStatus isEqualToString:@"UNMARRIED"]){
            
            _marriageStatus = @"未婚";
            
        }else if ([self.loanDetailModel.userVo.marriageStatus isEqualToString:@"DIVORCED"]){
            
            _marriageStatus = @"离异";
            
        }else if ([self.loanDetailModel.userVo.marriageStatus isEqualToString:@"WIDOWED"]){
            
            _marriageStatus = @"丧偶";
        }
    }
    return _marriageStatus;
}

/**
 年龄
 */
- (NSString *)age {
    if (!_age) {
        _age = [NSString stringWithFormat:@"年龄 %@岁",self.loanDetailModel.idCardInfo.age];
    }
    return _age;
}
/**
 名字
 */
- (NSString *) name {
    if (!_name) {
        _name = [self.loanDetailModel.idCardInfo.name replaceStringWithStartLocation:0 lenght:self.loanDetailModel.idCardInfo.name.length - 1];
    }
    return _name;
}
/**
 月收入
 */
- (NSString *) monthlyIncome {
    if (!_monthlyIncome) {
        _monthlyIncome = [NSString hxb_getPerMilWithDouble:self.loanDetailModel.userVo.monthlyIncome.floatValue];
    }
    return _monthlyIncome;
}
/**
 是否有房产
 */
- (NSString *) hasHouse {
    if (!_hasHouse) {
        if (self.loanDetailModel.userVo.hasHouse.integerValue) {
            _hasHouse = @"房产 有房产";
        }else
        {
            _hasHouse = @"房产 无房产";
        }
    }
    return _hasHouse;
}
/**
 是否有房贷
 */
- (NSString *) hasHouseLoan {
    if (!_hasHouseLoan) {
        if (self.loanDetailModel.userVo.hasHouseLoan.integerValue) {
            _hasHouseLoan = @"房贷 有房贷";
        }else
        {
            _hasHouseLoan = @"房贷 无房贷";
        }
    }
    return _hasHouseLoan;
}
/**
 是否有 车贷
 */
- (NSString *) hasCar {
    if (!_hasCar) {
        if (self.loanDetailModel.userVo.hasCar.integerValue) {
            
             _hasCar = @"车产 有车产";
        }else
        {
             _hasCar = @"车产 无车产";
        }
    }
    return _hasCar;
}
/**
 是否有 车贷
 */
- (NSString *) hasCarLoan {
    if (!_hasCarLoan) {
        if (self.loanDetailModel.userVo.hasCarLoan.integerValue) {
            _hasCarLoan = @"车贷 有车贷";
        }else
        {
            _hasCarLoan = @"车贷 无车贷";
        }
    }
    return _hasCarLoan;
}
/**
 身份证号
 */
- (NSString *) idNo {
    if (!_idNo) {
        _idNo = [self.loanDetailModel.idCardInfo.idNo replaceStringWithStartLocation:3 lenght:self.loanDetailModel.idCardInfo.idNo.length - 4];
    }
    return _idNo;
}
@end

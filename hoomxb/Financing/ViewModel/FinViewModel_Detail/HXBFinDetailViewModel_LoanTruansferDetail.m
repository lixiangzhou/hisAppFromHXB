//
//  HXBFinDetailViewModel_LoanTruansferDetail.m
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetailViewModel_LoanTruansferDetail.h"
#import "HXBFin_Detail_DetailVC_Loan.h"

@interface HXBFinDetailViewModel_LoanTruansferDetail ()
// MARK ----- 标的详情-- 详情
/**
 身份证号
 */
@property (nonatomic,copy) NSString *idNo;
/**
 名字
 */
@property (nonatomic,copy) NSString * name;
/**
 婚姻状态
 */
@property (nonatomic,copy) NSString *marriageStatus;
/**
 年龄
 */
@property (nonatomic,copy) NSString * age;

/**
 月收入
 */
@property (nonatomic,copy) NSString * monthlyIncome;

/**
 房产
 */
@property (nonatomic,copy) NSString *hasHouse;
/**
 房贷
 */
@property (nonatomic,copy) NSString *hasHouseLoan;
/**
 是否有 车贷
 */
@property (nonatomic,copy) NSString *hasCar;
/**
 是否有 车贷
 */
@property (nonatomic,copy) NSString *hasCarLoan;
/**
 学历
 */
@property (nonatomic,copy) NSString *graduation;
/**
 籍贯
 */
@property (nonatomic,copy) NSString *homeTown;
///@"公司类别：",
@property (nonatomic,copy) NSString *companyCategory;
///@"职位：",
@property (nonatomic,copy) NSString *companyPost;
///@"工作行业：",
@property (nonatomic,copy) NSString *companyIndustry;
///@"工作城市："
@property (nonatomic,copy) NSString *companyLocation;

@end

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
        _startIncrease_Amount = [NSString stringWithFormat:@"%.0lf起投，%.0lf递增",self.loanTruansferDetailModel.minInverst.floatValue,self.loanTruansferDetailModel.loanVo.finishedRatio.floatValue];
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




//----------------

/**
 婚姻状态
 */
- (NSString *) marriageStatus {
    if (!_marriageStatus) {
        if ([self.loanTruansferDetailModel.userVo.marriageStatus isEqualToString:@"MARRIED"]) {
            
            _marriageStatus = @"已婚";
            
        }else if ([self.loanTruansferDetailModel.userVo.marriageStatus isEqualToString:@"UNMARRIED"]){
            
            _marriageStatus = @"未婚";
            
        }else if ([self.loanTruansferDetailModel.userVo.marriageStatus isEqualToString:@"DIVORCED"]){
            
            _marriageStatus = @"离异";
            
        }else if ([self.loanTruansferDetailModel.userVo.marriageStatus isEqualToString:@"WIDOWED"]){
            
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
        _age = [NSString stringWithFormat:@"年龄 %@岁",self.loanTruansferDetailModel.idCardInfo.age];
    }
    return _age;
}
/**
 名字
 */
- (NSString *) name {
    if (!_name) {
        _name = self.loanTruansferDetailModel.idCardInfo.name;
    }
    return _name;
}
/**
 月收入
 */
- (NSString *) monthlyIncome {
    if (!_monthlyIncome) {
        _monthlyIncome = [NSString hxb_getPerMilWithDouble:self.loanTruansferDetailModel.userVo.monthlyIncome.floatValue];
    }
    return _monthlyIncome;
}
/**
 是否有房产
 */
- (NSString *) hasHouse {
    if (!_hasHouse) {
        if (self.loanTruansferDetailModel.userVo.hasHouse.integerValue) {
            _hasHouse = @"有房产";
        }else
        {
            _hasHouse = @"无房产";
        }
    }
    return _hasHouse;
}
/**
 是否有房贷
 */
- (NSString *) hasHouseLoan {
    if (!_hasHouseLoan) {
        if (self.loanTruansferDetailModel.userVo.hasHouseLoan.integerValue) {
            _hasHouseLoan = @"有房贷";
        }else
        {
            _hasHouseLoan = @"无房贷";
        }
    }
    return _hasHouseLoan;
}
/**
 是否有 车贷
 */
- (NSString *) hasCar {
    if (!_hasCar) {
        if (self.loanTruansferDetailModel.userVo.hasCarLoan.integerValue) {
            
            _hasCar = @"有车产";
        }else
        {
            _hasCar = @"无车产";
        }
    }
    return _hasCar;
}
/**
 是否有 车贷
 */
- (NSString *) hasCarLoan {
    if (!_hasCarLoan) {
        if (self.loanTruansferDetailModel.userVo.hasCar.integerValue) {
            _hasCarLoan = @"有车贷";
        }else
        {
            _hasCarLoan = @"无车贷";
        }
    }
    return _hasCarLoan;
}
/**
 身份证号
 */
- (NSString *) idNo {
    if (!_idNo) {
        _idNo = self.loanTruansferDetailModel.idCardInfo.idNo;
    }
    return _idNo;
}
/**
 学历
 */
- (NSString *)graduation {
    if (!_graduation) {
        _graduation = [self string:self.loanTruansferDetailModel.userVo.graduation componentsSeparatedByString:@"-"];
    }
    return _graduation;
}
/**
 ///@"籍贯：",
 */
- (NSString *)homeTown {
    if (!_homeTown) {
        _homeTown = [self string:self.loanTruansferDetailModel.userVo.homeTown componentsSeparatedByString:@"-"];
    }
    return _homeTown;
}

///@"公司类别：",
- (NSString *)companyCategory {
    if (!_companyCategory) {
        _companyCategory = [self string:self.loanTruansferDetailModel.userVo.companyCategory componentsSeparatedByString:@"-"];
    }
    return _companyCategory;
}
///@"职位：",
- (NSString *)companyPost {
    if (!_companyPost) {
        _companyPost = [self string:self.loanTruansferDetailModel.userVo.companyPost componentsSeparatedByString:@"-"];
    }
    return _companyPost;
}
///@"工作行业：",
- (NSString *)companyIndustry {
    if (!_companyIndustry) {
        _companyIndustry = [self string:self.loanTruansferDetailModel.userVo.companyIndustry componentsSeparatedByString:@"-"];
    }
    return _companyIndustry;
}
///@"工作城市："
- (NSString *)companyLocation {
    if (!_companyLocation) {
        _companyLocation = [self string:self.loanTruansferDetailModel.userVo.companyLocation componentsSeparatedByString:@"-"];
    }
    return _companyLocation;
}

-(HXBFin_Detail_DetailVC_LoanManager *)fin_LoanInfoView_Manager {
    if (!_fin_LoanInfoView_Manager) {
        _fin_LoanInfoView_Manager = [[HXBFin_Detail_DetailVC_LoanManager alloc] init];
        _fin_LoanInfoView_Manager.name = self.name;
        _fin_LoanInfoView_Manager.age = self.age;
        _fin_LoanInfoView_Manager.marriageStatus = self.marriageStatus;
        _fin_LoanInfoView_Manager.idNo = self.idNo;
        ///@"学历："
        _fin_LoanInfoView_Manager.graduation = self.graduation;
        _fin_LoanInfoView_Manager.homeTown = self.homeTown;
        
        _fin_LoanInfoView_Manager.hasCar = self.hasCar;
        _fin_LoanInfoView_Manager.hasHouse = self.hasHouse;
        _fin_LoanInfoView_Manager.hasHouseLoan = self.hasHouseLoan;
        _fin_LoanInfoView_Manager.monthlyIncome = self.monthlyIncome;
        
        _fin_LoanInfoView_Manager.companyCategory = self.companyCategory;
        _fin_LoanInfoView_Manager.companyPost = self.companyPost;
        _fin_LoanInfoView_Manager.companyIndustry = self.companyIndustry;
        _fin_LoanInfoView_Manager.companyLocation = self.companyLocation;
    }
    return _fin_LoanInfoView_Manager;
}

- (NSString *)string:(NSString *)string componentsSeparatedByString: (NSString *)str {
    NSArray *strArray = [string componentsSeparatedByString:str];
    NSString *_string = @"";
    if (strArray.count) {
        _string = strArray.lastObject;
    }else {
        _string = string;
    }
    return _string;
}

@end

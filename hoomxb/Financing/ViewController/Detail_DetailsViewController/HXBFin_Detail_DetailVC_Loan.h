//
//  HXBFin_Detail_DetailVC_Loan.h
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class HXBFinDetailViewModel_LoanDetail;
@class HXBFin_Detail_DetailVC_LoanManager;
@class HXBFin_LoanInfoView_Manager;
///贷款信息
@interface HXBFin_Detail_DetailVC_Loan : HXBBaseViewController
///用户信息
@property (nonatomic,strong) HXBFinDetailViewModel_LoanDetail *loanDetailViewModel;
@property (nonatomic,strong) HXBFin_Detail_DetailVC_LoanManager *fin_Detail_DetailVC_LoanManager;
@end


@interface HXBFin_Detail_DetailVC_LoanManager : NSObject
///借款说明
@property (nonatomic,copy) NSString *loanInstruction;

#pragma mark     ------------ @"基础信息" ----------------
///@"姓名：",
@property (nonatomic,copy) NSString *name;
///@"年龄：",
@property (nonatomic,copy) NSString *age;
///@"婚姻：",
@property (nonatomic,copy) NSString *marriageStatus;
///@"身份证号：",
@property (nonatomic,copy) NSString *idNo;
///@"学历：",
@property (nonatomic,copy) NSString *university;
///@"籍贯：",
@property (nonatomic,copy) NSString *homeTown;


#pragma mark     ------------  @"财务信息", ----------------
///@"车产：",
@property (nonatomic,copy) NSString *hasCar;
///@"房产：",
@property (nonatomic,copy) NSString *hasHouse;
///@"房贷：",
@property (nonatomic,copy) NSString *hasHouseLoan;
///@"月收入（月）："
@property (nonatomic,copy) NSString *monthlyIncome;


#pragma mark     ------------   @"工作信息", ----------------
///@"公司类别：",
@property (nonatomic,copy) NSString *companyCategory;
///@"职位：",
@property (nonatomic,copy) NSString *companyPost;
///@"工作行业：",
@property (nonatomic,copy) NSString *companyIndustry;
///@"工作城市："
@property (nonatomic,copy) NSString *companyLocation;


@end

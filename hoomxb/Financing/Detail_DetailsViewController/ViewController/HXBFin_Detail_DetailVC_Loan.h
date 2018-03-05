//
//  HXBFin_Detail_DetailVC_Loan.h
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
///string   标的认证类型（借款人审核状态）
@property (nonatomic,copy) NSString *creditInfoItems;
///标的风险等级
@property (nonatomic,copy) NSString *riskLevel;
///标的风险等级描述
@property (nonatomic,copy) NSString *riskLevelDesc;
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
@property (nonatomic,copy) NSString *graduation;
///@"籍贯：",
@property (nonatomic,copy) NSString *homeTown;
@property (nonatomic,copy) NSString *overDueStatus;// 截止借款前6个月内借款人征信报告中逾期情况
@property (nonatomic,copy) NSString *otherPlatStatus;// 借款人在其他网络借贷平台借款情况
@property (nonatomic,copy) NSString *protectSolution;// 还款保障措施(担保方式)
@property (nonatomic,copy) NSString *userFinanceStatus;// 借款人经营及财务状况
@property (nonatomic,copy) NSString *repaymentCapacity;// 借款人还款能力变化
@property (nonatomic,copy) NSString *punishedStatus;// 受罚情况

@property (nonatomic,copy) NSString *cashDrawStatus;//资金运用状况
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

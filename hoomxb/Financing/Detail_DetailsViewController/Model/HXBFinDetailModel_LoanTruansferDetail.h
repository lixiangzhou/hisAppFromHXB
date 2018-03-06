//
//  HXBFinDetailModel_LoanTruansferDetail.h
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseModel.h"
@class
HXBFinDetailModel_LoanTruansferDetail_loanVO,
HXBFinDetailModel_LoanTruansferDetail_transferDetail,
HXBFinDetailModel_LoanTruansferDetail_userLoanRecord,
HXBFinDetailModel_LoanTruansferDetail_idCardInfo,
HXBFinDetailModel_LoanTruansferDetail_creditInfo,
HXBFinDetailModel_LoanTruansferDetail_userVo;

@interface HXBFinDetailModel_LoanTruansferDetail : HXBBaseModel

/**
 标的id
 */
@property (nonatomic,copy) NSString * loanId;
/**
 转让id
 */
@property (nonatomic,copy) NSString * transferId;
/**
 是否可以购买(true:可以购买；false:不可以购买)
 */
@property (nonatomic,copy) NSString * enabledBuy;
/**
  是否可以购买(true:可以购买；false:不可以购买)
 */
@property (nonatomic,assign) BOOL isEnabledBuy;
/**
 剩余期数
 */
@property (nonatomic,copy) NSString * leftMonths;
/**
 借款期数
 */
@property (nonatomic,copy) NSString * loanMonths;
/**
 初始转让金额
 */
@property (nonatomic,copy) NSString * creatTransAmount;
/**
 剩余金额
 */
@property (nonatomic,copy) NSString * leftTransAmount;
/**
 状态
 TRANSFERING：正在转让，
 TRANSFERED：转让完毕，
 CANCLE：已取消，
 CLOSED_CANCLE：结标取消，
 OVERDUE_CANCLE：逾期取消，
 PRESALE：转让预售
 */
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString *availablePoints;///": 97226225.72,
@property (nonatomic,copy) NSString *agreementTitle;///": "借款协议",
@property (nonatomic,copy) NSString *agreementUrl;//": "/account/wapContract.action?type=sdrz",
@property (nonatomic,copy) NSString *remainTime;//": "",
@property (nonatomic,strong) NSString *minInverst;

@property (nonatomic,strong) HXBFinDetailModel_LoanTruansferDetail_loanVO *loanVo;
@property (nonatomic,strong) HXBFinDetailModel_LoanTruansferDetail_transferDetail *transferDetail;
@property (nonatomic,strong) HXBFinDetailModel_LoanTruansferDetail_userLoanRecord *userLoanRecord;
@property (nonatomic,strong) HXBFinDetailModel_LoanTruansferDetail_idCardInfo *idCardInfo;
@property (nonatomic,strong) HXBFinDetailModel_LoanTruansferDetail_creditInfo *creditInfo;
@property (nonatomic,strong) HXBFinDetailModel_LoanTruansferDetail_userVo *userVo;
@end



@interface HXBFinDetailModel_LoanTruansferDetail_loanVO : HXBBaseModel
@property (nonatomic,copy) NSString * guaranteedAmount;
///string   标的认证类型（借款人审核状态）
@property (nonatomic,copy) NSString *creditInfoItems;
@property (nonatomic,copy) NSString *riskLevel;///标的风险等级
@property (nonatomic,copy) NSString *riskLevelDesc;///标的风险等级描述
///": "0.0",
@property (nonatomic,copy) NSString * monthAmount;
///": "100.0",
@property (nonatomic,copy) NSString * finishedRatio;
///": "58100.0",
@property (nonatomic,copy) NSString * amount;
///": "人人U学10号标",
@property (nonatomic,copy) NSString * title;
///": "12",
@property (nonatomic,copy) NSString * interest;
///": "未发生过逾期",
@property (nonatomic,copy) NSString * overDued;
///": "11",
@property (nonatomic,copy) NSString * leftMonths;
///": "利益保障机制",
@property (nonatomic,copy) NSString * allProtected;
///": "0.0",
@property (nonatomic,copy) NSString * overDueAmount;
///": "按月等额本息",
@property (nonatomic,copy) NSString * repaymentType;
/**
 状态
 TRANSFERING：正在转让，
 TRANSFERED：转让完毕，
 CANCLE：已取消，
 CLOSED_CANCLE：结标取消，
 OVERDUE_CANCLE：逾期取消，
 PRESALE：转让预售
 */
@property (nonatomic,copy) NSString * status;
///[": "0.0",
@property (nonatomic,copy) NSString * unRepaid;
///": "0",
@property (nonatomic,copy) NSString * overDays;
///": "SDRZ",
@property (nonatomic,copy) NSString * certificateType;
///": "12",
@property (nonatomic,copy) NSString * months;
///": "0",
@property (nonatomic,copy) NSString * joinCount;
///": "HR",
@property (nonatomic,copy) NSString * borrowerLevel;
///": "758922"
@property (nonatomic,copy) NSString * loanId;
///下一个还款日
@property (nonatomic,copy) NSString *nextRepayDate;
@end

@interface HXBFinDetailModel_LoanTruansferDetail_transferDetail : HXBBaseModel
///": "人人U学10号标",
@property (nonatomic,copy) NSString * title;
///": 27,
@property (nonatomic,copy) NSString * transferId;
///": 12,
@property (nonatomic,copy) NSString * loanMonths;
///": "TRANSFERING",
@property (nonatomic,copy) NSString * status;
///": 12,
@property (nonatomic,copy) NSString * interest;
///": 11,
@property (nonatomic,copy) NSString * leftMonths;
///": 46518.14,
@property (nonatomic,copy) NSString * leftTransAmount;
///": 46518.14,
@property (nonatomic,copy) NSString * creatTransAmount;
///": 758922,
@property (nonatomic,copy) NSString * loanId;
///": 0,
@property (nonatomic,copy) NSString * userId;

@end


@interface HXBFinDetailModel_LoanTruansferDetail_userLoanRecord : HXBBaseModel


///": 1,
@property (nonatomic,copy) NSString * totalCount;
///": 5500,
@property (nonatomic,copy) NSString * notPay;
///": 0,
@property (nonatomic,copy) NSString * alreadyPayCount;
///": 58100,
@property (nonatomic,copy) NSString * borrowAmount;
///": 0,
@property (nonatomic,copy) NSString * availableCredits;
///": 0,
@property (nonatomic,copy) NSString * overdueAmount;
///": 1,
@property (nonatomic,copy) NSString * successCount;
///": 0,
@property (nonatomic,copy) NSString * failedCount;
///": 0
@property (nonatomic,copy) NSString * overdueCount;
@end


@interface HXBFinDetailModel_LoanTruansferDetail_idCardInfo : HXBBaseModel
///": "山东济宁",
@property (nonatomic,copy) NSString *address;
///": 37,
@property (nonatomic,copy) NSString *age;
///": 311616000000,
@property (nonatomic,copy) NSString *birth;
///": "MALE",
@property (nonatomic,copy) NSString *gender;
///": 404,[
@property (nonatomic,copy) NSString *ID;
///": "61****************",
@property (nonatomic,copy) NSString *idNo;
///": "**涛",
@property (nonatomic,copy) NSString *name;
///": 2458907,
@property (nonatomic,copy) NSString *user;
///": 1463120521000
@property (nonatomic,copy) NSString *validTime;

@end


@interface HXBFinDetailModel_LoanTruansferDetail_creditInfo: HXBBaseModel
///": 1,
@property (nonatomic,copy) NSString *work;
///": 1,
@property (nonatomic,copy) NSString *car;
///": 1,
@property (nonatomic,copy) NSString *fieldAudit;
///": 1,
@property (nonatomic,copy) NSString *mobileAuth;
///": 1,
@property (nonatomic,copy) NSString *album;
///": 0,
@property (nonatomic,copy) NSString *sdrz;
///": 1,
@property (nonatomic,copy) NSString *house;
///": 1,
@property (nonatomic,copy) NSString *marriage;
///": 1,
@property (nonatomic,copy) NSString *jgdb;
///": 1,
@property (nonatomic,copy) NSString *graduation;
///": 1,
@property (nonatomic,copy) NSString *sns;
///": 1,
@property (nonatomic,copy) NSString *mobileReceipt;
///": 1,
@property (nonatomic,copy) NSString *child;
///": 1,
@property (nonatomic,copy) NSString *residence;
///": 1,
@property (nonatomic,copy) NSString *incomeDuty;
///": 0,
@property (nonatomic,copy) NSString *identification;
///": 1,
@property (nonatomic,copy) NSString *titles;
///": 1,
@property (nonatomic,copy) NSString *account;
///": 1,
@property (nonatomic,copy) NSString *credit;
///": 1,
@property (nonatomic,copy) NSString *video;
///": 1,
@property (nonatomic,copy) NSString *mobile;
///": 1
@property (nonatomic,copy) NSString *weibo;
@end


@interface HXBFinDetailModel_LoanTruansferDetail_userVo: HXBBaseModel

@property (nonatomic,copy) NSString *cashDrawStatus;//资金运用状况 状态

@property (nonatomic,copy) NSString *overDueStatus;// 截止借款前6个月内借款人征信报告中逾期情况
@property (nonatomic,copy) NSString *otherPlatStatus;// 借款人在其他网络借贷平台借款情况
@property (nonatomic,copy) NSString *protectSolution;// 还款保障措施(担保方式)
@property (nonatomic,copy) NSString *userFinanceStatus;// 借款人经营及财务状况
@property (nonatomic,copy) NSString *repaymentCapacity;// 借款人还款能力变化
@property (nonatomic,copy) NSString *punishedStatus;// 受罚情况
///": "上海市市辖区",
@property (nonatomic,copy) NSString *accountLocation;
///": "上海市市辖区闵行区吴中路478号",
@property (nonatomic,copy) NSString *companyAddress;
///": "国有股份",
@property (nonatomic,copy) NSString *companyCategory;
///": "市辖区",
@property (nonatomic,copy) NSString *companyLocation;
///": "上海云峰（集团）锦江实业有限公司",
@property (nonatomic,copy) NSString *companyName;
///": "项目部，后勤管理",
@property (nonatomic,copy) NSString *companyPost;
///": 1493262666000,
@property (nonatomic,copy) NSString *createTime;
///": "公司职员，现居北京市，从事批发和零售业行业，工作收入稳定",
@property (nonatomic,copy) NSString *descriptionStr;
///行业
@property (nonatomic,copy) NSString *companyIndustry;
///": "大专",
@property (nonatomic,copy) NSString *graduation;
///": true,
@property (nonatomic,copy) NSString *hasCar;
///车贷
@property (nonatomic,copy) NSString *hasCarLoan;
///": true,
@property (nonatomic,copy) NSString *hasChild;
///": false,
@property (nonatomic,copy) NSString *hasHouse;
///": true,
@property (nonatomic,copy) NSString *hasHouseLoan;
///": "上海市市辖区",
@property (nonatomic,copy) NSString *homeTown;
///": 1265,
@property (nonatomic,copy) NSString *ID;
///": "胡银环",
@property (nonatomic,copy) NSString *immediateName;
///": "配偶",
@property (nonatomic,copy) NSString *immediateRelationShip;
///": "18701860617",
@property (nonatomic,copy) NSString *immediateTel;
///": "一般管理人员",
@property (nonatomic,copy) NSString *jobStatus;
///": 758922,
@property (nonatomic,copy) NSString *loanId;
///": "MARRIED",
@property (nonatomic,copy) NSString *marriageStatus;
///": "4000",
@property (nonatomic,copy) NSString *monthlyIncome;
///": "王振",
@property (nonatomic,copy) NSString *otherRelationName;
///": "朋友",
@property (nonatomic,copy) NSString *otherRelationShip;
///": "18616137068",
@property (nonatomic,copy) NSString *otherRelationTel;
///": "ref_758922",
@property (nonatomic,copy) NSString *refId;
///": "北大",
@property (nonatomic,copy) NSString *university;
///": 1493262666000,
@property (nonatomic,copy) NSString *updateTime;
///": 0
@property (nonatomic,copy) NSString *version;
@end

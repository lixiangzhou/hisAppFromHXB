//
//  HXBFinDatailModel_LoanDetail.h
//  hoomxb
//
//  Created by HXB on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinDatailModel_LoanDetail_loanVo;
@class HXBFinDatailModel_LoanDetail_userLoanRecord;
@class HXBFinDatailModel_LoanDetail_idCardInfo;
@class HXBFinDatailModel_LoanDetail_creditInfo;
@class HXBFinDatailModel_LoanDetail_userVo;

/**婚姻状态*/
typedef enum : NSUInteger {
    ///已婚
    HXBFinDatailModel_LoanDetail_marriageStatus_MARRIED,
    ///未婚
    HXBFinDatailModel_LoanDetail_marriageStatus_UNMARRIED,
    ///离异
    HXBFinDatailModel_LoanDetail_marriageStatus_DIVORCED,
    ///丧偶
    HXBFinDatailModel_LoanDetail_marriageStatus_WIDOWED,
  
} HXBFinDatailModel_LoanDetail_marriageStatus;


///散标的所有信息基本都在这里了
@interface HXBFinDatailModel_LoanDetail : NSObject
///起投金额
@property (nonatomic,copy) NSString *minInverst;
///散标的基本信息
@property (nonatomic,strong) HXBFinDatailModel_LoanDetail_loanVo *loanVo;
///协议的url
@property (nonatomic,copy) NSString *agreementUrl;
///剩余时间
@property (nonatomic,copy) NSString *remainTime;
///用户贷款记录
@property (nonatomic,strong) HXBFinDatailModel_LoanDetail_userLoanRecord *userLoanRecord;
///贷款协议
@property (nonatomic,copy) NSString *agreementTitle;// "借款协议",
///银行卡的信息
@property (nonatomic,strong) HXBFinDatailModel_LoanDetail_idCardInfo *idCardInfo;
///信用信息
@property (nonatomic,strong) HXBFinDatailModel_LoanDetail_creditInfo *creditInfo;
///用户信息
@property (nonatomic,strong) HXBFinDatailModel_LoanDetail_userVo *userVo;
@end

// --------------------- loanVO ---------------------

///散标的基本信息
@interface HXBFinDatailModel_LoanDetail_loanVo : NSObject
///string   标的认证类型（借款人审核状态）
@property (nonatomic,copy) NSString *creditInfoItems;
///string	籍贯所在地
@property (nonatomic,copy) NSString *accountLocation;
///string	公司地址
@property (nonatomic,copy) NSString *companyAddress;
///string	剩余可投金额
@property (nonatomic,copy) NSString *surplusAmount;
///保证金额
@property (nonatomic,copy) NSString *guaranteedAmount;
///月金额
@property (nonatomic,copy) NSString *monthAmount;
///总计100美元
@property (nonatomic,copy) NSString *totalInterestPer100;
///完成比例
@property (nonatomic,copy) NSString *finishedRatio;
///量
@property (nonatomic,copy) NSString *amount;
///标题
@property (nonatomic,copy) NSString *title;
///剩余时间
@property (nonatomic,copy) NSString *remainTime;
///利益
@property (nonatomic,copy) NSString *interest;
///标的风险等级
@property (nonatomic,copy) NSString *riskLevel;
///标的风险等级描述
@property (nonatomic,copy) NSString *riskLevelDesc;
///描述
@property (nonatomic,copy) NSString *description_loanVO;
///左边的月数
@property (nonatomic,copy) NSString *leftMonths;
///所有受保护
@property (nonatomic,copy) NSString *allProtected;
///超过到期金额
@property (nonatomic,copy) NSString *overDueAmount;
///还款类型
@property (nonatomic,copy) NSString *repaymentType;
///状态
@property (nonatomic,copy) NSString *status;
///不报销
@property (nonatomic,copy) NSString *unRepaid;
///超过天数
@property (nonatomic,copy) NSString *overDays;
///证书类别
@property (nonatomic,copy) NSString *certificateType;
///月数
@property (nonatomic,copy) NSString *months;
///加入数量
@property (nonatomic,copy) NSString *joinCount;
///借款人级别
@property (nonatomic,copy) NSString *borrowerLevel;
///loanID
@property (nonatomic,copy) NSString *loanId;
///";: "1天1时21分47秒",
@property (nonatomic,copy) NSString *fullTime;
///": "2016-10-03"
@property (nonatomic,copy) NSString *nextRepayDate;

/**
 根据返回内容动态获取高度
 */
@property (nonatomic, assign) CGFloat description_loanVO_height;

@end

// --------------------- idCardInfo ---------------------

///信用卡信息
@interface HXBFinDatailModel_LoanDetail_idCardInfo : NSObject
@property (nonatomic,copy) NSString *address;//": "北京市海淀区西直门外高梁桥斜街59号中坤大厦7层",
@property (nonatomic,copy) NSString *age;//": 48,
@property (nonatomic,copy) NSString *birth;//": -32169600000,
@property (nonatomic,copy) NSString *gender;//": "MALE",
@property (nonatomic,copy) NSString *ID;//": 187,
@property (nonatomic,copy) NSString *idNo;//": "61****************",
@property (nonatomic,copy) NSString *name;//": "**辉",
@property (nonatomic,copy) NSString *user;//": 2458616,
@property (nonatomic,copy) NSString *validTime;//": 1455796547000
@end



// --------------------- 用户贷款记录 ---------------------
///用户贷款记录
@interface HXBFinDatailModel_LoanDetail_userLoanRecord : NSObject
@property (nonatomic,copy) NSString *totalCount;//": 0,
@property (nonatomic,copy) NSString *notPay;//": 0,
@property (nonatomic,copy) NSString *alreadyPayCount;//": 0,
@property (nonatomic,copy) NSString *borrowAmount;//": 0,
@property (nonatomic,copy) NSString *availableCredits;//": 0,
@property (nonatomic,copy) NSString *overdueAmount;//": 0,
@property (nonatomic,copy) NSString *successCount;//": 0,
@property (nonatomic,copy) NSString *failedCount;//": 0,
@property (nonatomic,copy) NSString *overdueCount;//": 0
@end



// --------------------- 信用信息 ---------------------
///信用信息
@interface HXBFinDatailModel_LoanDetail_creditInfo : NSObject
@property (nonatomic,copy) NSString *work;//": 1,
@property (nonatomic,copy) NSString *car;//": 1,
@property (nonatomic,copy) NSString *fieldAudit;//": 1,
@property (nonatomic,copy) NSString *mobileAuth;//": 1,
@property (nonatomic,copy) NSString *album;//": 1,
@property (nonatomic,copy) NSString *sdrz;//": 0,
@property (nonatomic,copy) NSString *house;//": 1,
@property (nonatomic,copy) NSString *marriage;//": 1,
@property (nonatomic,copy) NSString *jgdb;//": 1,
@property (nonatomic,copy) NSString *graduation;//": 1,
@property (nonatomic,copy) NSString *sns;//": 1,
@property (nonatomic,copy) NSString *mobileReceipt;//": 1,
@property (nonatomic,copy) NSString *child;//": 1,
@property (nonatomic,copy) NSString *residence;//": 1,
@property (nonatomic,copy) NSString *incomeDuty;//": 1,
@property (nonatomic,copy) NSString *identification;//": 0,
@property (nonatomic,copy) NSString *titles;//": 1,
@property (nonatomic,copy) NSString *account;//": 1,
@property (nonatomic,copy) NSString *credit;//": 1,
@property (nonatomic,copy) NSString *video;//": 1,
@property (nonatomic,copy) NSString *mobile;//": 1,
@property (nonatomic,copy) NSString *weibo;//": 1
@end



// --------------------- 用户信息 ---------------------
///用户信息
@interface HXBFinDatailModel_LoanDetail_userVo : NSObject
@property (nonatomic,copy) NSString *cashDrawStatus;//"恒丰银行暂未受理提现"

@property (nonatomic,copy) NSString *overDueStatus;// 截止借款前6个月内借款人征信报告中逾期情况
@property (nonatomic,copy) NSString *otherPlatStatus;// 借款人在其他网络借贷平台借款情况
@property (nonatomic,copy) NSString *protectSolution;// 还款保障措施(担保方式)
@property (nonatomic,copy) NSString *userFinanceStatus;// 借款人经营及财务状况
@property (nonatomic,copy) NSString *repaymentCapacity;// 借款人还款能力变化
@property (nonatomic,copy) NSString *punishedStatus;// 受罚情况
@property (nonatomic,copy) NSString *otherMajorLiabilities;// 其他重大负债
@property (nonatomic,copy) NSString *accountLocation;
///string	籍贯所在地
@property (nonatomic,copy) NSString *companyAddress;
///	string	公司地址
@property (nonatomic,copy) NSString *companyCategory;
///	string	公司类别
@property (nonatomic,copy) NSString *companyLocation;
///	string	公司所在城市
@property (nonatomic,copy) NSString *companyName;
///	string	公司名称
@property (nonatomic,copy) NSString *companyPost;
///	string	公司职位
@property (nonatomic,copy) NSString *contractCode;
///	string	合同号码
@property (nonatomic,copy) NSString *graduation;
///	string	最高学历
@property (nonatomic,copy) NSString *hasCar;
///	string	是否有车
@property (nonatomic,copy) NSString *hasChild;
///	string	是否有孩子
@property (nonatomic,copy) NSString *hasHouse;
///	string	是否有房子
@property (nonatomic,copy) NSString *hasHouseLoan;
///	string	是否有房贷
@property (nonatomic,copy) NSString *homeTown;
///	string	籍贯所在省份
@property (nonatomic,copy) NSString *immediateName;
///	string	直系亲属姓名
@property (nonatomic,copy) NSString *immediateRelationShip;
///	string	直系亲属关系
@property (nonatomic,copy) NSString *immediateTel;
///	string	直系亲属电话
@property (nonatomic,copy) NSString *jobStatus;
///	string	工作状态
@property (nonatomic,copy) NSString *loanId;
///	int	标id
@property (nonatomic,copy) NSString *marriageStatus;
///	string	婚姻状态（见下表）
@property (nonatomic,copy) NSString *monthlyIncome;
///	string	月收入
@property (nonatomic,copy) NSString *otherRelationName;
///	string	其他联系人姓名
@property (nonatomic,copy) NSString *otherRelationShip;
///	string	其他联系人关系
@property (nonatomic,copy) NSString *refId;
///	string	进件号
@property (nonatomic,copy) NSString *residence;
///	string	居住地址
@property (nonatomic,copy) NSString *residenceTel;
///	string	居住地电话
@property (nonatomic,copy) NSString *university;
///	string	大学
@property (nonatomic,copy) NSString *companyIndustry;
///	string	工作类别
@property (nonatomic,copy) NSString *hasCarLoan;


///": 1493776767000,
@property (nonatomic,copy) NSString *createTime;
///": "公司职员，现居北京市，从事批发和零售业行业，工作收入稳定",
@property (nonatomic,copy) NSString *description_userVO;
//": 1068,
@property (nonatomic,copy) NSString *ID;
//": 1493776767000,
@property (nonatomic,copy) NSString *updateTime;
//": 0
@property (nonatomic,copy) NSString *version;


@end


/**
 
 
 
 "data": {
 "loanVo": {
 "guaranteedAmount": "0.0",
 "surplusAmount": "93500.0",
 "monthAmount": "16202.29",
 "totalInterestPer100": "3.53",
 "finishedRatio": "19.0",
 "amount": "93900.0",
 "title": "贷款",
 "remainTime": "",
 "interest": "12",
 "description": "公司职员，现居北京市，从事批发和零售业行业，工作收入稳定",
 "leftMonths": "6",
 "allProtected": "利益保障机制",
 "overDueAmount": "0.0",
 "repaymentType": "等额本息",
 "status": "OPEN",
 "unRepaid": "0.0",
 "overDays": "0",
 "certificateType": "SDRZ",
 "months": "6",
 "joinCount": "0",
 "borrowerLevel": "D",
 "loanId": "761133"
 },
 "agreementUrl": "http://172.16.3.27:28131/account/wapContract.action?type=sdrz",
 "remainTime": "",
 "userLoanRecord": {
 "totalCount": 0,
 "notPay": 0,
 "alreadyPayCount": 0,
 "borrowAmount": 0,
 "availableCredits": 0,
 "overdueAmount": 0,
 "successCount": 0,
 "failedCount": 0,
 "overdueCount": 0
 },
 "agreementTitle": "借款协议",
 "idCardInfo": {
 "address": "北京市海淀区西直门外高梁桥斜街59号中坤大厦7层",
 "age": 48,
 "birth": -32169600000,
 "gender": "MALE",
 "id": 187,
 "idNo": "61****************",
 "name": "**辉",
 "user": 2458616,
 "validTime": 1455796547000
 },
 "creditInfo": {
 "work": 1,
 "car": 1,
 "fieldAudit": 1,
 "mobileAuth": 1,
 "album": 1,
 "sdrz": 0,
 "house": 1,
 "marriage": 1,
 "jgdb": 1,
 "graduation": 1,
 "sns": 1,
 "mobileReceipt": 1,
 "child": 1,
 "residence": 1,
 "incomeDuty": 1,
 "identification": 0,
 "titles": 1,
 "account": 1,
 "credit": 1,
 "video": 1,
 "mobile": 1,
 "weibo": 1
 },
 "userVo": {
 "accountLocation": "河南省郑州市",
 "companyAddress": "西大街行政服务中心四楼",
 "companyCategory": "机关事业",
 "companyLocation": "郑州市",
 "companyName": "新密市房屋征收与补偿办公室",
 "companyPost": "征补三科副科长",
 "createTime": 1493776767000,
 "description": "公司职员，现居北京市，从事批发和零售业行业，工作收入稳定",
 "graduation": "大专",
 "hasCar": true,
 "hasChild": true,
 "hasHouse": false,
 "hasHouseLoan": false,
 "homeTown": "河南省郑州市新密市老城菜市场西口86号",
 "id": 1068,
 "immediateName": "张松花",
 "immediateRelationShip": "配偶",
 "immediateTel": "13938237899",
 "jobStatus": "一般管理人员",
 "loanId": 761133,
 "marriageStatus": "MARRIED",
 "monthlyIncome": "3200",
 "otherRelationName": "吕海涛",
 "otherRelationShip": "同事",
 "otherRelationTel": "15890672333",
 "refId": "dasyghgda",
 "university": "北大",
 "updateTime": 1493776767000,
 "version": 0
 }
 },
 */

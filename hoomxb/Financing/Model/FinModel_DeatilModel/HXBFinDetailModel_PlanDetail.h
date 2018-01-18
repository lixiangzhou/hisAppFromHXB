//
//  HXBFinDetailModel_PlanDetail.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

/**
 请求参数：参数名 参数类型 描述
 userId int
 用户ID financePlanId int
 红利计划ID platform string
 平台：IOS-苹果，
 其他值-ANDROID,WINDOWS8 version string
 响应结果版本号：1.0-默认值
 响应结果： 字段名 字段类型 描述 status int
 请求结果：0-成功，1-失败 message string
 请求结果描述：success-成功，其他-失败原因 data isRolePassed
 用户状态：true-用户有昵称并且实名认证通过、手机号有效、设置提现密码，false-不满足上述条件 principalBalanceContractName registerCount 加入人次 contractUrl 预定及等待预定展示预定协议 dataList
 */

#import <Foundation/Foundation.h>
@class HXBFinDetailModel_PlanDetail_DataList;


///post /financeplan/financeplandetail.action 红利计划详情Model
@interface HXBFinDetailModel_PlanDetail : NSObject

///曾信地址
@property (nonatomic,copy) NSString *contractUrl;
///本金余额合约名称
@property (nonatomic,copy) NSString *principalBalanceContractName;
///是否登录
@property (nonatomic,copy) NSString *isRolePassed;

///当前时间 lockDay 销售期限(天)
@property (nonatomic,copy) NSString *currentTime;
///锁天数
@property (nonatomic,copy) NSString *lockDay;
///合同名称的主要平衡的URL
@property (nonatomic,copy) NSString *principalBalanceContractNameUrl;

///最终注册总金额
@property (nonatomic,copy) NSString *finishRatio;

///int	用户组id
@property (nonatomic,copy) NSString *groupid;
///String	近七天加入理财计划（全部）的人数
@property (nonatomic,copy) NSString *registerCount;
///String	预期收益计算值（1000的收益）
@property (nonatomic,copy) NSString *totalInterest;
///[String	计划介绍
@property (nonatomic,copy) NSString *introduce;
///String	计划状态
@property (nonatomic,copy) NSString *unifyStatus;
///String	基础利率
@property (nonatomic,copy) NSString *baseInterestRate;
///锁定结束时间
@property (nonatomic,copy) NSString *endLockingTime;
///String	计划id
@property (nonatomic,copy) NSString *ID;
///String	加息利率
@property (nonatomic,copy) NSString *extraInterestRate;
////String	提前退出费率
@property (nonatomic,copy) NSString *quitRateAdvance;
///String	年利率
@property (nonatomic,copy) NSString *expectedRate;
///String	计划名称
@property (nonatomic,copy) NSString *name;
///String	单笔加入上线
@property (nonatomic,copy) NSString *singleMaxRegisterAmount;
///计划期限（锁定期）
@property (nonatomic,copy) NSString *lockPeriod;
///String	开始销售时间
@property (nonatomic,copy) NSString *beginSellingTime;
///String	可投资对象
@property (nonatomic,copy) NSString *productsJson;
///String	超出预期收益部分作为服务费
@property (nonatomic,copy) NSString *interestName;
///String	最小注册金额
@property (nonatomic,copy) NSString *minRegisterAmount;
///String	进入锁定期时间
@property (nonatomic,copy) NSString *financeEndTime;
///String	加入人次
@property (nonatomic,copy) NSString *joinCount;
///String	销售期限(天)
@property (nonatomic,copy) NSString *salePeriod;
///String	已获收益（累计赚取）
@property (nonatomic,copy) NSString *earnInterest;
///String	是否首次够买
@property (nonatomic,copy) NSString *isFirst;
///String	注册倍数金额
@property (nonatomic,copy) NSString *registerMultipleAmount;
///String	销售结束时间
@property (nonatomic,copy) NSString *endSellingTime;
///String	计入费率
@property (nonatomic,copy) NSString *buyInRate;
///String	剩余可追加金额
@property (nonatomic,copy) NSString *userRemainAmount;
///String	剩余可投
@property (nonatomic,copy) NSString *remainAmount;

///String	剩余可追加金额
@property (nonatomic,copy) NSString *potUserRemainAmount;
///String	剩余可投
@property (nonatomic,copy) NSString *potRemainAmount;

///String	倒计时时间戳
@property (nonatomic,copy) NSString *diffTime;
@property (nonatomic,copy) NSString *rsvCount;///": "0",
@property (nonatomic,copy) NSString *couponInterestRate;///": "",
@property (nonatomic,copy) NSString *quitRate;///": "0.0",
@property (nonatomic,copy) NSString *tag;///": "3424324",
@property (nonatomic,copy) NSString *desc3;///": "05月13日 16:56 开放加入",
@property (nonatomic,copy) NSString *desc4;///": "05月13日 16:56",
@property (nonatomic,copy) NSString *lockPeriodStr;///": "2021年06月17日(1个月)",
@property (nonatomic,assign) double amount;///": "7000.0",
@property (nonatomic,copy) NSString *financeStatus;//": "3",
@property (nonatomic,copy) NSString *beginSelling;//Time": "2021-05-13 16:56:00",
@property (nonatomic,copy) NSString *interestRate;//": "0.0",
@property (nonatomic,copy) NSString *fillTime;//": "2天2时4分0秒",
@property (nonatomic,copy) NSString *category;//": "A",
@property (nonatomic,copy) NSString *lockStart;///": "05-17 16:56",
@property (nonatomic,copy) NSString *beginResellingTime;//": "2021-05-13 16:56:00",
@property (nonatomic,copy) NSString *contractName;//": "理财计划服务协议 UI",
@property (nonatomic,copy) NSString *cashType;//": "收益处理方式。 HXB：按月付息，INVEST：收益再投资"
@property (nonatomic,copy) NSString *cashDrawDay;//": "按月付息日"
@property (nonatomic,copy) NSString *incomeApproach;//": "收益方式文案，文案规则：HXB返回：按月付息，INVEST返回：收益复投"
@property (nonatomic,copy) NSString *interestDate;//": "按月付息日具体文案，拼接规则：每月+cashDrawDay+日付息"

@property (nonatomic,copy) NSString *subsidyInterestRate;//新手贴息收益率
@property (nonatomic,copy) NSString *expectedSubsidyInterestAmount;//新手贴息预期收益/100元
@property (nonatomic,assign) int novice;//是否是新手计划(1:是新手 0:非新手)
@property (nonatomic,copy) NSString *lockDays;//新手计划锁定期/天
@property (nonatomic,copy) NSString *newbiePlanAmount;//新手产品购买额度
@property (nonatomic,copy) NSString *newbiePlanLeftAmount;//新手产品剩余额度




///红利计划详情页的数据数组
//@property (nonatomic,strong) NSArray <HXBFinDetailModel_PlanDetail_DataList *>*dataList;
@end


///红利计划详情数据的数据
@interface HXBFinDetailModel_PlanDetail_DataList : NSObject
//========================= dataList ===========================
///理财计划预定日志次数
@property (nonatomic,copy) NSString *rsvCount;
///优惠券加息利率
@property (nonatomic,copy) NSString *couponInterestRate;
///剩余金额
@property (nonatomic,copy) NSString *remainAmount;
///介绍说明
@property (nonatomic,copy) NSString *introduce;
///MobileUplanFullStatusTransfer
@property (nonatomic,copy) NSString *unifyStatus;
///本期基准利率
@property (nonatomic,copy) NSString *baseInterestRate;
///锁定期结束时间(退出时间)文本
@property (nonatomic,copy) NSString *lockPeriodStr;
///锁定期结束时间(退出时间)
@property (nonatomic,copy) NSString *endLockingTime;
///参与U计划的费率
@property (nonatomic,copy) NSString *buyInRate;
///总金额
@property (nonatomic,copy) NSString *amount;

@property (nonatomic,copy) NSString *ID;
///
@property (nonatomic,copy) NSString *financeStatus;
///已赚总利息
@property (nonatomic,copy) NSString *earnInterest;
///本期加息利率
@property (nonatomic,copy) NSString *extraInterestRate;
///提前退出U计划的费率
@property (nonatomic,copy) NSString *quitRateAdvance;
///U计划预期年化收益率
@property (nonatomic,copy) NSString *expectedRate;
///计划名称
@property (nonatomic,copy) NSString *name;
///预期收益率投资
@property (nonatomic,copy) NSString *expectedRateInvest;
///单最大寄存器数量
@property (nonatomic,copy) NSString *singleMaxRegisterAmount;
///锁定期限(月),计划期限
@property (nonatomic,copy) NSString *lockPeriod;
///开始预定时间
@property (nonatomic,copy) NSString *beginSellingTime;
///可投资对象 – 产品集 json
@property (nonatomic,copy) NSString *productsJson;
///利息名称
@property (nonatomic,copy) NSString *interestName;
///注册金额起点
@property (nonatomic,copy) NSString *minRegisterAmount;
///预定满额用时
@property (nonatomic,copy) NSString *fillTime;
///U计划分类
@property (nonatomic,copy) NSString *category;
///销售结束时间
@property (nonatomic,copy) NSString *financeEndTime;
///锁开始
@property (nonatomic,copy) NSString *lockStart;
///加入人次
@property (nonatomic,copy) NSString *joinCount;
///销售期限(天)
@property (nonatomic,copy) NSString *salePeriod;
///补发开始时间
@property (nonatomic,copy) NSString *beginResellingTime;
//==============================================================
@end




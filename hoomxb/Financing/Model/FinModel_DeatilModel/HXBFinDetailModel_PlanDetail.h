//
//  HXBFinDetailModel_PlanDetail.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
///注册数量
@property (nonatomic,copy) NSString *registerCount;
///总利息
@property (nonatomic,copy) NSString *totalInterest;
///本金余额合约名称
@property (nonatomic,copy) NSString *principalBalanceContractName;
///是通过角色（反正翻译是这么翻译）
@property (nonatomic,copy) NSString *isRolePassed;



///当前时间 lockDay 销售期限(天)
@property (nonatomic,copy) NSString *currentTime;
///锁天数
@property (nonatomic,copy) NSString *lockDay;
///合同名称的主要平衡的URL
@property (nonatomic,copy) NSString *principalBalanceContractNameUrl;

///最终注册总金额
@property (nonatomic,copy) NSString *finishRatio;

///红利计划详情页的数据数组
@property (nonatomic,strong) NSArray <HXBFinDetailModel_PlanDetail_DataList *>*dataList;
@end



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



/**
 data": {
 "isRolePassed": "1",
 "principalBalanceContractName": "用户利益保障机制",
 "totalInterest": "0.00",
 "registerCount": "40",
 "contractUrl": "http://172.16.3.27:28131/account/wapContract.action?type=uplan",
 "dataList": [
 {
 "rsvCount": "0",
 "couponInterestRate": "",
 "introduce": "红利计划",
 "unifyStatus": "9",
 "baseInterestRate": "0.0",
 "lockPeriodStr": "2016年04月05日(3个月)",
 "endLockingTime": "2016-04-05 15:08:51",
 "financeStatus": "7",
 "id": "1",
 "extraInterestRate": "0.0",
 "quitRateAdvance": "加入本金的2%",
 "expectedRate": "6.0",
 "name": "红利计划-A160104期-k1",
 "expectedRateInvest": "6.0",
 "singleMaxRegisterAmount": "500000.0",
 "lockPeriod": "3",
 "beginSellingTime": "2016-01-04 15:08:11",
 "productsJson": "实地认证标",
 "interestName": "超出预期收益部分作为服务费",
 "minRegisterAmount": "1000",
 "fillTime": "1天0时0分40秒",
 "category": "A",
 "financeEndTime": "2016-01-05 15:08:11",
 "lockStart": "01-05 15:08",
 "joinCount": "0",
 "salePeriod": "1",
 "beginResellingTime": "2016-01-04 15:08:51"
 }
 ],
 "currentTime": "2017-05-09 16:35:34",
 "lockDay": 1,
 "contractName": "理财计划服务协议",
 "principalBalanceContractNameUrl": "http://www.we.com/wap/focuswap/capital.html"
 },
 "message": "success",
 "status": 0
 }
 */


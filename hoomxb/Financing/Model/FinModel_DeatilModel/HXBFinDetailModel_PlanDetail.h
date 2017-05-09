//
//  HXBFinDetailModel_PlanDetail.h
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
///post /financeplan/financeplandetail.action 红利计划详情Model

@interface HXBFinDetailModel_PlanDetail : NSObject
/*
 请求参数：参数名 参数类型 描述 
 userId int 
 用户ID financePlanId int 
 红利计划ID platform string 
 平台：IOS-苹果，其他值-ANDROID,WINDOWS8 version string 
 响应结果版本号：1.0-默认值
 响应结果： 字段名 字段类型 描述 status int
 请求结果：0-成功，1-失败 message string 
 请求结果描述：success-成功，其他-失败原因 data isRolePassed 
 用户状态：true-用户有昵称并且实名认证通过、手机号有效、设置提现密码，false-不满足上述条件 principalBalanceContractName registerCount 加入人次 contractUrl 预定及等待预定展示预定协议 dataList
 */
@property (nonatomic,copy) NSString *contractUrl;
@property (nonatomic,copy) NSString *registerCount;
@property (nonatomic,copy) NSString *totalInterest;
@property (nonatomic,copy) NSString *principalBalanceContractName;
@property (nonatomic,copy) NSString *isRolePassed;

///理财计划预定日志次数
@property (nonatomic,copy) NSString *rsvCount;
///优惠券加息利率
@property (nonatomic,copy) NSString *couponInterestRate;
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
///
@property (nonatomic,copy) NSString *financeStatus;
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
///当前时间 lockDay 销售期限(天)
@property (nonatomic,copy) NSString *currentTime;
///锁天数
@property (nonatomic,copy) NSString *lockDay;
///合同名称的主要平衡的URL
@property (nonatomic,copy) NSString *principalBalanceContractNameUrl;


///最终注册总金额
@property (nonatomic,copy) NSString *finishRatio;
@end

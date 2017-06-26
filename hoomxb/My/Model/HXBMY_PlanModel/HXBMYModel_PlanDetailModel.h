//
//  HXBMYModel_PlanDetailModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>



/// 我的 界面的 红利计划详情页的Model
@interface HXBMYModel_PlanDetailModel : NSObject
/**
 加入金额
 */
@property (nonatomic,copy) NSString * finalAmount;
///	string	计划名称
@property (nonatomic,copy) NSString *name;
///	string	已获收益
@property (nonatomic,copy) NSString *earnAmount;
///	string	预期收益率
@property (nonatomic,copy) NSString *expectedRate;
///	string	投资期限
@property (nonatomic,copy) NSString *lockPeriod;
///	string	退出时间
@property (nonatomic,copy) NSString *endLockingTime;
///	string	完成时间
@property (nonatomic,copy) NSString *redFinishTime;
///	string	待转让金额
@property (nonatomic,copy) NSString *redProgressLeft;
///	string	计入金额
@property (nonatomic,copy) NSString *amount;

///	string	处理方式 （HXB：当日提取至红小宝账户，INVEST：收益再投资）
@property (nonatomic,copy) NSString *cashType;

///	string	加入时间
@property (nonatomic,copy) NSString *registerTime;

///	string	预期收益
@property (nonatomic,copy) NSString *totalInterest;
///	string	状态（PURCHASE_END：收益中，PURCHASEING：等待计息）
@property (nonatomic,copy) NSString *status;
///	Int	剩余天数
@property (nonatomic,copy) NSString *lastDays;




@property (nonatomic,copy) NSString *type;//": "HOLD_PLAN",
@property (nonatomic,copy) NSString *isUseCoupon;//": "0",
@property (nonatomic,copy) NSString *contractUrl;//": "http://172.16.3.27:28131/account/wapContract.action?type=uplan",
@property (nonatomic,copy) NSString *ID;//": "156688",
@property (nonatomic,copy) NSString *category;//": "A",

@property (nonatomic,copy) NSString *subPointId;//": "1291978",
@property (nonatomic,copy) NSString *contractName;//": "理财计划服务协议"



@end

/*
{
    "data": {
        "dataList": {
            "lockPeriod": "1",
            "earnAmount": "100.0",
            "status": "PURCHASE_END",
            "cashType": "HXB",
            "totalInterest": "295.83",
            "type": "HOLD_PLAN",
            "registerTime": "1493728324000",
            "endLockingTime": "1495283676000",
            "isUseCoupon": "0",
            "contractUrl": "http://172.16.3.27:28131/account/wapContract.action?type=uplan",
            "id": "156688",
            "amount": "50000.0",
            "category": "A",
            "expectedRate": "4.50",
            "name": "安琪发布计划11",
            "subPointId": "1291978",
            "contractName": "理财计划服务协议"
        }
    },
    "message": "success",
    "status": 0
}
*/

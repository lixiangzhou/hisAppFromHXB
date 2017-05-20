//
//  HXBMYModel_MianPlanModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
name: 计划名称，
amount:加入金额，
earnAmount：已获收益，
expectedRate：预期收益率
，lockPeriod ：投资期限，
endLockingTime ：退出时间，
redFinishTime:完成时间，
redProgressLeft:待转让金额
 */
@class HXBMYModel_MainPlanModel_DataList;
///关于 我的红利计划的 主界面的Model
@interface HXBMYModel_MainPlanModel : NSObject
@property (nonatomic,strong) NSArray <HXBMYModel_MainPlanModel_DataList*>*dataList;

@property (nonatomic,copy) NSString *totalCount;//": 1,
@property (nonatomic,copy) NSString *pageSize;//": 10,
@property (nonatomic,copy) NSString *pageNumber;//": 1
@end


///我的红利计划的 主界面的Model 里的 dataList属性
@interface HXBMYModel_MainPlanModel_DataList : NSObject
///投资期限
@property (nonatomic,copy) NSString *lockPeriod;//": "1",
///已获收益
@property (nonatomic,copy) NSString *earnAmount;//": "100.00",
///收益的状态
@property (nonatomic,copy) NSString *status;//": "PURCHASE_END",
///转让金额
@property (nonatomic,copy) NSString *redProgressLeft;//": "50000.00",
///完成时间
@property (nonatomic,copy) NSString *redFinishTime;//": "2017-05-06 14:43:46.0",
@property (nonatomic,copy) NSString *type;//": "HOLD_PLAN",
///退出时间
@property (nonatomic,copy) NSString *endLockingTime;//": "1495283676000",
@property (nonatomic,copy) NSString *ID;//": "156688",
///财务子点ID
@property (nonatomic,copy) NSString *financeSubPointId;//": "1291978",
@property (nonatomic,copy) NSString *statusCode;//": "PURCHASE_END",
///最终金额
@property (nonatomic,copy) NSString *finalAmount;//": "50000.00",
@property (nonatomic,copy) NSString *category;//": "A",
///预期收益率
@property (nonatomic,copy) NSString *expectedRate;//": "4.50",
///计划名称
@property (nonatomic,copy) NSString *name;//": "安琪发布计划11",
@property (nonatomic,copy) NSString *subPointId;//": "1291978"
@end

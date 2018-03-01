//
//  HXBMYViewModel_MianPlanViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBMYModel_MainPlanModel_DataList;




///我的 plan 主界面的ViewModel
@interface HXBMYViewModel_MianPlanViewModel : NSObject
///viewModel里的数据Model
@property (nonatomic,strong) HXBMYModel_MainPlanModel_DataList *planModelDataList;
///请求的类型 （持有中， 正在推出， 已经推出）
@property (nonatomic,assign) HXBRequestType_MY_PlanRequestType requestType;
///UI展示的请求的类型 （持有中， 正在推出， 已经推出）
@property (nonatomic,copy) NSString *requestType_UI;
/// 相应后数据的状态
@property (nonatomic,assign) HXBRequestType_MY_PlanResponseStatus responseStatus;
/// 红利计划 的状态
@property (nonatomic,copy) NSString *status;
/**
 加入金额 (没有拼接（元）)
 */
@property (nonatomic,copy) NSString * finalAmount_NOTYUAN;
@property (nonatomic,copy) NSString * amount_NOTYUAN;
/**
 年利率
 */
@property (nonatomic,copy) NSString * expectedRate;

/**
 可用余额
 */
//@property (nonatomic,copy) NSString * availablePoint;
/**
收益方法
 */
@property (nonatomic,copy) NSString * profitType_UI;
/**
服务协议 button str
 */
@property (nonatomic,copy) NSString * contractName;
/**
 利率
 */
@property (nonatomic,copy) NSString * totalInterest;

/**
本期余额
 */
@property (nonatomic,copy) NSString * remainAmount;
/**
 用户余额
 */
@property (nonatomic,copy) NSString * userRemainAmount;
/**
 已获收益
 */
@property (nonatomic,copy) NSString * earnAmount_NOTYUAN;
@end

//
//  HXBMYViewModel_PlanDetailViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMYModel_PlanDetailModel.h"

/// 我的界面的 红利计划列表页 -》 计划详情页
@interface HXBMYViewModel_PlanDetailViewModel : NSObject
///红利计划 详情的Model
@property (nonatomic,strong) HXBMYModel_PlanDetailModel *planDetailModel;
///处理方式 （HXB:当日提取至红小宝账户，INVEST：收益再投资）
@property (nonatomic,copy) NSString *cashType;
///红利计划 状态
@property (nonatomic,copy) NSString *status;
/**
 status 对应的枚举
 1: 表示等待计息
 2: 表示受益中
 3: 表示退出中
 4: 表示已退出
 */
@property (nonatomic,assign) int statusInt;
/**
 ///红利计划 的种类 （收益中还是退出中 还是已退出）
 */
@property (nonatomic,copy) NSString * type;
/**
 合同
 */
@property (nonatomic,copy) NSString *contractName;
///收益方式
@property (nonatomic,copy) NSString *inComeLable_ConstStr;
/**
 加入日期
 */
@property (nonatomic,copy) NSString * addTime;
/**
 加入金额
 */
@property (nonatomic,copy) NSString * addAuomt;
/**
 期限
 */
@property (nonatomic,copy) NSString * lockTime;
/**
 已获收益
 */
@property (nonatomic,copy) NSString * earnAmount;
/**
 预期年率利
 */
@property (nonatomic,copy) NSString * expectedRate;
/**
 等待转让金额
 */
@property (nonatomic,copy) NSString * redProgressLeft;
/**
 退出时间
 */
@property (nonatomic,copy) NSString * endLockingTime;
/**
 追加按钮是否显示
 */
@property (nonatomic,assign) BOOL isAddButtonHidden;
@end

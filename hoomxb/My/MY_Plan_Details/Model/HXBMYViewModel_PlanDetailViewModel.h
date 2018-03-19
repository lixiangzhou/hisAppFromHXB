//
//  HXBMYViewModel_PlanDetailViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMYModel_PlanDetailModel.h"
static NSString *kHXBUI                 = @"当日提取至红小宝账户";
static NSString *kINVESTUI              = @"收益复投";
static NSString *kHXB                   = @"HXB";
static NSString *kINVEST                = @"INVEST";
static NSString *QUIT                   = @"可退出";
static NSString *ANNUL_QUIT             = @"撤销退出";
static NSString *STAY_QUIT              = @"待退出";
static NSString *PURCHASE_END           = @"锁定期";
static NSString *PURCHASEING            = @"债转匹配中";
static NSString *REDEMPTION_PERIOD      = @"开放期";



/// 我的界面的 红利计划列表页 -》 计划详情页
@interface HXBMYViewModel_PlanDetailViewModel : NSObject

///红利计划 详情的Model
@property (nonatomic,strong) HXBMYModel_PlanDetailModel *planDetailModel;

///红利计划 状态
@property (nonatomic,copy) NSString *status;
///红利计划 退出方式
@property (nonatomic,copy) NSString *exitWay;

/**
 status 对应的枚举
 1: 表示等待计息
 2: 表示受益中
 3: 表示退出中
 4: 表示已退出
 */
@property (nonatomic,assign) int statusInt;
///状态 （与账户外的一致）
@property (nonatomic,assign) kHXBEnum_Fin_Plan_UnifyStatus unifyStatus;
/**
 /// 红利计划 的种类 （收益中还是退出中 还是已退出）
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
/// 是否按月付息
@property (nonatomic, assign, getter=isMonthyPayment) BOOL monthyPayment;

#pragma mark --- 2.6.0计划退出
/**
 退出方式
 */
@property (nonatomic,copy) NSString *quitStatus;

/**
 退出日期
 */
@property (nonatomic,copy) NSString *quitDate;

/**
 可撤销退出截止日期
 */
@property (nonatomic,copy) NSString *repealDate;

/**
 退出按钮文案
 */
@property (nonatomic,copy) NSString *quitSubTitle;

/**
 退出状态
 */
@property (nonatomic,copy) NSString *leaveStatus;

/**
 状态图片名称
 */
@property (nonatomic,copy) NSString *statusImageName;

@end

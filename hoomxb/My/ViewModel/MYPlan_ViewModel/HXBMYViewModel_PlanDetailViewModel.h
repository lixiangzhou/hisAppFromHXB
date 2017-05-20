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
///合同
@property (nonatomic,copy) NSString *contractName;
@end

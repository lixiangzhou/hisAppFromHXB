//
//  HXBMyPlanDetailsExitResultModel.h
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBMyPlanDetailsExitResultModel : NSObject
/// 确认退出
@property (nonatomic,copy) NSString *endLockingTime; /// 计划退出时间
@property (nonatomic,copy) NSString *quitDesc;/// 退出成功文案描述

/// 冷静期
@property (nonatomic,copy) NSString *financePlanName;/// "红利计划-3个月 180201期"
@property (nonatomic,copy) NSString *desc;/// "您加入的红利计划-3个月 180201期已退出"

@end

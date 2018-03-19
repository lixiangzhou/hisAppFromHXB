//
//  HXBMyPlanDetailsExitResultModel.h
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBMyPlanDetailsExitResultModel : NSObject
@property (nonatomic,copy) NSString *endLockingTime; /// 计划退出时间
@property (nonatomic,copy) NSString *quitDesc;/// 退出成功文案描述
//@property (nonatomic,copy) NSString *exitType;/// 退出 还是 取消退出
@end

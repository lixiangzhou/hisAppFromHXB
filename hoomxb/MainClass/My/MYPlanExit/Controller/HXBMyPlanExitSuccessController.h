//
//  HXBMyPlanExitSuccessController.h
//  hoomxb
//
//  Created by lxz on 2018/3/13.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

typedef enum : NSUInteger {
    HXBMyPlanExitTypeCoolingOff = 1,  // 冷静期退出结果页
    HXBMyPlanExitTypeNormal,    // 正常退出结果页
} HXBMyPlanExitType;

@interface HXBMyPlanExitSuccessController : HXBBaseViewController
@property (nonatomic, assign) HXBMyPlanExitType exitType;
@property (nonatomic, copy) NSString *descString;
@property (nonatomic, copy) NSString *titleString;
@end

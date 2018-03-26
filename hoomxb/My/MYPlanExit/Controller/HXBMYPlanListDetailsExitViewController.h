//
//  HXBMYPlanListDetailsExitViewController
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
#import "HXBMyPlanDetailsExitViewModel.h"

@interface HXBMYPlanListDetailsExitViewController : HXBBaseViewController

@property (nonatomic,copy) NSString *planID; /// 需要接受planID
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,assign) BOOL inCoolingOffPeriod; /// 是否处于冷静期

@end

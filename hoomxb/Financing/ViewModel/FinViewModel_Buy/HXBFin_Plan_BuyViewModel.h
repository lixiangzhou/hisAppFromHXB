//
//  HXBFin_Plan_BuyViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBFinModel_BuyResoult_PlanModel.h"
@interface HXBFin_Plan_BuyViewModel : NSObject
@property (nonatomic,strong) HXBFinModel_BuyResoult_PlanModel *buyPlanModel;
///开始计息
@property (nonatomic,copy) NSString *lockStart;

@end

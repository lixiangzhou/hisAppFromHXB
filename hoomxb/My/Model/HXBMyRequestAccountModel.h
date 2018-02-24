//
//  HXBMyRequestAccountModel.h
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBMyRequestAccountModel : NSObject

@property (nonatomic,assign) double assetsTotal;//总资产
@property (nonatomic,assign) double earnTotal;//累计收益
@property (nonatomic,assign) double financePlanAssets;//红利计划-持有资产
@property (nonatomic,assign) double financePlanSumPlanInterest;//红利计划-累计收益
@property (nonatomic,assign) double lenderPrincipal;//散标债权-持有资产
@property (nonatomic,assign) double lenderEarned;//散标债权-累计收益
@property (nonatomic,assign) double availablePoint;//可用余额
@property (nonatomic,assign) long long availableCouponCount;//可用优惠券数量
/// 持有总资产
@property (nonatomic, strong) NSNumber *holdingTotalAssets;
@end

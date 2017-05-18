//
//  HxbHomePageModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "BaseModel.h"
//参数名	类型	说明
//assetsTotal	double	总资产
//earnTotal	double	累计收益
//financePlanAssets	double	红利计划-持有资产
//financePlanSumPlanInterest	double	红利计划-累计收益
//lenderPrincipal	double	散标债权-持有资产
//lenderEarned	double	散标债权-累计收益
//availablePoint	double	可用余额
//frozenPoint	double	冻结余额
@interface HxbHomePageModel : BaseModel

@property (nonatomic, assign) double assetsTotal;

@property (nonatomic, assign) double earnTotal;

@property (nonatomic, assign) double financePlanAssets;

@property (nonatomic, assign) double financePlanSumPlanInterest;

@property (nonatomic, assign) double lenderPrincipal;

@property (nonatomic, assign) double lenderEarned;

@property (nonatomic, assign) double availablePoint;

@property (nonatomic, assign) double frozenPoint;

@end

//
//  HXBRequestUserInfoViewModel.h
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBUserInfoModel.h"

///用户相关的VIewmode
@interface HXBRequestUserInfoViewModel : NSObject
@property (nonatomic,strong) HXBUserInfoModel *userInfoModel;

// --------------------- 拼接了元 ----------------------
///可用余额 以 元为后缀
@property (nonatomic,copy) NSString *availablePoint;
///总额
@property (nonatomic,copy) NSString * assetsTotal;
///计划资产
@property (nonatomic,copy) NSString * financePlanAssets;
///	红利计划-累计收益
@property (nonatomic,copy) NSString *financePlanSumPlanInterest;
///	散标债权-持有资产
@property (nonatomic,copy) NSString *lenderPrincipal;
///	散标债权-累计收益
@property (nonatomic,copy) NSString *lenderEarned;
///冻结余额
@property (nonatomic,copy) NSString *frozenPoint;
///累计收益
@property (nonatomic,copy) NSString *earnTotal;


// -------------------- 没有拼接元 ---------------------
///可用余额 以 元为后缀
@property (nonatomic,copy) NSString *availablePoint_NOTYUAN;
///总额
@property (nonatomic,copy) NSString * assetsTotal_NOTYUAN;
///计划资产
@property (nonatomic,copy) NSString * financePlanAssets_NOTYUAN;
///	红利计划-累计收益
@property (nonatomic,copy) NSString *financePlanSumPlanInterest_NOTYUAN;
///	散标债权-持有资产
@property (nonatomic,copy) NSString *lenderPrincipal_NOTYUAN;
///	散标债权-累计收益
@property (nonatomic,copy) NSString *lenderEarned_NOTYUAN;
///冻结余额
@property (nonatomic,copy) NSString *frozenPoint_NOTYUAN;
///累计收益
@property (nonatomic,copy) NSString *earnTotal_NOTYUAN;
@end

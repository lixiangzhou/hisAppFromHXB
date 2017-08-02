//
//  HXBRequestUserInfoViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestUserInfoViewModel.h"
#import "HXBRequestUserInfoViewModel.h"
#import "HXBUserInfoModel.h"

@implementation HXBRequestUserInfoViewModel
- (void)setUserInfoModel:(HXBUserInfoModel *)userInfoModel {
    _userInfoModel = userInfoModel;
//    [KeyChainManage sharedInstance].phone = userInfoModel.userInfo.mobile;
//    [KeyChainManage sharedInstance].userId = userInfoModel.userInfo.userId;
//    [KeyChainManage sharedInstance].userName = userInfoModel.userInfo.username;
//    [KeyChainManage sharedInstance].assetsTotal = userInfoModel.userAssets.assetsTotal;
//    [KeyChainManage sharedInstance].realName = userInfoModel.userInfo.realName;
//    [KeyChainManage sharedInstance].realId = userInfoModel.userInfo.idNo;
}

- (NSString *)availablePoint {
    if (!_availablePoint) {
        _availablePoint = [NSString hxb_getPerMilWithDouble:self.userInfoModel.userAssets.availablePoint.floatValue];
    }
    return _availablePoint;
}
/**
 总额
 */
- (NSString *) assetsTotal {
    if (!_assetsTotal) {
        _assetsTotal = [NSString hxb_getPerMilWithDouble:self.userInfoModel.userAssets.assetsTotal.floatValue];
    }
    return _assetsTotal;
}
/**
 计划资产
 */
- (NSString *) financePlanAssets {
    if (!_financePlanAssets) {
        _financePlanAssets = [NSString hxb_getPerMilWithDouble:self.userInfoModel.userAssets.financePlanAssets.floatValue];
    }
    return _financePlanAssets;
}

/**
 红利计划-累计收益
 */
- (NSString *) financePlanSumPlanInterest {
    if (!_financePlanSumPlanInterest) {
        if (self.userInfoModel.userAssets.financePlanSumPlanInterest.floatValue < 0) {
            self.userInfoModel.userAssets.financePlanSumPlanInterest = 0;
        }
        _financePlanSumPlanInterest = [NSString hxb_getPerMilWithDouble:self.userInfoModel.userAssets.financePlanSumPlanInterest.floatValue];
    }
    return _financePlanSumPlanInterest;
}
/**
散标债权-持有资产
 */
- (NSString *) lenderPrincipal {
    if (!_lenderPrincipal) {
        _lenderPrincipal = [NSString hxb_getPerMilWithDouble:self.userInfoModel.userAssets.lenderPrincipal.floatValue];
    }
    return _lenderPrincipal;
}
/**
散标债权-累计收益
 */
- (NSString *) lenderEarned {
    if (!_lenderEarned) {
        if (self.userInfoModel.userAssets.lenderEarned.floatValue < 0) {
            self.userInfoModel.userAssets.lenderEarned = 0;
        }
        _lenderEarned = [NSString hxb_getPerMilWithDouble:self.userInfoModel.userAssets.lenderEarned.floatValue];
    }
    return _lenderEarned;
}

/**
	冻结余额
 */
- (NSString *) frozenPoint {
    if (!_frozenPoint) {
        _frozenPoint = [NSString hxb_getPerMilWithDouble:self.userInfoModel.userAssets.frozenPoint.floatValue];
    }
    return _frozenPoint;
}
/**
 累计收益
 */
- (NSString *) earnTotal {
    if (!_earnTotal) {
        _earnTotal = [NSString hxb_getPerMilWithDouble:self.userInfoModel.userAssets.earnTotal.floatValue];
    }
    return _earnTotal;
}

@end

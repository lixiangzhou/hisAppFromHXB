//
//  HXBRequestUserInfoViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestUserInfoViewModel.h"
#import "HXBRequestUserInfoViewModel.h"
#import "HXBUserInfoModel.h"

@implementation HXBRequestUserInfoViewModel
- (void)setUserInfoModel:(HXBUserInfoModel *)userInfoModel {
    _userInfoModel = userInfoModel;
//    KeyChain.phone = userInfoModel.userInfo.mobile;
//    KeyChain.userId = userInfoModel.userInfo.userId;
//    KeyChain.userName = userInfoModel.userInfo.username;
//    KeyChain.assetsTotal = userInfoModel.userAssets.assetsTotal;
//    KeyChain.realName = userInfoModel.userInfo.realName;
//    KeyChain.realId = userInfoModel.userInfo.idNo;
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
        _lenderPrincipal = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.lenderPrincipal.floatValue];
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
        _lenderEarned = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.lenderEarned.floatValue];
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





// ------------------------------ 没有拼接元
- (NSString *)availablePoint_NOTYUAN {
    if (!_availablePoint_NOTYUAN) {
        _availablePoint_NOTYUAN = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.availablePoint.floatValue];
    }
    return _availablePoint_NOTYUAN;
}
/**
 总额
 */
- (NSString *) assetsTotal_NOTYUAN {
    if (!_assetsTotal_NOTYUAN) {
        _assetsTotal_NOTYUAN = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.assetsTotal.floatValue];
    }
    return _assetsTotal_NOTYUAN;
}
/**
 计划资产
 */
- (NSString *) financePlanAssets_NOTYUAN {
    if (!_financePlanAssets_NOTYUAN) {
        _financePlanAssets_NOTYUAN = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.financePlanAssets.floatValue];
    }
    return _financePlanAssets_NOTYUAN;
}

/**
 红利计划-累计收益
 */
- (NSString *) financePlanSumPlanInterest_NOTYUAN {
    if (!_financePlanSumPlanInterest_NOTYUAN) {
        if (self.userInfoModel.userAssets.financePlanSumPlanInterest.floatValue < 0) {
            self.userInfoModel.userAssets.financePlanSumPlanInterest = 0;
        }
        _financePlanSumPlanInterest_NOTYUAN = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.financePlanSumPlanInterest.floatValue];
    }
    return _financePlanSumPlanInterest_NOTYUAN;
}
/**
 散标债权-持有资产
 */
- (NSString *) lenderPrincipal_NOTYUAN {
    if (!_lenderPrincipal_NOTYUAN) {
        _lenderPrincipal_NOTYUAN = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.lenderPrincipal.floatValue];
    }
    return _lenderPrincipal_NOTYUAN;
}
/**
 散标债权-累计收益
 */
- (NSString *) lenderEarned_NOTYUAN {
    if (!_lenderEarned_NOTYUAN) {
        if (self.userInfoModel.userAssets.lenderEarned.floatValue < 0) {
            self.userInfoModel.userAssets.lenderEarned = 0;
        }
        _lenderEarned_NOTYUAN = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.lenderEarned.floatValue];
    }
    return _lenderEarned_NOTYUAN;
}

/**
	冻结余额
 */
- (NSString *) frozenPoint_NOTYUAN {
    if (!_frozenPoint_NOTYUAN) {
        _frozenPoint_NOTYUAN = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.frozenPoint.floatValue];
    }
    return _frozenPoint_NOTYUAN;
}
/**
 累计收益
 */
- (NSString *) earnTotal_NOTYUAN {
    if (!_earnTotal_NOTYUAN) {
        _earnTotal_NOTYUAN = [NSString GetPerMilWithDouble:self.userInfoModel.userAssets.earnTotal.floatValue];
    }
    return _earnTotal_NOTYUAN;
}
@end

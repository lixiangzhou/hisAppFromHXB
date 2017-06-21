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

@end

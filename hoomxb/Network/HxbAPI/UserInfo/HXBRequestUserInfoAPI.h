//
//  HXBRequestUserInfoAPI.h
//  hoomxb
//
//  Created by HXB on 2017/5/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"
@class HXBRequestUserInfoAPI_UserAssets,HXBRequestUserInfoAPI_UserInfo;

///用户详情
@interface HXBRequestUserInfoAPI : NYBaseRequest
///资金相关
@property (nonatomic,copy) HXBRequestUserInfoAPI_UserAssets *userAssets;
///用户相关
@property (nonatomic,copy) HXBRequestUserInfoAPI_UserInfo *userInfo;
- (void) downLoadUserInfoWithSeccessBlock: (void(^)(NYBaseRequest *request,HXBRequestUserInfoAPI *model))seccessBlock andFailure:(void(^)(NYBaseRequest *request, NSError *error))failureBlock;
@end


@interface HXBRequestUserInfoAPI_UserAssets : NSObject

///double	总资产
@property (nonatomic,copy) NSString *assetsTotal;
///double	累计收益
@property (nonatomic,copy) NSString *earnTotal;
///double	红利计划-持有资产
@property (nonatomic,copy) NSString *financePlanAssets;
///double	红利计划-累计收益
@property (nonatomic,copy) NSString *financePlanSumPlanInterest;
///double	散标债权-持有资产
@property (nonatomic,copy) NSString *lenderPrincipal;
///double	散标债权-累计收益
@property (nonatomic,copy) NSString *lenderEarned;
///double	可用余额
@property (nonatomic,copy) NSString *availablePoint;
///double	冻结余额
@property (nonatomic,copy) NSString *frozenPoint;
///": "0"
@property (nonatomic,copy) NSString *hasRecharge;
@end

@interface HXBRequestUserInfoAPI_UserInfo : NSObject
///int	用户id
@property (nonatomic,copy) NSString *userId;
///	String	用户名称
@property (nonatomic,copy) NSString *username;
///String	用户手机
@property (nonatomic,copy) NSString *mobile;
///String	是否安全认证 1：已安全认证，0：未安全认证
@property (nonatomic,copy) NSString *isIdPassed;
///int	上次登录时间
@property (nonatomic,copy) NSString *lastLoginTime;
///int	登录时间
@property (nonatomic,copy) NSString *loginTime;
///Bool	是否投资 true:
@property (nonatomic,copy) NSString *hasEverInvest;
///Bool	是否投资 true:
@property (nonatomic,copy) NSString *hasEverInvestLoan;
///Bool	是否投资 true:
@property (nonatomic,copy) NSString *hasEverInvestFinancePlan;
///int	是否绑卡 1：已绑卡， 0：未绑卡
@property (nonatomic,copy) NSString *hasBindCard;
@end

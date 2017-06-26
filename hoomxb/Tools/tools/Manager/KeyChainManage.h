//
//  KeyChainManage.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KeyChain [KeyChainManage sharedInstance]

@interface KeyChainManage : NSObject

/**
 *  获取KeyChainManage单例
 */
+ (instancetype)sharedInstance;
@property (nonatomic, copy) NSString  *token;
@property (nonatomic, assign, readonly) BOOL isLogin;
///手势密码
@property (nonatomic, copy) NSString  *gesturePwd;
///手势密码输入的次数
@property (nonatomic, copy) NSString  *gesturePwdCount;
/*
@property (nonatomic, copy) NSString  *token;
@property (nonatomic, copy) NSString  *phone;

@property (nonatomic, copy) NSString  *inviteCode;

@property (nonatomic, copy) NSString  *loginPwd;
///交易密码
@property (nonatomic, copy) NSString  *tradePwd;
///手势密码
@property (nonatomic, copy) NSString  *gesturePwd;
///手势密码输入的次数
@property (nonatomic, copy) NSString  *gesturePwdCount;
///身份证
@property (nonatomic, copy) NSString  *realId;           //!< 身份证
///姓名
@property (nonatomic, copy) NSString  *realName;//!<
///银行卡名
@property (nonatomic, copy) NSString  *defBankNum;
///头像url
@property (nonatomic, copy) NSString  *avatarImageURL;
///头像的data
@property (nonatomic, copy) NSData    *localAvatarImageData;

@property (nonatomic, strong) NSArray *bankNumArr;

@property (nonatomic, assign, readonly) BOOL isLogin;
///总资产
@property (nonatomic, strong) NSString *assetsTotal;



///	是否安全认证
@property (nonatomic,copy) NSString *isVerify;


///是否绑卡
@property (nonatomic,copy) NSString *isBindCard;
///isCashPasswordPassed
@property (nonatomic,copy) NSString *isCashPasswordPassed;
///isIdPassed	String	是否实名
@property (nonatomic,copy) NSString *isIdPassed;
///是否手机号
@property (nonatomic,copy) NSString *isMobilePassed;
///用户手机号
@property (nonatomic,copy) NSString *mobile;
///用户id
@property (nonatomic,copy) NSString *userId;
///username	String	用户名称
@property (nonatomic,copy) NSString *userName;
///真实姓名
@property (nonatomic,copy) NSString *realName;
///idNo
@property (nonatomic,copy) NSString *idNo;
 */

///	double	总资产
- (void)assetsTotalWithBlock: (void(^)(NSString *assetsTotal))assetsTotalWithBlock;

///	double	累计收益
- (void)earnTotalWithBlock: (void(^)(NSString *earnTotal))earnTotalBlock;

///	double	红利计划-持有资产
- (void)financePlanAssetsWithBlock: (void(^)(NSString *financePlanAssets))financePlanAssetsBlock;

///	double	红利计划-累计收益
- (void)financePlanSumPlanInterestWithBlock: (void(^)(NSString *financePlanSumPlanInterest))financePlanSumPlanInterestBlock;

///	double	散标债权-持有资产
- (void)lenderPrincipalWithBlock: (void(^)(NSString *lenderPrincipal))lenderPrincipalBlock;

///	double	散标债权-累计收益
- (void)lenderEarnedWithBlock: (void(^)(NSString *lenderEarned))lenderEarnedBlock;

///	double	可用余额;
- (void)availablePointWithBlock: (void(^)(NSString *availablePoint))availablePointBlock;

///	double	冻结余额
- (void)frozenPointWithBlock: (void(^)(NSString *frozenPoint))frozenPointBlock;

///userId	int	用户id
- (void)userIdWithBlock: (void(^)(NSString *userID))userIdBlock;

///用户名
- (void)userNameWithBlock: (void(^)(NSString *userName))userNameBlock;

///用户手机号
- (void)mobileWithBlock: (void(^)(NSString *mobile))userMobileBlock;

///isMobilePassed	String	是否手机号
- (void)isMobilePassedWithBlock: (void(^)(NSString *mobilePassed))mobilePassedBlock;

///isIdPassed	String	是否实名
- (void)isIdPassedWithBlock: (void(^)(NSString *isIdPassed))isIdPassedBlock;

///是否有交易密码
- (void)isCashPasswordPassedWithBlock: (void(^)(NSString *isCashPasswordPassed))isCashPasswordPassedBlock;

///是否绑卡;
- (void)isBindCardWithBlock: (void (^)(NSString *isBindCard))isBindCardBlock;

///	是否安全认证
- (void) isVerifyWithBlock: (void(^)(NSString *isVerify))isVerifyBlock;

///信息赋值
- (void) setValueWithUserInfoModel: (HXBRequestUserInfoViewModel *)userInfoViewModel;
/*
 储存号码
 */
- (void) setMobile:(NSString *)mobile;

- (void)removePassword;     //!< 移除密码

- (void)removeGesture;     //!< 移除手势密码

- (void)removeGesturePwdCount;//!< 移除手势密码可输入次数

- (void)removeToken;        //!< 移除token

- (BOOL)removeAllInfo;

- (void)signOut;      //!< 退出登录

- (void)removeMobile;       //!< 移除手机号

- (BOOL)isSwitchOn;         //!<手势密码是否开启

- (BOOL)hasBindBankcard;    //!<已经绑定了银行卡

- (void)printAllInfo;

- (BOOL)isInvest;

@end

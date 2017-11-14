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
@property (nonatomic, assign) BOOL isLogin;
///手势密码
@property (nonatomic, copy) NSString  *gesturePwd;
///手势密码输入的次数
@property (nonatomic, copy) NSString  *gesturePwdCount;

///记录修改登录密码的次数
@property (nonatomic, copy) NSString *siginCount;

///统一密文
@property (nonatomic, strong) NSString *ciphertext;

///用户手机号
@property (nonatomic,copy) NSString *mobile;
/**
 是否有网
 */
@property (nonatomic, assign) BOOL ishaveNet;
/**
 h5根地址
 */
@property (nonatomic, copy) NSString *h5host;

///是否登录
- (void)isLoginWithInRealTimeBlock: (void (^)(BOOL isLogin))isLoginInRealTimeBlock;

///    double    总资产
- (void)assetsTotalWithBlock: (void(^)(NSString *assetsTotal))assetsTotalWithBlock;

///    double    累计收益
- (void)earnTotalWithBlock: (void(^)(NSString *earnTotal))earnTotalBlock;

///    double    红利计划-持有资产
- (void)financePlanAssetsWithBlock: (void(^)(NSString *financePlanAssets))financePlanAssetsBlock;

///    double    红利计划-累计收益
- (void)financePlanSumPlanInterestWithBlock: (void(^)(NSString *financePlanSumPlanInterest))financePlanSumPlanInterestBlock;

///    double    散标债权-持有资产
- (void)lenderPrincipalWithBlock: (void(^)(NSString *lenderPrincipal))lenderPrincipalBlock;

///    double    散标债权-累计收益
- (void)lenderEarnedWithBlock: (void(^)(NSString *lenderEarned))lenderEarnedBlock;

///    double    可用余额;
- (void)availablePointWithBlock: (void(^)(NSString *availablePoint))availablePointBlock;

///    double    冻结余额
- (void)frozenPointWithBlock: (void(^)(NSString *frozenPoint))frozenPointBlock;

///userId    int    用户id
- (void)userIdWithBlock: (void(^)(NSString *userID))userIdBlock;

///用户名
- (void)userNameWithBlock: (void(^)(NSString *userName))userNameBlock;

///用户手机号
- (void)mobileWithBlock: (void(^)(NSString *mobile))userMobileBlock;

///isMobilePassed    String    是否手机号
- (void)isMobilePassedWithBlock: (void(^)(NSString *mobilePassed))mobilePassedBlock;

///isIdPassed    String    是否实名
- (void)isIdPassedWithBlock: (void(^)(NSString *isIdPassed))isIdPassedBlock;

///是否有交易密码
- (void)isCashPasswordPassedWithBlock: (void(^)(NSString *isCashPasswordPassed))isCashPasswordPassedBlock;

///是否绑卡;
- (void)isBindCardWithBlock: (void (^)(NSString *isBindCard))isBindCardBlock;

///    是否安全认证
- (void) isVerifyWithBlock: (void(^)(NSString *isVerify))isVerifyBlock;

/// 用户信息的请求
- (void)downLoadUserInfoWithSeccessBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure: (void(^)(NSError *error))failure;
/// 用户信息的请求-无加载状态
- (void)downLoadUserInfoNoHUDWithSeccessBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure: (void(^)(NSError *error))failure;

- (void)removePassword;     //!< 移除密码

- (void)removeGesture;     //!< 移除手势密码

/// 验证手势密码是否有效
- (BOOL)validateGesturePwd;

- (void)removeGesturePwdCount;//!< 移除手势密码可输入次数

- (void)removeToken;        //!< 移除token

- (BOOL)removeAllInfo;

- (void)removeCiphertext; //!< 移除密文

- (void)signOut;      //!< 退出登录

- (void)removeMobile;       //!< 移除手机号

- (BOOL)isSwitchOn;         //!<手势密码是否开启

- (BOOL)hasBindBankcard;    //!<已经绑定了银行卡

- (BOOL)isInvest;

@end

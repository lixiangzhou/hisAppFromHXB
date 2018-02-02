//
//  KeyChainManage.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KeyChain [KeyChainManage sharedInstance]

// 是否忽略手势密码
#define kHXBGesturePwdSkipeYES @"kHXBGesturePwdSkipeYES"
#define kHXBGesturePwdSkipeNO @"kHXBGesturePwdSkipeNO"


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

/// 是否忽略手势密码，值为 kHXBGesturePwdSkipeYES，或 kHXBGesturePwdSkipeNO
@property (nonatomic, copy) NSString *skipGesture;

/// 是否弹窗过忽略手势密码
@property (nonatomic, assign) BOOL skipGestureAlertAppeared;

/**
 是否是新手
 */
@property (nonatomic, copy) NSString* isNewbie;

/**
 2.5.0新增首页底部标题
 */
@property (nonatomic, copy) NSString *baseTitle;

/// 用户信息的请求
- (void)downLoadUserInfoWithSeccessBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure: (void(^)(NSError *error))failure;
/// 用户信息的请求-无加载状态
- (void)downLoadUserInfoNoHUDWithSeccessBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure: (void(^)(NSError *error))failure;

- (void)removeGesture;     //!< 移除手势密码

- (void)removeToken;        //!< 移除token

- (BOOL)removeAllInfo;

- (void)signOut;      //!< 退出登录

@end

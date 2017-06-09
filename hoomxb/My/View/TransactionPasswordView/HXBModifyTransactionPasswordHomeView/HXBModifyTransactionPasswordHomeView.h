//
//  HXBModifyTransactionPasswordHomeView.h
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBUserInfoModel;
@interface HXBModifyTransactionPasswordHomeView : UIView


/**
 数据模型
 */
@property (nonatomic, strong) HXBUserInfoModel *userInfoModel;
/**
 获取验证码回调的方法
 */
@property (nonatomic, copy) void(^getValidationCodeButtonClickBlock)(NSString *IDCard);
/**
 下一步按点击回调的Block
 */
@property (nonatomic, copy) void(^nextButtonClickBlock)(NSString *idCardNo,NSString *verificationCode);
/**
 身份证验证成功
 */
- (void)idcardWasSuccessfully;
/**
 发送验证码失败
 */
- (void)sendCodeFail;
@end

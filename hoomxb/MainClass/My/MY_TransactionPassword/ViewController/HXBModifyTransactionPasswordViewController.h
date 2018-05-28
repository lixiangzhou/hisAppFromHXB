//
//  HXBModifyTransactionPasswordViewController.h
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBUserInfoModel;
typedef enum : NSInteger {
    /// 修改交易密码
    HXBModifyTransactionPasswordType,
    /// 解绑原手机号
    HXBModifyPhoneType
} HXBModifyTransactionPasswordORModifyPhoneType;

@interface HXBModifyTransactionPasswordViewController : HXBBaseViewController
@property (nonatomic,assign) HXBModifyTransactionPasswordORModifyPhoneType type;
@property (nonatomic, strong) HXBUserInfoModel *userInfoModel;

@end

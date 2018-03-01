//
//  HXBAccountSecureCell.h
//  hoomxb
//
//  Created by lxz on 2017/12/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBottomLineTableViewCell.h"

typedef NS_ENUM(NSUInteger, HXBAccountSecureType) {
    HXBAccountSecureTypeModifyPhone,    // 修改手机号
    HXBAccountSecureTypeLoginPwd,   // 登录密码
    HXBAccountSecureTypeTransactionPwd, // 交易密码
    HXBAccountSecureTypeGesturePwdModify, // 修改手势密码
    HXBAccountSecureTypeGesturePwdSwitch, // 手势密码开关
};

typedef void(^HXBHXBAccountSecureSwitchBlock)(BOOL);

@interface HXBAccountSecureModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) HXBAccountSecureType type;
@property (nonatomic, copy) HXBHXBAccountSecureSwitchBlock switchBlock;
@end

#define HXBAccountSecureCellID @"HXBAccountSecureCellID"

@interface HXBAccountSecureCell : HXBBottomLineTableViewCell
@property (nonatomic, strong) HXBAccountSecureModel *model;
@end

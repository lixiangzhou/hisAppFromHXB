//
//  HXBCheckLoginPasswordViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/29.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"


/// 手势密码开关类型
typedef NS_ENUM(NSUInteger, HXBAccountSecureSwitchType) {
    HXBAccountSecureSwitchTypeNone,     // 无
    HXBAccountSecureSwitchTypeOn,       // 开
    HXBAccountSecureSwitchTypeOff,      // 关
    HXBAccountSecureSwitchTypeChange,   // 修改
};


@interface HXBCheckLoginPasswordViewController : HXBBaseViewController
@property (nonatomic, assign) HXBAccountSecureSwitchType switchType;
@end

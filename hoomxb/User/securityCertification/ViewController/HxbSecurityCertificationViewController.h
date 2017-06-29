//
//  HxbSecurityCertificationViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
///安全认证
@interface HxbSecurityCertificationViewController : HXBBaseViewController

/**
 用户信息模型
 */
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;

///要pop到那个控制器
@property (nonatomic, copy) NSString *popToClass;
@end

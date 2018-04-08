//
//  HXBAccount_AlterLoginPassword_ViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"//枚举管理类

///修改登录密码
@interface HXBAccount_AlterLoginPassword_ViewController : HXBBaseViewController
@property (nonatomic,assign) HXBSignUPAndLoginRequest_sendSmscodeType type;
@end

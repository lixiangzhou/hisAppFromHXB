//
//  HXBSendSmscodeViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
#import "HXBSignUPAndLoginRequest.h"
///短信验证 VC
@interface HXBSendSmscodeViewController : HXBBaseViewController
///电弧号码
@property (nonatomic,copy) NSString *phonNumber;
///图验 码
@property (nonatomic,copy) NSString *captcha;
///设置密码的类型
@property (nonatomic,assign) HXBSignUPAndLoginRequest_sendSmscodeType type;
@end

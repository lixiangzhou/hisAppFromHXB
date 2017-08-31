//
//  HXBOpenDepositAccountViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"
@interface HXBOpenDepositAccountViewController : HXBBaseViewController

/**
 用来判断是充值还是提现
 */
@property (nonatomic, assign) HXBRechargeAndWithdrawalsLogicalJudgment type;
//用户信息
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userModel;

@end

//
//  HxbWithdrawCardViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
#import "HXBSignUPAndLoginRequest_EnumManager.h"

typedef void(^returnBlindCardResult)(BOOL isBlindSuccess);

@class HXBBankCardModel;
///银行卡绑定
@interface HxbWithdrawCardViewController : HXBBaseViewController


/**
 type
 */
@property (nonatomic, assign) HXBRechargeAndWithdrawalsLogicalJudgment type;
/**
 提现金额
 */
@property (nonatomic, copy) NSString *amount;
// 返回是否绑卡成功的block
@property (nonatomic, copy) returnBlindCardResult block;

@property (nonatomic, strong) HXBUserInfoModel *userInfoModel;
/**
 返回的页面类名
 */
@property (nonatomic, copy) NSString *className;

@end

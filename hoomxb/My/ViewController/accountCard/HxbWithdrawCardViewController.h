//
//  HxbWithdrawCardViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class HXBBankCardModel;
///银行卡绑定
@interface HxbWithdrawCardViewController : HXBBaseViewController
/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@property (nonatomic, strong) HXBUserInfoModel *userInfoModel;
@end

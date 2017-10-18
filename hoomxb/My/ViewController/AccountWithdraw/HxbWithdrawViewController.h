//
//  HxbWithdrawViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class HXBBankCardModel;
@interface WithdrawBankView : UIView
/**
 数据模型
 */
@property (nonatomic, strong) HXBBankCardModel *bankCardModel;
@end
@interface HxbWithdrawViewController : HXBBaseViewController
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@end

//
//  HXBMyTopUpBaseView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMyTopUpBankView;
@interface HXBMyTopUpBaseView : UIView


/**
 充值金额
 */
@property (nonatomic, copy) NSString *amount;

/**
 银行卡视图
 */
@property (nonatomic, strong) HXBMyTopUpBankView *mybankView;

/**
 可用金额
 */
@property (nonatomic, strong) HXBRequestUserInfoViewModel *viewModel;
/**
 点击充值按钮的block
 */
@property (nonatomic, copy) void(^rechargeBlock)();

@end

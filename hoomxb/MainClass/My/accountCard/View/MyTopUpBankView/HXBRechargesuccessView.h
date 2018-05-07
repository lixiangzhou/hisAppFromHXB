//
//  HXBRechargesuccessView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBRechargesuccessView : UIView

/**
 充值金额
 */
@property (nonatomic, copy) NSString *amount;

/**
 继续充值
 */
@property (nonatomic, copy) void(^continueRechargeBlock)();

/**
 立即投资
 */
@property (nonatomic, copy) void(^immediateInvestmentBlock)();

- (void)setTitle:(NSString *)title descString:(NSString *)descString;

@end

//
//  HXBRechargeCompletedViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@interface HXBRechargeCompletedViewController : HXBBaseViewController

@property (nonatomic, strong) NSDictionary *responseObject;

/**
 充值金额
 */
@property (nonatomic, copy) NSString *amount;

@end

//
//  HXBDepositoryAlertViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/8/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@interface HXBDepositoryAlertViewController : HXBBaseViewController

/**
 立即开通存管
 */
@property (nonatomic, copy) void (^immediateOpenBlock)();

@end

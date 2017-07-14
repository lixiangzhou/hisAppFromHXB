//
//  HXBMyTopUpBaseView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/6.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBMyTopUpBaseView : UIView

/**
 点击充值按钮的block
 */
@property (nonatomic, copy) void(^rechargeBlock)();

@end

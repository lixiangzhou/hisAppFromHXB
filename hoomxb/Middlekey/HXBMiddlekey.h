//
//  HXBMiddlekey.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBMiddlekey : NSObject

/**
 存管的逻辑
 */
+ (void)depositoryJumpLogicWithNAV:(UINavigationController *)nav;

/**
 充值够没的逻辑
 */
+ (void)rechargePurchaseJumpLogicWithNAV:(UINavigationController *)nav;

@end

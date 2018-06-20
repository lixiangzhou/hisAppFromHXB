//
//  HxbAdvertiseViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

///广告的VC
@interface HxbAdvertiseViewController : UIViewController

/// 自动消失的回调
@property (nonatomic, copy) void(^dismissBlock)();

- (void)addTimer;
@end

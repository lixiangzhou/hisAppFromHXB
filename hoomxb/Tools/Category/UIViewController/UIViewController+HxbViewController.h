//
//  UIViewController+HxbViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HxbViewController)
- (void)hxb_addChildController:(UIViewController *)childController intoView:(UIView *)view;
@end

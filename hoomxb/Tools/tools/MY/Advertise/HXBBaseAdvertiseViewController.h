//
//  HXBBaseAdvertiseViewController.h
//  hoomxb
//
//  Created by HXB on 2017/5/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
///关于广告加载的工具类
@interface HXBBaseAdvertiseViewController : UIViewController

@property (nonatomic, copy) NSString *adUrl;
///dismiss
- (void) dismissAdvertiseViewControllerFunc: (void(^)())dismissAdvertiseViewControllerBlock;
@end

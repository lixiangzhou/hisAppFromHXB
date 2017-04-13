//
//  HXBBaseViewController.h
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseViewController : UIViewController
//活动或者官方类型通知 被点击后，串来的url 跳转webView
@property (nonatomic,strong) NSURL *pushURL;
@property (nonatomic,copy) NSString *typeTitle;
@end

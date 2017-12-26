//
//  HxbAccountInfoViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
///账户界面
@interface HxbAccountInfoViewController : HXBBaseViewController
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@property (nonatomic, assign) BOOL isDisplayAdvisor;// 是否有理财顾问
@end

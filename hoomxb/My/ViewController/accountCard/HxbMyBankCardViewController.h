//
//  HxbMyBankCardViewController.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

///账户安全
@interface HxbMyBankCardViewController : HXBBaseViewController

/**
 是否显示银行卡界面
 */
@property (nonatomic, assign) BOOL isBank;
@property (nonatomic, copy) NSString *isCashPasswordPassed;//是否有交易密码
// 返回的页面类名
@property (nonatomic, copy) NSString *className;

@end

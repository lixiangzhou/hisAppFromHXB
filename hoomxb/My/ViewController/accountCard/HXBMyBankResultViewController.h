//
//  HXBMyBankResultViewController.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/29.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@interface HXBMyBankResultViewController : HXBBaseViewController

// 是否解绑成功
@property (nonatomic,assign) BOOL isSuccess; // 解绑成功传 YES  失败传 NO
// 错误描述
@property (nonatomic,copy) NSString *describeText;

@end

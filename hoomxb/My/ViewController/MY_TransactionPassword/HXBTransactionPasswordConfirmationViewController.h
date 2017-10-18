//
//  HXBTransactionPasswordConfirmationViewController.h
//  修改交易密码
//
//  Created by HXB-C on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBTransactionPasswordConfirmationViewController : HXBBaseViewController

/**
 身份证号码
 */
@property (nonatomic, copy) NSString *idcard;
/**
 验证码
 */
@property (nonatomic, copy) NSString *code;


@end

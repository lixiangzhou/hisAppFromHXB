//
//  HxbSecurityCertificationView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HxbSecurityCertificationView : UIView

/**
 用户信息模型
 */
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;

/**安全认证 点击了下一步按钮*/
- (void)clickNextButtonFuncWithBlock: (void(^)(NSString *name, NSString *idCard, NSString *transactionPassword,NSString *url))clickNextButtonBlock;
@end

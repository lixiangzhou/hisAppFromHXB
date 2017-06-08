//
//  HXBCheckCaptchaViewController.h
//  hoomxb
//
//  Created by HXB on 2017/6/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
///modal 出来的校验码
@interface HXBCheckCaptchaViewController : HXBBaseViewController
- (void)checkCaptchaSucceedFunc: (void(^)(NSString *checkPaptcha))isCheckCaptchaSucceedBlock;
@end

//
//  HXBAccount_AlterLoginPassword_View.h
//  hoomxb
//
//  Created by HXB on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBAccount_AlterLoginPassword_View : UIView
////点击了确认修改密码
- (void)clickAlterButtonWithBlock: (void(^)(NSString *password_Original, NSString *password_New))clickAlterButtonBlock;
@end

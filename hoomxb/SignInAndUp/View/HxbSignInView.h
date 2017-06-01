//
//  HxbSignInView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HxbSignInView : UIView
//点击事件的传递
///点击了登录按钮
- (void) signIN_ClickButtonFunc: (void(^)(NSString *pasword))clickSignInButtonBlock;
///点击了注册按钮
- (void) signUP_clickButtonFunc: (void(^)())clickSignUPButtonBlock;
@end

//
//  HXBSendSmscodeView.h
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBSendSmscodeView : UIView
@property (nonatomic, copy) NSString *phonNumber;
///点击了确认
- (void)clickSetPassWordButtonFunc: (void(^)(NSString *password, NSString *smscode,NSString *inviteCode))clickSetPassWordButtonBlock;
///点击了发送短信验证码按钮
- (void)clickSendSmscodeButtonWithBlock: (void(^)())clickSendSmscodeButtonBlock;
@end

//
//  HXBSendSmscodeView.h
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBSignUPAndLoginRequest_EnumManager.h"
@interface HXBSendSmscodeView : UIView
// 是否点击的是发送语音
@property (nonatomic, assign) BOOL isSendSpeechCode;
@property (nonatomic, copy) NSString *phonNumber;
@property (nonatomic,assign) HXBSignUPAndLoginRequest_sendSmscodeType type;
//是否有语音验证码
//@property (nonatomic, assign) BOOL isSpeechVerificationCode;
@property (nonatomic, assign) BOOL startsCountdown;

///点击了确认
- (void)clickSetPassWordButtonFunc: (void(^)(NSString *password, NSString *smscode,NSString *inviteCode))clickSetPassWordButtonBlock;
///点击了发送短信验证码按钮
- (void)clickSendSmscodeButtonWithBlock: (void(^)())clickSendSmscodeButtonBlock;
///点击了服务协议
- (void)clickAgreementSignUPWithBlock: (void(^)())clickAgreementSignUPBlock;
///点击了发送按钮
- (void)clickSendButton: (UIButton *)button;
@end

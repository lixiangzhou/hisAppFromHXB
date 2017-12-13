//
//  HXBRegisterAlertVC.h
//  hoomxb
//
//  Created by hxb on 2017/11/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBRegisterAlertVC : UIViewController

@property (nonatomic, copy) NSString *type;//标识
/**
 messagetitle
 */
@property (nonatomic, copy) NSString *messageTitle;

/**
 子标题
 */
@property (nonatomic, copy) NSString *subTitle;

- (void)verificationCodeBtnWithBlock:(void (^)())getVerificationCodeBlock;
- (void)speechVerificationCodeBtnWithBlock:(void (^)())getSpeechVerificationCodeBlock;
- (void)cancelBtnWithBlock:(void (^)())cancelBtnClickBlock;

@end

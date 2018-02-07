//
//  HXBModifyPhoneViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBModifyPhoneModel.h"

@interface HXBModifyPhoneViewModel : HXBBaseViewModel
@property (nonatomic,strong)HXBModifyPhoneModel *modifyPhoneModel;

/**
 修改手机号
 
 @param newPhoneNumber 新的手机号码
 @param newsmscode 短信验证码
 @param captcha 图验
 */
- (void)mobifyPhoneNumberWithNewPhoneNumber:(NSString *)newPhoneNumber andWithNewsmscode:(NSString *)newsmscode  andWithCaptcha:(NSString *)captcha andSuccessBlock: (void(^)(BOOL isSuccess))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end

//
//  HXBSecurityCertificationViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/2/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"

@interface HXBSecurityCertificationViewModel : HXBBaseViewModel

/*
 name    是    string    真实姓名
 idCardNo    是    string    身份证号
 tradpwd    否    string    交易密码
 **/
- (void)securityCertification_RequestWithName: (NSString *)name
                                  andIdCardNo: (NSString *)idCardNo
                                   andTradpwd: (NSString *)tradpwd
                                       andURL: (NSString *)URL
                              andSuccessBlock: (void(^)(BOOL isExist))successBlock
                              andFailureBlock: (void(^)(NSError *error,NSString *message))failureBlock;


@end


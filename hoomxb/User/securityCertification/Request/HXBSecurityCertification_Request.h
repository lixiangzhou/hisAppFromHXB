//
//  HXBSecurityCertification_Request.h
//  hoomxb
//
//  Created by HXB on 2017/6/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBSecurityCertification_Request : NSObject
/*
name	是	string	真实姓名
idCardNo	是	string	身份证号
tradpwd	否	string	交易密码
 **/
+ (void)securityCertification_RequestWithName: (NSString *)name
                                  andIdCardNo: (NSString *)idCardNo
                                   andTradpwd: (NSString *)tradpwd
                              andSuccessBlock: (void(^)(BOOL isExist))successBlock
                              andFailureBlock: (void(^)(NSError *error,NSString *message))failureBlock;
@end

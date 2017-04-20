//
//  LoginAPI.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"

@interface LoginAPI : NYBaseRequest
- (id)initWithUserName:(NSString *)userName loginPwd:(NSString *)loginPwd;
@end

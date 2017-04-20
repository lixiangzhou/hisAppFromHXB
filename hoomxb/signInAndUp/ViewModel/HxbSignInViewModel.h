//
//  HxbSignInViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYBaseRequest.h"

@interface HxbSignInViewModel : NSObject
- (void)signInRequestWithUserName:(NSString *)userName Password:(NSString *)password SuccessBlock:(void(^)(BOOL login,  NSString *message))success FailureBlock:(void(^)(NYBaseRequest *request, NSError *error))failure;
@end

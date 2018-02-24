//
//  HXBRequestUserInfo.h
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestUserInfoViewModel.h"
#import "NYBaseRequest.h"

@interface HXBRequestUserInfo : NSObject
///请求数据
+ (void) downLoadUserInfoWithSeccessBlock: (void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure:(void(^)( NSError *error))failureBlock;

+ (void)downLoadUserInfoNoHUDWithSeccessBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure: (void(^)(NSError *error))failureBlock;

/**
 新增请求用户信息
 
 @param requestBlock 请求回调， 补充request的参数
 @param resultBlock 结果回调
 */
- (void)downLoadUserInfoWithResultBlock:(void(^)(NYBaseRequest* request)) requestBlock resultBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel, NSError *error))resultBlock;

+ (void) signOut;
@end

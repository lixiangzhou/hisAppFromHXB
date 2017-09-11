//
//  HXBRequestUserInfo.h
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestUserInfoViewModel.h"
@interface HXBRequestUserInfo : NSObject
///请求数据
+ (void) downLoadUserInfoWithSeccessBlock: (void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure:(void(^)( NSError *error))failureBlock;

+ (void)downLoadUserInfoNoHUDWithSeccessBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure: (void(^)(NSError *error))failureBlock;

+ (void) signOut;
@end

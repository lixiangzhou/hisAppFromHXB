//
//  HXBVersionUpdateRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBVersionUpdateRequest : NSObject
/**
 版本更新
 
 @param versionCode app当前版本号
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)versionUpdateRequestWitversionCode:(NSString *)versionCode andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 公告

 @param isUPReloadData 是否为下拉加载
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)noticeRequestWithisUPReloadData:(BOOL)isUPReloadData andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
@end

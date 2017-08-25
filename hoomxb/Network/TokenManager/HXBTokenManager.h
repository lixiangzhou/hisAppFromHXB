//
//  HXBTokenManager.h
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

///token的key
static NSString *const kHXBToken_X_HxbAuth_Token = @"X-Hxb-Auth-Token";
///请求下数据后的字典中的key
static NSString *const kHXBDownLoadTokenKey = @"data";
///token 默认的URL string
static NSString *const kHXBTokenURL = @"http://192.168.1.21:3000/token";

@interface HXBTokenManager : NSObject
/**
 * 关于token的下载
 * @param urlStr token 的地址 （默认 kHXBDownLoadTokenKey http://192.168.1.21:3000/token）
 * @param downLoadTokenSucceedBlock 成功的回调
 * @param failureBlock 失败的回调
 */
+ (void)downLoadTokenWithURL: (NSString *)urlStr andDownLoadTokenSucceedBlock: (void(^)(NSString *token))downLoadTokenSucceedBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
@end

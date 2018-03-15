//
//  HXBCheckCaptchaViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBCheckCaptchaViewModel.h"
#import "NSDate+HXB.h"
#import "HXBBaseUrlManager.h"
#import "HXBTokenManager.h"

@implementation HXBCheckCaptchaViewModel

- (void)captchaRequestWithResultBlock:(void (^)(BOOL))resultBlock
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *URLSTR = [NSString stringWithFormat:@"%@%@",[HXBBaseUrlManager manager].baseUrl,@"/captcha"];
    NSURL *url = [NSURL URLWithString:URLSTR];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *requestM = [request mutableCopy];
    // 配置userAgent
    NSString *systemVision = [[UIDevice currentDevice] systemVersion];
    NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *userAgent = [NSString stringWithFormat:@"%@/IOS %@/v%@ iphone" ,[HXBDeviceVersion deviceVersion],systemVision,version];
    [requestM addValue:userAgent forHTTPHeaderField:X_Hxb_User_Agent];
    [requestM addValue:[NSDate milliSecondSince1970] forHTTPHeaderField:@"X-Hxb-Auth-Timestamp"];
    [requestM addValue:KeyChain.token forHTTPHeaderField: kHXBToken_X_HxbAuth_Token];
    requestM.HTTPMethod = @"GET";
    // 配置token
    // 创建请求
    kWeakSelf
    NSURLSessionTask *task = [session dataTaskWithRequest:requestM.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.captchaImage = [UIImage imageWithData:data];
                if (resultBlock) {
                    resultBlock(YES);
                }
            });
        }else if(error) {
            // 请求token
            [HXBTokenManager downLoadTokenWithURL:nil andDownLoadTokenSucceedBlock:^(NSString *token) {
                // 再请求一次
                // 添加token
                [requestM addValue:kHXBToken_X_HxbAuth_Token forHTTPHeaderField: KeyChain.token];
                NSURLSessionTask *task = [session dataTaskWithRequest:requestM.copy completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if (data) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakSelf.captchaImage = [UIImage imageWithData:data];
                            if (resultBlock) {
                                resultBlock(YES);
                            }
                        });
                    }
                }];
                [task resume];
            } andFailureBlock:^(NSError *error) {
                if (resultBlock) {
                    resultBlock(NO);
                }
            }];
        }
    }];
    [task resume];
}

- (void)checkCaptchaRequestWithCaptcha:(NSString *)captcha resultBlock:(void (^)(BOOL, BOOL))resultBlock
{
    NYBaseRequest *checkCaptchaAPI = [[NYBaseRequest alloc]initWithDelegate:self];
    checkCaptchaAPI.requestUrl = kHXBUser_checkCaptchaURL;
    checkCaptchaAPI.requestMethod = NYRequestMethodPost;
    checkCaptchaAPI.requestArgument = @{
                                        @"captcha" : captcha///图验Code
                                        };
    [checkCaptchaAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (resultBlock) {
            resultBlock(YES, NO);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO, YES);
        }
    }];
}

@end

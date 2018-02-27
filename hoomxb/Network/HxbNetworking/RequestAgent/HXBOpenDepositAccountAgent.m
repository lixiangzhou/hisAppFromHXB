//
//  HXBOpenDepositAccountAgent.m
//  hoomxb
//
//  Created by caihongji on 2018/2/6.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBOpenDepositAccountAgent.h"
#import "NYBaseRequest.h"
#import "HXBCardBinModel.h"
@implementation HXBOpenDepositAccountAgent


/**
 卡bin校验
 
 @param requestBlock 请求配置的block
 @param resultBlock 请求结果回调的block
 */
+ (void)checkCardBinResultRequestWithResultBlock:(void(^)(NYBaseRequest* request)) requestBlock resultBlock:(void(^)(HXBCardBinModel *cardBinModel, NSError *error))resultBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBUser_checkCardBin;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    if (requestBlock) {
        requestBlock(versionUpdateAPI);
    }
    [versionUpdateAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        
        HXBCardBinModel *cardBinModel = [HXBCardBinModel yy_modelWithDictionary:responseObject[@"data"]];
        if (resultBlock) {
            resultBlock(cardBinModel,nil);
        }

    } failure:^(NYBaseRequest *request, NSError *error) {
        
        if (request.responseObject) {
            error = [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject];
        }
        if (resultBlock) {
            resultBlock(nil,error);
        }
        
    }];
    
}

/**
 获取短信验证码和语音验证码
 
 @param requestBlock 请求配置的block
 @param resultBlock 请求结果回调的block
 */
+ (void)verifyCodeRequestWithResultBlock:(void(^)(NYBaseRequest* request)) requestBlock resultBlock:(void(^)(id responseObject, NSError *error))resultBlock {
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBUser_smscodeURL;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    if (requestBlock) {
        requestBlock(versionUpdateAPI);
    }
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if (resultBlock) {
            resultBlock(responseObject,nil);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (request.responseObject) {
            error = [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject];
        }
        if (resultBlock) {
            resultBlock(nil,error);
        }
    }];
}

@end

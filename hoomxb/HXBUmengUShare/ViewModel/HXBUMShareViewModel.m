//
//  HXBUMShareViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/15.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUMShareViewModel.h"
#import "HXBUMShareModel.h"
@implementation HXBUMShareViewModel



- (NSString *)getShareLink:(UMSocialPlatformType)type {
    switch (type) {
        case UMSocialPlatformType_WechatSession:
            return self.shareModel.wechat;
        case UMSocialPlatformType_WechatTimeLine:
            return self.shareModel.moments;
        case UMSocialPlatformType_QQ:
            return self.shareModel.qq;
        case UMSocialPlatformType_Qzone:
            return self.shareModel.qzone;
        default:
            break;
    }
    return @"";
}

/**
 获取分享数据
 
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)UMShareRequestSuccessBlock: (void(^)(HXBUMShareViewModel * shareViewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock {
    NYBaseRequest *umShareAPI = [[NYBaseRequest alloc] init];
    umShareAPI.requestUrl = kHXBUMShareURL;
    umShareAPI.requestMethod = NYRequestMethodPost;
    [umShareAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        
        NSInteger status =  [responseObject[kResponseStatus] integerValue];
        if (status != 0) {
            if ((status != kHXBCode_Enum_ProcessingField)) {
                [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
            }
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
        }
        self.shareModel = [HXBUMShareModel yy_modelWithDictionary:responseObject[kResponseData]];
        if (successDateBlock) {
            successDateBlock(self);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end

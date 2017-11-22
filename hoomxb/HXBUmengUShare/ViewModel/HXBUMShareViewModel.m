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
    NSString *shareURL = @"";
    switch (type) {
        case UMSocialPlatformType_WechatSession:
            shareURL = self.shareModel.wechat;
            [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_invite_weChat];
            break;
        case UMSocialPlatformType_WechatTimeLine:
            shareURL = self.shareModel.moments;
            [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_invite_friendCircle];
            break;
        case UMSocialPlatformType_QQ:
            shareURL = self.shareModel.qq;
            [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_invite_QQ];
            break;
        case UMSocialPlatformType_Qzone:
            shareURL = self.shareModel.qzone;
            [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_invite_QQSpace];
            break;
        default:
            break;
    }
    shareURL = [NSString stringWithFormat:@"%@%@",KeyChain.h5host,shareURL];
    return shareURL;
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
    umShareAPI.requestArgument = @{@"action":@"buy"};
                             
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

//
//  HXBUMShareViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/15.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBUMShareViewModel.h"
#import "HXBUMShareModel.h"

@interface HXBUMShareViewModel()<HXBRequestHudDelegate>
@end
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
 */
- (void)UMShareresultBlock: (void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    NYBaseRequest *umShareAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    umShareAPI.requestUrl = kHXBUMShareURL;
    umShareAPI.requestMethod = NYRequestMethodPost;
    umShareAPI.requestArgument = @{@"action":@"buy"};
    
    [umShareAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        weakSelf.shareModel = [HXBUMShareModel yy_modelWithDictionary:responseObject[kResponseData]];
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

#pragma mark - 分享失败回调文案
- (void)sharFailureStringWithCode:(NSInteger)code {
    NSString *errorMessage = @"";
    switch (code) {
        case UMSocialPlatformErrorType_Unknow:
            errorMessage = @"未知错误";
            break;
        case UMSocialPlatformErrorType_NotSupport:
            errorMessage = @"客户端版本不支持";
            break;
        case  UMSocialPlatformErrorType_AuthorizeFailed:
            errorMessage = @"授权失败";
            break;
        case UMSocialPlatformErrorType_ShareFailed:
            errorMessage = @"分享失败";
            break;
        case UMSocialPlatformErrorType_RequestForUserProfileFailed:
            errorMessage = @"请求用户信息失败";
            break;
        case UMSocialPlatformErrorType_ShareDataNil:
            errorMessage = @"网络异常";
            break;
        case UMSocialPlatformErrorType_ShareDataTypeIllegal:
            errorMessage = @"分享内容不支持";
            break;
        case UMSocialPlatformErrorType_CheckUrlSchemaFail:
            errorMessage = @"跳转链接配置错误";
            break;
        case UMSocialPlatformErrorType_NotInstall:
            errorMessage = @"应用未安装";
            break;
        case UMSocialPlatformErrorType_Cancel:
            errorMessage = @"取消操作";
            break;
        case UMSocialPlatformErrorType_NotNetWork:
            errorMessage = @"网络异常";
            break;
        case UMSocialPlatformErrorType_SourceError:
            errorMessage = @"第三方错误";
            break;
        case UMSocialPlatformErrorType_ProtocolNotOverride:
            errorMessage = @"对应的UMSocialPlatformProvider的方法没有实现";
            break;
        case UMSocialPlatformErrorType_NotUsingHttps:
            errorMessage = @"没有用https的请求";
            break;
        default:
            errorMessage = @"未知错误";
            break;
    }
    [HxbHUDProgress showMessageCenter:errorMessage inView:nil];
}

@end

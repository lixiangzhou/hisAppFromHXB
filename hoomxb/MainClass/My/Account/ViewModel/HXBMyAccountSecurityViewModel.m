//
//  HXBMyAccountSecurityViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/2/27.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyAccountSecurityViewModel.h"
#import "HXBModifyTransactionPasswordAgent.h"
#import "HXBLazyCatRequestResultModel.h"

@implementation HXBMyAccountSecurityViewModel

- (void)modifyTransactionPasswordResultBlock:(void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf

    NYBaseRequest *request = [[NYBaseRequest alloc] init];
    request.requestUrl = kHXBSetTransaction_MobifyPassword_CheckIdentityAuthURL;
    request.requestMethod = NYRequestMethodPost;
    request.showHud = NO;
    request.delayInterval = RequestDelayInterval;
    [weakSelf showHFBankWithContent:hfContentText];
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf hiddenHFBank];
        weakSelf.lazyCatRequestModel = [[HXBLazyCatRequestModel alloc]init];
        weakSelf.lazyCatRequestModel.url = responseObject[@"data"][@"url"];
        HXBLazyCatRequestResultModel *lazyCatRequestResultModel = [[HXBLazyCatRequestResultModel alloc]init];
        [lazyCatRequestResultModel yy_modelSetWithDictionary:responseObject[@"data"][@"result"]];
        weakSelf.lazyCatRequestModel.result = lazyCatRequestResultModel;
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf hiddenHFBank];
//        if (resultBlock) {
//            NSDictionary *respObj = error.userInfo;
//
//            if ([respObj isKindOfClass:[NSDictionary class]]) {
//                if (respObj.statusCode != kHXBCode_Enum_RequestOverrun) {
//                    [weakSelf showToast:@"请输入正确的身份证号"];
//                }
//            } else {
//                [weakSelf showToast:@"请输入正确的身份证号"];
//            }
            resultBlock(NO);
//        }
    }];
}

@end

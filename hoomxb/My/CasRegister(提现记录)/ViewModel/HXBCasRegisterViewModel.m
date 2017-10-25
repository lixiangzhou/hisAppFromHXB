//
//  HXBCasRegisterViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCasRegisterViewModel.h"
#import "HXBBaseRequest.h"
@implementation HXBCasRegisterViewModel

/**
 提现记录
 
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)checkCardBinResultRequestWithSmscode:(NSString *)bankNumber andSuccessBlock: (void(^)())successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    HXBBaseRequest *versionUpdateAPI = [[HXBBaseRequest alloc] init];
//    versionUpdateAPI.requestUrl = kHXBSetWithdrawals_recordtURL;
    versionUpdateAPI.requestMethod = NYRequestMethodGet;
    versionUpdateAPI.isUPReloadData = YES;
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
//        NSInteger status =  [responseObject[@"status"] integerValue];
//        if (status != 0) {
//            if (failureBlock) {
//                failureBlock(responseObject);
//            }
//            return;
//        }
//
//        HXBCardBinModel *cardBinModel = [HXBCardBinModel yy_modelWithDictionary:responseObject[@"data"]];
//        if (successDateBlock) {
//            successDateBlock(cardBinModel);
//        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

@end

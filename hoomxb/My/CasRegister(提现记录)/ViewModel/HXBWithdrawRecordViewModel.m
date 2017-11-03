//
//  HXBWithdrawRecordViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawRecordViewModel.h"
#import "HXBBaseRequest.h"
#import "HXBWithdrawRecordListModel.h"
@implementation HXBWithdrawRecordViewModel

- (HXBWithdrawRecordListModel *)withdrawRecordModel {
    if (!_withdrawRecordListModel) {
        _withdrawRecordListModel = [[HXBWithdrawRecordListModel alloc] init];
    }
    return _withdrawRecordListModel;
}

/**
 提现进度
 
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)casRegisteRequestSuccessBlock: (void(^)(HXBWithdrawRecordListModel * withdrawRecordListModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBSetWithdrawals_recordtURL;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
       
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            if ((status != kHXBCode_Enum_ProcessingField)) {
                [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
            }
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
        }
        self.withdrawRecordListModel = [HXBWithdrawRecordListModel yy_modelWithDictionary:responseObject[kResponseData]];
        if (successDateBlock) {
            successDateBlock(self.withdrawRecordListModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

@end

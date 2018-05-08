//
//  HXBUserMigrationViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/5/4.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBUserMigrationViewModel.h"
#import "HXBLazyCatRequestResultModel.h"
@implementation HXBUserMigrationViewModel

- (void)requestUserMigrationInfoFinishBlock:(void (^)(BOOL isSuccess))finishBlock {
    kWeakSelf
    NYBaseRequest *requestAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    requestAPI.requestUrl = kHXBLazyCat_UserMigration;
    requestAPI.requestMethod = NYRequestMethodPost;
    requestAPI.showHud = NO;
    requestAPI.delayInterval = RequestDelayInterval;
    [self showHFBankWithContent:hfContentText];
    [requestAPI loadData:^(NYBaseRequest *request, id responseObject) {
        [weakSelf hiddenHFBank];
        weakSelf.lazyCatRequestModel = [[HXBLazyCatRequestModel alloc]init];
        weakSelf.lazyCatRequestModel.url = responseObject[@"data"][@"url"];
        HXBLazyCatRequestResultModel *lazyCatRequestResultModel = [[HXBLazyCatRequestResultModel alloc]init];
        [lazyCatRequestResultModel yy_modelSetWithDictionary:responseObject[@"data"][@"result"]];
        weakSelf.lazyCatRequestModel.result = lazyCatRequestResultModel;
        if (finishBlock) {
            finishBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [weakSelf hiddenHFBank];
        
        if (finishBlock) {
            finishBlock(NO);
        }
    }];
}


@end

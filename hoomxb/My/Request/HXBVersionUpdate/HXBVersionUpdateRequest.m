//
//  HXBVersionUpdateRequest.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBVersionUpdateRequest.h"
#import "HXBBaseRequest.h"
#import "HXBNoticModel.h"
@interface HXBVersionUpdateRequest ()

@property (nonatomic, strong) HXBBaseRequest *versionUpdateAPI;

@property (nonatomic, strong) NSMutableArray <HXBNoticModel *>*noticModelArr;

@end

@implementation HXBVersionUpdateRequest



/**
 版本更新

 @param versionCode app当前版本号
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)versionUpdateRequestWitversionCode:(NSString *)versionCode andSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBMY_VersionUpdateURL;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                            @"versionCode" : versionCode
                                        };
    [versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status == 1) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

- (void)noticeRequestWithisUPReloadData:(BOOL)isUPReloadData andSuccessBlock: (void(^)(id responseObject, NSInteger totalCount))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    self.versionUpdateAPI.isUPReloadData = isUPReloadData;
    self.versionUpdateAPI.requestUrl = kHXBHome_AnnounceURL;
    self.versionUpdateAPI.requestMethod = NYRequestMethodGet;
    self.versionUpdateAPI.requestArgument = @{
                                         @"page" : @(self.versionUpdateAPI.dataPage),
                                         @"pageSize" : @20
                                         };
    kWeakSelf
    [self.versionUpdateAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        NSInteger totalcount = [responseObject[@"data"][@"totalCount"] integerValue];
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(responseObject);
            }
            return;
        }
        if (successDateBlock) {
             NSArray *modelarr = [NSArray yy_modelArrayWithClass:[HXBNoticModel class] json:responseObject[@"data"][@"dataList"]];
            if (weakSelf.versionUpdateAPI.isUPReloadData) {
                [self.noticModelArr removeAllObjects];
            }
            [self.noticModelArr addObjectsFromArray:modelarr];
            successDateBlock(self.noticModelArr, totalcount);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}
- (HXBBaseRequest *)versionUpdateAPI
{
    if (!_versionUpdateAPI) {
        _versionUpdateAPI = [[HXBBaseRequest alloc] init];
    }
    return _versionUpdateAPI;
}
- (NSMutableArray<HXBNoticModel *> *)noticModelArr
{
    if (!_noticModelArr) {
        _noticModelArr = [NSMutableArray array];
    }
    return _noticModelArr;
}
@end

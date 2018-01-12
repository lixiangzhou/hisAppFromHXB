//
//  HXBNoticeVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/1/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBNoticeVCViewModel.h"
#import "HXBBaseRequest.h"
#import "HXBNoticModel.h"
@interface HXBNoticeVCViewModel ()

@property (nonatomic, strong) HXBBaseRequest *versionUpdateAPI;

@property (nonatomic, strong) NSMutableArray <HXBNoticModel *>*noticModelArr;

@end
@implementation HXBNoticeVCViewModel

- (void)noticeRequestWithisUPReloadData:(BOOL)isUPReloadData andSuccessBlock: (void(^)(NSInteger totalCount))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock
{
    self.versionUpdateAPI.isUPReloadData = isUPReloadData;
    self.versionUpdateAPI.requestUrl = kHXBHome_AnnounceURL;
    self.versionUpdateAPI.requestMethod = NYRequestMethodGet;
    self.versionUpdateAPI.showHud = NO;
    self.versionUpdateAPI.requestArgument = @{
                                              @"page" : @(self.versionUpdateAPI.dataPage),
                                              @"pageSize" : @kPageCount
                                              };
    kWeakSelf
    [self.versionUpdateAPI loadDataWithSuccess:^(NYBaseRequest *request, id responseObject) {
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
            successDateBlock(totalcount);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        //        [HxbHUDProgress showTextWithMessage:@"请求失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}
- (HXBBaseRequest *)versionUpdateAPI
{
    if (!_versionUpdateAPI) {
        _versionUpdateAPI = [[HXBBaseRequest alloc] initWithDelegate:self];
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

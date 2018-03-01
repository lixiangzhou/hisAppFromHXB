//
//  HXBNoticeVCViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2018/1/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBNoticeVCViewModel.h"
#import "HXBNoticModel.h"
@interface HXBNoticeVCViewModel ()

@property (nonatomic, assign) int dataPage;

@property (nonatomic, strong) NSMutableArray <HXBNoticModel *>*noticModelArr;

@end
@implementation HXBNoticeVCViewModel

- (void)noticeRequestWithisUPReloadData:(BOOL)isUPReloadData andCallbackBlock: (void(^)(BOOL isSuccess))callbackBlock
{
    NYBaseRequest *noticeRequest = [[NYBaseRequest alloc] initWithDelegate:self];
    noticeRequest.requestUrl = kHXBHome_AnnounceURL;
    noticeRequest.requestMethod = NYRequestMethodGet;
    noticeRequest.showHud = NO;
    if (isUPReloadData) {
        self.dataPage = 1;
    }
    else {
        self.dataPage++;
    }
    noticeRequest.requestArgument = @{
                                      @"page" : @(self.dataPage),
                                      @"pageSize" : @kPageCount
                                      };
    
    kWeakSelf
    [noticeRequest loadData:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        weakSelf.totalCount = responseObject[@"data"][@"totalCount"];
        if (callbackBlock) {
            NSArray *modelarr = [NSArray yy_modelArrayWithClass:[HXBNoticModel class] json:responseObject[@"data"][@"dataList"]];
            if (isUPReloadData) {
                [weakSelf.noticModelArr removeAllObjects];
            }
            [weakSelf.noticModelArr addObjectsFromArray:modelarr];
            callbackBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        weakSelf.dataPage++;
        if (callbackBlock) {
            callbackBlock(NO);
        }
    }];
    
}

- (NSMutableArray<HXBNoticModel *> *)noticModelArr
{
    if (!_noticModelArr) {
        _noticModelArr = [NSMutableArray array];
    }
    return _noticModelArr;
}

@end

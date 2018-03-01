//
//  HXBWithdrawRecordViewModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawRecordViewModel.h"
#import "HXBWithdrawRecordListModel.h"

@interface HXBWithdrawRecordViewModel ()

@property (nonatomic, strong) NSMutableArray <HXBWithdrawRecordModel *> *dataList;

@end

@implementation HXBWithdrawRecordViewModel

- (HXBWithdrawRecordListModel *)withdrawRecordModel {
    if (!_withdrawRecordListModel) {
        _withdrawRecordListModel = [[HXBWithdrawRecordListModel alloc] init];
    }
    return _withdrawRecordListModel;
}

/**
 提现进度
 
 @param isLoading 是否显示加载
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)withdrawRecordProgressRequestWithLoading:(BOOL)isLoading andPage:(NSInteger)page andSuccessBlock: (void(^)(HXBWithdrawRecordListModel * withdrawRecordListModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
{
    NYBaseRequest *versionUpdateAPI = [[NYBaseRequest alloc] init];
    versionUpdateAPI.requestUrl = kHXBSetWithdrawals_recordtURL;
    versionUpdateAPI.requestMethod = NYRequestMethodPost;
    versionUpdateAPI.requestArgument = @{
                                         @"page" : @(page),
                                         @"pageSize" : @kPageCount
                                         };
    NSString *loadStr = nil;
    if (isLoading) {
        loadStr = kLoadIngText;
    }
    kWeakSelf
    [versionUpdateAPI startWithHUDStr:loadStr Success:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"%@",responseObject);
        if (page == 1) {
            [weakSelf.dataList removeAllObjects];
        }
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            kHXBBuyErrorResponsShowHUD
        }
        
        weakSelf.withdrawRecordListModel = [HXBWithdrawRecordListModel yy_modelWithDictionary:responseObject[kResponseData]];
        [weakSelf.dataList addObjectsFromArray:self.withdrawRecordListModel.dataList];
        weakSelf.withdrawRecordListModel.dataList = self.dataList;
        if (successDateBlock) {
            successDateBlock(weakSelf.withdrawRecordListModel);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

- (NSMutableArray<HXBWithdrawRecordModel *> *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end

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

- (void)withdrawRecordProgressRequestWithLoading:(BOOL)isLoading resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    NYBaseRequest *withdrawRecordAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    withdrawRecordAPI.requestUrl = kHXBSetWithdrawals_recordtURL;
    withdrawRecordAPI.showHud = isLoading;
    withdrawRecordAPI.requestMethod = NYRequestMethodPost;
    withdrawRecordAPI.requestArgument = @{
                                         @"page" : @(self.withdrawRecordPage).description,
                                         @"pageSize" : @kPageCount
                                         };
    NSString *loadStr = nil;
    if (isLoading) {
        loadStr = kLoadIngText;
    }
    
    [withdrawRecordAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (weakSelf.withdrawRecordPage <= 1) {
            weakSelf.withdrawRecordPage = 1;
            [weakSelf.dataList removeAllObjects];
        }
        
        
        weakSelf.withdrawRecordListModel = [HXBWithdrawRecordListModel yy_modelWithDictionary:responseObject[kResponseData]];
        [weakSelf.dataList addObjectsFromArray:self.withdrawRecordListModel.dataList];
        weakSelf.withdrawRecordListModel.dataList = self.dataList;
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

- (NSInteger)withdrawRecordPage{
    if (_withdrawRecordPage <= 1) {
        _withdrawRecordPage = 1;
    }
    return _withdrawRecordPage;
}

- (NSMutableArray<HXBWithdrawRecordModel *> *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end

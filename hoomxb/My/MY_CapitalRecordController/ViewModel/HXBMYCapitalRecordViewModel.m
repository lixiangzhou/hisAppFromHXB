//
//  HXBMYCapitalRecordViewModel.m
//  hoomxb
//
//  Created by hxb on 2018/2/7.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYCapitalRecordViewModel.h"
#import "HXBMYModel_CapitalRecordDetailModel.h"

@implementation HXBMYCapitalRecordViewModel

#pragma mark - plan detail 交易记录 接口
- (void)capitalRecord_requestWithScreenType: (NSString *)screenType
                                resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    
    kWeakSelf
    NYBaseRequest *capitalRecordAPI = [[NYBaseRequest alloc] initWithDelegate:self];
    capitalRecordAPI.requestUrl = kHXBMY_CapitalRecordURL;
    capitalRecordAPI.requestMethod = NYRequestMethodGet;
    capitalRecordAPI.showHud = YES;
    capitalRecordAPI.requestArgument = @{
                                         @"page" : [NSString stringWithFormat:@"%ld",(long)weakSelf.capitalRecordPage],
                                         @"filter" : screenType
                                         };
    [capitalRecordAPI loadData:^(NYBaseRequest *request, id responseObject) {
        [capitalRecordAPI hideLoading];
        NSDictionary *data = [responseObject valueForKey:@"data"];
        NSArray <NSDictionary *>*dataList = [data valueForKey:@"dataList"];
        weakSelf.totalCount = [NSString stringWithFormat:@"%@",[data valueForKey:@"totalCount"]];
        NSMutableArray <HXBMYViewModel_MainCapitalRecordViewModel *>* viewModelArray = [[NSMutableArray alloc]init];
        [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HXBMYModel_CapitalRecordDetailModel *capitalRecordModel = [[HXBMYModel_CapitalRecordDetailModel alloc]init];
            HXBMYViewModel_MainCapitalRecordViewModel *viewModel = [[HXBMYViewModel_MainCapitalRecordViewModel alloc]init];
            //模型转化
            [capitalRecordModel yy_modelSetWithDictionary:obj];
            viewModel.capitalRecordModel = capitalRecordModel;
            [viewModelArray addObject:viewModel];
        }];
        weakSelf.currentPageCount = viewModelArray.count;
        
        if (resultBlock) {
            if (weakSelf.capitalRecordPage<=1) {
                weakSelf.capitalRecordPage = 1;
                [weakSelf.capitalRecordViewModel_array removeAllObjects];
            }
            [weakSelf.capitalRecordViewModel_array addObjectsFromArray:viewModelArray];
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [capitalRecordAPI hideLoading];
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

- (NSMutableArray<HXBMYViewModel_MainCapitalRecordViewModel *> *)capitalRecordViewModel_array{
    if (!_capitalRecordViewModel_array) {
        _capitalRecordViewModel_array = [[NSMutableArray alloc]init];
    }
    return _capitalRecordViewModel_array;
}

- (NSInteger)capitalRecordPage{
    if (_capitalRecordPage<=0) {
        _capitalRecordPage = 1;
    }
    return _capitalRecordPage;
}

@end

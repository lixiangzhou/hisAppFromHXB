//
//  HXBCouponListViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBCouponListViewModel.h"

@implementation HXBCouponListViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock
{
    self = [super initWithBlock:hugViewBlock];
    if (self) {
        self.totalCount = @"0";
        self.pageSize = @"20";
    }
    return self;
}

- (void)downLoadMyAccountListInfo:(BOOL)isNew completion:(void (^)(BOOL isSuccess))completion;
{
    NSInteger currentPage = ceil(self.dataSource.count * 1.0 / self.pageSize.integerValue);
    NSInteger page = 1;
    if (isNew == NO) {
        page = currentPage + 1;
    }
    
    NYBaseRequest *myAccountListInfoAPI = [[NYBaseRequest alloc]init];
    myAccountListInfoAPI.requestUrl = kHXBMY_AccountListInfoURL;
    myAccountListInfoAPI.requestMethod = NYRequestMethodPost;
    
    myAccountListInfoAPI.requestArgument = @{
                                             @"page": [NSString stringWithFormat:@"%zd", page],
                                             @"filter": @"available"
                                             };
    myAccountListInfoAPI.hudDelegate = self;
    
    [myAccountListInfoAPI showLoading:@"加载中..."];
    kWeakSelf
    [myAccountListInfoAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [myAccountListInfoAPI hideLoading];
        
        NSDictionary *data = [responseObject valueForKey:@"data"];
        NSArray <NSDictionary *>*dataList = [data valueForKey:@"dataList"];
        NSMutableArray <HXBMyCouponListModel *>* temp = [weakSelf dataProcessingWitharr:dataList];
        
        if (isNew) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.dataSource addObjectsFromArray:temp];
        } else {
            [weakSelf.dataSource addObjectsFromArray:temp];
        }
        
        weakSelf.totalCount = data[@"totalCount"];
        
        weakSelf.showNoMoreData = weakSelf.dataSource.count >= weakSelf.totalCount.integerValue;
        weakSelf.showPullup = weakSelf.totalCount.integerValue > weakSelf.pageSize.integerValue;

        if (completion) {
            completion(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        [myAccountListInfoAPI hideLoading];
        if (completion) {
            completion(NO);
        }
    }];
}

- (NSMutableArray <HXBMyCouponListModel *>*)dataProcessingWitharr:(NSArray *)dataList
{
    NSMutableArray <HXBMyCouponListModel *>*planListViewModelArray = [[NSMutableArray alloc]init];
    
    [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXBMyCouponListModel *financtingPlanListModel = [[HXBMyCouponListModel alloc]init];
        //字典转模型
        [financtingPlanListModel yy_modelSetWithDictionary:obj];
        [planListViewModelArray addObject:financtingPlanListModel];
    }];
    return planListViewModelArray;
}

- (NSMutableArray<HXBMyCouponListModel *> *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end

//
//  HxbHomeRequest_dataList.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomeRequest_dataList.h"
#import "HxbHomePageModel_DataList.h"
#import "HxbHomePageViewModel_dataList.h"

@interface HxbHomeRequest_dataList()
@property (nonatomic,strong) NSMutableArray <HxbHomePageViewModel_dataList *>*homeDataListViewModelArray;
@end

@implementation HxbHomeRequest_dataList
- (void)homeDataListSuccessBlock: (void(^)(NSMutableArray <HxbHomePageViewModel_dataList *>*homeDataListViewModelArray))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock{
    
    HxbIndexPlanListAPI *indexPlanListAPI = [[HxbIndexPlanListAPI alloc]init];
    [indexPlanListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
//        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        NSArray <NSDictionary *>* dataList = responseObject[@"data"][@"dataList"];
           _homeDataListViewModelArray  = [NSMutableArray array];
        if (!responseObject || !dataList.count) {
            NSLog(@"✘散标购买请求没有数据");
            return;
        }
        
        [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
         
            HxbHomePageModel_DataList *homeDataListModel = [[HxbHomePageModel_DataList alloc]init];
            //创建viewModel
            HxbHomePageViewModel_dataList *homeDataListViewModel = [[HxbHomePageViewModel_dataList alloc]init];
            //字典转模型
            [homeDataListModel yy_modelSetWithDictionary:obj];
            
            //给viewModel赋值MODEL
            homeDataListViewModel.homePageModel_DataList = homeDataListModel;
          
            [_homeDataListViewModelArray addObject:homeDataListViewModel];
        }];
        //回调NSMutableArray
        if (successDateBlock) {
            successDateBlock(_homeDataListViewModelArray);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            NSLog(@"✘首页数据列表 - 请求没有数据");
            failureBlock(error);
        }
    }];

}
@end

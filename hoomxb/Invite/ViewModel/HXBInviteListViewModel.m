//
//  HXBInviteListViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/6.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBInviteListViewModel.h"

@interface HXBInviteListViewModel()

@property (nonatomic) NSInteger page;

@end

@implementation HXBInviteListViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _investListArray = [NSMutableArray array];
        _overViewModel = [[HXBInviteOverViewModel alloc] init];
    }
    return self;
}
/**
 获取邀请好友列表的接口
 
 @param isUpData 是否下拉刷新
 @param resultBlock 返回结果
 */
- (void)inviteListWithIsUpData: (BOOL)isUpData
                   resultBlock: (void(^)(BOOL isSuccess))resultBlock; {
    
    if (!isUpData) {
        self.page += 1;
    } else {
        self.page = 1;
    }
    
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXB_Invite_List;
    request.requestArgument = @{@"page": @(self.page).description};
    request.showHud = YES;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [weakSelf displayInvestListWithResponseObject:responseObject];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

- (void)displayInvestListWithResponseObject:(NSDictionary *)responseObject {
    //页码信息处理
    NSInteger pageNumber = [responseObject[kResponseData][@"pageNumber"] integerValue];
    NSInteger pageSize = [responseObject[kResponseData][@"pageSize"] integerValue];
    NSInteger totalCount = [responseObject[kResponseData][@"totalCount"] integerValue];
    
    BOOL isLastPage = NO;
    if(pageNumber * pageSize >= totalCount) {
        isLastPage = YES;
    }
    
    BOOL isShowLoadMore = NO;
    if(totalCount > pageSize) {
        isShowLoadMore = YES;
    }
    
    //页码处理
    self.page = pageNumber;
    self.isLastPage = isLastPage;
    self.isShowLoadMore = isShowLoadMore;
    self.investListTotalCount = totalCount;
    
    NSMutableArray <HXBInviteModel *> *tempInvestArray = [[NSMutableArray alloc] init];
    NSMutableArray <NSDictionary *>* dataList = [NSMutableArray arrayWithArray:responseObject[kResponseData][kResponseDataList]];
    [dataList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HXBInviteModel *investListModel = [[HXBInviteModel alloc] init];
        [investListModel yy_modelSetWithDictionary:obj];
        //给viewModel赋值MODEL
        [tempInvestArray addObject:investListModel];
    }];
    if(1 == pageNumber) {
        [self.investListArray removeAllObjects];
    }
    [self.investListArray addObjectsFromArray:tempInvestArray];
}


/**
 获取邀请好友奖励的接口
 
 @param params 请求参数
 @param resultBlock 返回结果
 */
- (void)inviteOverViewWithParams: (NSDictionary *)params
                     resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXB_Invite_OverView;
    request.requestArgument = params;
    request.showHud = YES;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        [weakSelf.overViewModel yy_modelSetWithDictionary:baseDic];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

@end

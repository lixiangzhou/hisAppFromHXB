//
//  HXBInviteListViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/6.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBInviteModel.h"
#import "HXBInviteOverViewModel.h"

@interface HXBInviteListViewModel : HXBBaseViewModel

@property (nonatomic, strong) NSMutableArray <HXBInviteModel *> *investListArray;   //邀请好友数组
@property (nonatomic, assign) NSInteger investListTotalCount;                       //总个数
@property (nonatomic, assign) BOOL isLastPage;                                      //是否最后一页
@property (nonatomic, assign) BOOL isShowLoadMore;                                  //是否显示加载更多
@property (nonatomic, strong) HXBInviteOverViewModel *overViewModel;                //邀请好友奖励数据

/**
 获取邀请好友列表的接口

 @param isUpData 是否下拉刷新
 @param resultBlock 返回结果
 */
- (void)inviteListWithIsUpData: (BOOL)isUpData
                   resultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 获取邀请好友奖励的接口

 @param params 请求参数
 @param resultBlock 返回结果
 */
- (void)inviteOverViewWithParams: (NSDictionary *)params
                     resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end

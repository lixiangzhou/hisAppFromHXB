//
//  HXBInviteViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBInviteViewModel.h"

@implementation HXBInviteViewModel

// 获取邀请好友列表的接口
+ (void)requestForInviteListWithParams: (NSDictionary *)params
                       andSuccessBlock: (void(^)(HXBInviteListModel *model))successDateBlock
                       andFailureBlock: (void(^)(NSError *error))failureBlock {
    NYBaseRequest *accountAsseAPI = [[NYBaseRequest alloc]init];
    accountAsseAPI.requestMethod = NYRequestMethodPost;
    accountAsseAPI.requestUrl = kHXB_Invite_List;
    accountAsseAPI.requestArgument = params;
    [accountAsseAPI startWithHUDStr:@"加载中..." Success:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        HXBInviteListModel *model = [[HXBInviteListModel alloc]init];
        [model yy_modelSetWithDictionary:baseDic];
        if (successDateBlock) {
            successDateBlock(model);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            failureBlock(error);
        }
    }];
}

// 获取邀请好友奖励的接口
+ (void)requestForInviteOverViewWithParams: (NSDictionary *)params
                           andSuccessBlock: (void(^)(HXBInviteOverViewModel *model))successDateBlock
                           andFailureBlock: (void(^)(NSError *error))failureBlock {
    NYBaseRequest *accountAsseAPI = [[NYBaseRequest alloc]init];
    accountAsseAPI.requestMethod = NYRequestMethodPost;
    accountAsseAPI.requestUrl = kHXB_Invite_OverView;
    accountAsseAPI.requestArgument = params;
    [accountAsseAPI startWithHUDStr:@"加载中..." Success:^(NYBaseRequest *request, id responseObject) {
        NSDictionary *baseDic = [responseObject valueForKey:@"data"];
        HXBInviteOverViewModel *model = [[HXBInviteOverViewModel alloc]init];
        [model yy_modelSetWithDictionary:baseDic];
        if (successDateBlock) {
            successDateBlock(model);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            failureBlock(error);
        }
    }];
}

@end

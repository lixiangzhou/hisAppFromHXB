//
//  HXBInviteViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBInviteListModel.h"
#import "HXBInviteOverViewModel.h"

@interface HXBInviteViewModel : NSObject

// 获取邀请好友列表的接口
+ (void)requestForInviteListWithParams: (NSDictionary *)params
                       andSuccessBlock: (void(^)(HXBInviteListModel *model))successDateBlock
                       andFailureBlock: (void(^)(NSError *error))failureBlock;

// 获取邀请好友奖励的接口
+ (void)requestForInviteOverViewWithParams: (NSDictionary *)params
                       andSuccessBlock: (void(^)(HXBInviteOverViewModel *model))successDateBlock
                       andFailureBlock: (void(^)(NSError *error))failureBlock;

@end

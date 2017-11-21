//
//  HXBInviteListModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/9.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBInviteModel.h"

@interface HXBInviteListModel : NSObject
// 邀请记录总条数
@property (nonatomic, assign) NSInteger totalCount;
// 每页显示条数
@property (nonatomic, assign) NSInteger pageSize;
// 当前页数
@property (nonatomic, assign) NSInteger pageNumber;
// 邀请好友的列表数组
@property (nonatomic, strong) NSArray <HXBInviteModel *> *dataList;

@end

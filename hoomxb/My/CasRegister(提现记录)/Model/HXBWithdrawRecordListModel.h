//
//  HXBWithdrawRecordListModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/10/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBWithdrawRecordModel;
@interface HXBWithdrawRecordListModel : NSObject

/**
 提现记录列表
 */
@property (nonatomic, strong) NSArray <HXBWithdrawRecordModel *> *dataList;

/**
 当前页码
 */
@property (nonatomic, assign) NSInteger pageNumber;

/**
 每页返回条数
 */
@property (nonatomic, assign) NSInteger pageSize;

/**
 总共条数
 */
@property (nonatomic, assign) NSInteger totalCount;

/******************************辅助字段******************************/

/**
 是否全部加载完毕数据
 */
@property (nonatomic, assign) BOOL isNoMoreData;

@end

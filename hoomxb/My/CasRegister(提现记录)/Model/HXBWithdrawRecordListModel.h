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

@end

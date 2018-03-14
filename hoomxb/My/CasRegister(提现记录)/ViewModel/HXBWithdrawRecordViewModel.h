//
//  HXBWithdrawRecordViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBaseViewModel.h"
@class HXBWithdrawRecordListModel;
@interface HXBWithdrawRecordViewModel : HXBBaseViewModel
/**
 提现进度模型
 */
@property (nonatomic, strong) HXBWithdrawRecordListModel *withdrawRecordListModel;

@property (nonatomic,assign) NSInteger withdrawRecordPage;
/**
  提现进度
 @param isLoading 是否显示加载
 @param resultBlock resultBlock description
 */
- (void)withdrawRecordProgressRequestWithLoading:(BOOL)isLoading resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end

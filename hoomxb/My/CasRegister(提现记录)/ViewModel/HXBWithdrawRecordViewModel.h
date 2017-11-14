//
//  HXBWithdrawRecordViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBWithdrawRecordListModel;
@interface HXBWithdrawRecordViewModel : NSObject
/**
 提现进度模型
 */
@property (nonatomic, strong) HXBWithdrawRecordListModel *withdrawRecordListModel;

/**
 提现进度

 @param isLoading 是否显示加载
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)withdrawRecordProgressRequestWithLoading:(BOOL)isLoading andSuccessBlock: (void(^)(HXBWithdrawRecordListModel * withdrawRecordListModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end

//
//  HXBNoticeVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/1/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
@class HXBNoticModel;
@interface HXBNoticeVCViewModel : HXBBaseViewModel

@property (nonatomic, strong, readonly) NSMutableArray <HXBNoticModel *>*noticModelArr;

/**
 公告
 
 @param isUPReloadData 是否为下拉加载
 @param callbackBlock 回调
 */
- (void)noticeRequestWithisUPReloadData:(BOOL)isUPReloadData andCallbackBlock: (void(^)(BOOL isSuccess))callbackBlock;

@end

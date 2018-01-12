//
//  HXBNoticeVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/1/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBNoticeVCViewModel : HXBBaseViewModel

/**
 公告
 
 @param isUPReloadData 是否为下拉加载
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)noticeRequestWithisUPReloadData:(BOOL)isUPReloadData andSuccessBlock: (void(^)(id responseObject, NSInteger totalCount))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end

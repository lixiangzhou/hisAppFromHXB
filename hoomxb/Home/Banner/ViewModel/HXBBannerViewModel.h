//
//  HXBBannerViewModel.h
//  hoomxb
//
//  Created by caihongji on 2018/2/5.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBBannerViewModel : HXBBaseViewModel

/**
 加载用户信息
 
 @param resultBlock 结果回调
 */
- (void)loadUserInfoWithBlock:(void(^)(BOOL isSuccess))resultBlock;
@end

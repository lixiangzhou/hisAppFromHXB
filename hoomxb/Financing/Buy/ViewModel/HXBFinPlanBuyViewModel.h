//
//  HXBFinPlanBuyViewModel.h
//  hoomxb
//
//  Created by lxz on 2018/2/26.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@interface HXBFinPlanBuyViewModel : HXBBaseViewModel
/**
 更新用户信息
 
 @param resultBlock 结果回调
 */
- (void)downLoadUserInfoWithResultBlock:(void(^)(HXBRequestUserInfoViewModel *viewModel))resultBlock;
@end

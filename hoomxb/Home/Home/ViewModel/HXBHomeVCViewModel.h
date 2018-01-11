//
//  HXBHomeVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/1/11.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@class HXBHomeBaseModel;

@interface HXBHomeVCViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBHomeBaseModel *homeBaseModel;

- (void)homePlanRecommendCallbackBlock: (void(^)(BOOL isSuccess))callbackBlock;

@end

//
//  HXBHomeVCViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2018/1/11.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@class HXBHomeBaseModel,HxbHomePageModel_DataList;

@interface HXBHomeVCViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBHomeBaseModel *homeBaseModel;

@property (nonatomic, strong) NSMutableArray <HxbHomePageModel_DataList *>*homeDataList;

- (void)homePlanRecommendCallbackBlock: (void(^)(BOOL isSuccess))callbackBlock;

@end

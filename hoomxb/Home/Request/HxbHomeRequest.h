//
//  HXBteete.h
//  hoomxb
//
//  Created by caihongji on 2018/2/1.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HxbHomePageViewModel.h"

@interface HxbHomeRequest : NSObject

- (void)homePlanRecommendWithIsUPReloadData:(BOOL)isUPReloadData
                            andSuccessBlock: (void(^)(HxbHomePageViewModel *viewModel))successDateBlock
                            andFailureBlock: (void(^)(NSError *error))failureBlock;
@end

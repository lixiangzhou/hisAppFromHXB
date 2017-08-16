//
//  HxbHomeRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HxbHomePageViewModel.h"
@interface HxbHomeRequest : NSObject

- (void)homeAccountAssetWithUserID: (NSString *)userId
                   andSuccessBlock: (void(^)(HxbHomePageViewModel *viewModel))successDateBlock
                   andFailureBlock: (void(^)(NSError *error))failureBlock;

- (void)homePlanRecommendWithIsUPReloadData:(BOOL)isUPReloadData
                            andSuccessBlock: (void(^)(HxbHomePageViewModel *viewModel))successDateBlock
                            andFailureBlock: (void(^)(NSError *error))failureBlock;

@end

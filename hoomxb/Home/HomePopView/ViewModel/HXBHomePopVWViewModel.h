//
//  HXBHomePopVWViewModel.h
//  hoomxb
//
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
@class HXBHomePopVWModel;

@interface HXBHomePopVWViewModel : HXBBaseViewModel

@property (nonatomic,strong)HXBHomePopVWModel *homePopModel;

- (void)homePopViewRequestSuccessBlock: (void(^)(BOOL isSuccess))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end

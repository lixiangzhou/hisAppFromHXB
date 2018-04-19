//
//  HXBHomePopViewRequest.h
//  hoomxb
//
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBHomePopViewViewModel.h"

@interface HXBHomePopViewRequest : NSObject

+ (void)homePopViewRequestSuccessBlock: (void(^)(id responseObject))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
@end

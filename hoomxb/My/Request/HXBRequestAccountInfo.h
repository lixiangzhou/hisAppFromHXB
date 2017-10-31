//
//  HXBRequestAccountInfo.h
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMyRequestAccountModel.h"

@interface HXBRequestAccountInfo : NSObject

+ (void)downLoadAccountInfoNoHUDWithSeccessBlock:(void(^)(HXBMyRequestAccountModel *viewModel))seccessBlock andFailure: (void(^)(NSError *error))failureBlock;

@end

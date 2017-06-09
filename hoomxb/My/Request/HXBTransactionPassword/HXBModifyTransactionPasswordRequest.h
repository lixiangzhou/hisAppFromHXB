//
//  HXBModifyTransactionPasswordRequest.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/9.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBModifyTransactionPasswordRequest : NSObject
- (void)myTransactionPasswordWithIDcard:(NSString *)IDcard andSuccessBlock: (void(^)(NSString*viewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;
@end

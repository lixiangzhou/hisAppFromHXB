//
//  HXBCasRegisterViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/10/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBCasRegisterViewModel : NSObject

/**
 提现记录
 
 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)checkCardBinResultRequestWithSmscode:(NSString *)bankNumber andSuccessBlock: (void(^)())successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;

@end

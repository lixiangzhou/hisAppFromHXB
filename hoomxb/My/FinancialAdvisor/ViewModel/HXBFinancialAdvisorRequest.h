//
//  HXBFinancialAdvisorRequest.h
//  hoomxb
//
//  Created by hxb on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXBFinancialAdvisorModel;
@interface HXBFinancialAdvisorRequest : NSObject

/**
 获取理财顾问信息

 @param seccessBlock 成功返回
 @param failureBlock 失败返回
 */
+ (void)downLoadmyFinancialAdvisorInfoNoHUDWithSeccessBlock:(void(^)(HXBFinancialAdvisorModel *model))seccessBlock andFailure: (void(^)(NSError *error))failureBlock;

@end

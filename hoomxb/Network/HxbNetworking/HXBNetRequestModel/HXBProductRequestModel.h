//
//  HXBProductRequestModel.h
//  hoomxb
//
//  Created by caihongji on 2018/1/10.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBBaseRequest.h"

@interface HXBProductRequestModel : NSObject

@property (nonatomic, weak) id<HXBRequestHudDelegate> delegate;

- (instancetype)initWithDelegate:(id<HXBRequestHudDelegate>)delegate;

/**
计划 购买 结果返回

 @param planID 计划id
 @param amount 金额
 @param cashType 计划类型
 @param resultBlock 回调
 */
- (void)plan_buyReslutWithPlanID: (NSString *)planID
                       andAmount: (NSString *)amount
                       cashType : (NSString *)cashType
                  andResultBlock:(void (^)(HXBBaseRequest *request, id responseObject, NSError *error))resultBlock;
@end

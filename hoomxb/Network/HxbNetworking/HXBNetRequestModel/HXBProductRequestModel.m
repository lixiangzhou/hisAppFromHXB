//
//  HXBProductRequestModel.m
//  hoomxb
//
//  Created by caihongji on 2018/1/10.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBProductRequestModel.h"

@implementation HXBProductRequestModel

- (instancetype)initWithDelegate:(id<HXBRequestHudDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)plan_buyReslutWithPlanID: (NSString *)planID
                       andAmount: (NSString *)amount
                       cashType : (NSString *)cashType
                 andResultBlock:(void (^)(HXBBaseRequest *request, id responseObject, NSError *error))resultBlock{
    
    HXBBaseRequest *confirmBuyReslut = [[HXBBaseRequest alloc] initWithDelegate:self.delegate];
    
    if (!amount) amount = @"";
    confirmBuyReslut.requestArgument = @{@"amount" : amount, @"cashType" : cashType};
    
    confirmBuyReslut.requestUrl = kHXBFin_Plan_ConfirmBuyReslutURL(planID);
    confirmBuyReslut.requestMethod = NYRequestMethodPost;
    
    [confirmBuyReslut loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
        if (resultBlock) {
            resultBlock(request, responseObject, nil);
        }
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(request, nil, error);
        }
    }];
}
@end

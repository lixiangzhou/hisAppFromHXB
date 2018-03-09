//
//  HXBMyPlanBuyViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/9.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanBuyViewModel.h"

@implementation HXBMyPlanBuyViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _resultModel = [[HXBFin_Plan_BuyViewModel alloc] init];
    }
    return self;
}

/**
 账户内计划购买接口
 
 @param planID 计划id
 @param parameter 请求参数
 @param resultBlock 返回数据
 */
- (void)myPlanBuyReslutWithPlanID: (NSString *)planID
                        parameter: (NSDictionary *)parameter
                      resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestArgument = parameter;
    request.requestUrl = kHXBFin_Plan_ConfirmBuyReslutURL(planID);
    request.requestMethod = NYRequestMethodPost;
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[kResponseData];
        [weakSelf.resultModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (request.responseObject) {
            NSInteger status = [request.responseObject[kResponseStatus] integerValue];
            weakSelf.errorMessage = request.responseObject[kResponseMessage];
            NSString *errorType = request.responseObject[kResponseErrorData][@"errorType"];
            if (status) {
                if ([errorType isEqualToString:@"TOAST"]) {
                    [HxbHUDProgress showTextWithMessage:request.responseObject[@"message"]];
                    status = kBuy_Toast;
                } else if ([errorType isEqualToString:@"RESULT"]) {
                    status = kBuy_Result;
                } else if ([errorType isEqualToString:@"PROCESSING"]) {
                    status = kBuy_Processing;
                }
                weakSelf.errorCode = status;
            }
        }
        if (resultBlock) resultBlock(NO);
    }];
}
@end

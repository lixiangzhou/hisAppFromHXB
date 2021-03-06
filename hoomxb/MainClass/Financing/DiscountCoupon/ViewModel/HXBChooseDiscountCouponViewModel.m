//
//  HXBChooseDiscountCouponViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/3/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBChooseDiscountCouponViewModel.h"

@interface HXBChooseDiscountCouponViewModel()

@end

@implementation HXBChooseDiscountCouponViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    if (self = [super initWithBlock:hugViewBlock]) {
        _chooseCouponModel = [[HXBChooseCouponModel alloc] init];
    }
    return self;
}
/**
 选择优惠券列表
 
 @param params 请求参数
 @param resultBlock 返回数据
 */
- (void)chooseCouponListWithParams: (NSDictionary *)params
                       resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    kWeakSelf
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXB_Coupon_Query;
    request.requestArgument = params;
    request.showHud = YES;
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *data = responseObject[kResponseData];
        [weakSelf.chooseCouponModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

@end

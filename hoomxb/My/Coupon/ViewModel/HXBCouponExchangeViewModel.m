//
//  HXBCouponExchangeViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBCouponExchangeViewModel.h"

@implementation HXBCouponExchangeViewModel

/// 此处需要对 2 和 500 的错误码处理
- (BOOL)erroResponseCodeDeal:(NYBaseRequest *)request {
    return NO;
}

- (void)downLoadMyCouponExchangeInfoHUDWithCode:(NSString *)code completion:(void (^)(BOOL isSuccess))completion {
    NYBaseRequest *myAccountListInfoAPI = [[NYBaseRequest alloc]init];
    myAccountListInfoAPI.requestUrl = kHXBMY_CouponExchangeInfoURL;
    myAccountListInfoAPI.requestMethod = NYRequestMethodPost;
    myAccountListInfoAPI.hudDelegate = self;
    myAccountListInfoAPI.requestArgument = @{@"code":code};
    
    [myAccountListInfoAPI showLoading:@"加载中..."];
    [myAccountListInfoAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        [myAccountListInfoAPI hideLoading];
        if (responseObject.isSuccess) {
            self.couponListModel = [[HXBMyCouponListModel alloc]init];
            [self.couponListModel yy_modelSetWithDictionary:responseObject[@"data"][@"coupon"]];
            self.promptMessage = nil;
        } else {
            if (responseObject.statusCode == 2 || responseObject.statusCode == 500) {
                self.promptMessage = responseObject.message;
            }
            
            if (responseObject.statusCode != kHXBCode_Enum_ProcessingField) {
                [myAccountListInfoAPI showToast:responseObject.message];
            }
        }
        completion(responseObject.isSuccess);
    } failure:^(NYBaseRequest *request, NSError *error) {
        [myAccountListInfoAPI hideLoading];
        completion(NO);
    }];
}
@end

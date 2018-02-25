//
//  HXBMyViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyViewModel.h"


@implementation HXBMyViewModel

- (void)downLoadAccountInfo:(void (^)(BOOL isSuccess))completion {
    
    NYBaseRequest *accountInfoAPI = [[NYBaseRequest alloc]init];
    accountInfoAPI.requestUrl = kHXBUser_AccountInfoURL;
    accountInfoAPI.requestMethod = NYRequestMethodGet;
    
    [accountInfoAPI loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        self.accountModel = [[HXBMyRequestAccountModel alloc]init];
        [self.accountModel yy_modelSetWithDictionary:responseObject[@"data"]];
        if (completion) {
            completion(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (completion) {
            completion(NO);
        }
    }];
}
@end

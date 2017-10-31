//
//  HXBRequestAccountInfo.m
//  hoomxb
//
//  Created by hxb on 2017/10/30.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestAccountInfo.h"
#import "HXBBaseRequest.h"

@implementation HXBRequestAccountInfo

+ (void)downLoadAccountInfoNoHUDWithSeccessBlock:(void (^)(HXBMyRequestAccountModel *))seccessBlock andFailure:(void (^)(NSError *))failureBlock{
    
    NYBaseRequest *accountInfoAPI = [[NYBaseRequest alloc]init];
    accountInfoAPI.requestUrl = kHXBUser_AccountInfoURL;
    accountInfoAPI.requestMethod = NYRequestMethodGet;
    [accountInfoAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            kHXBResponsShowHUD
        }

        HXBMyRequestAccountModel *accountInfoModel = [[HXBMyRequestAccountModel alloc]init];
        [accountInfoModel yy_modelSetWithDictionary:responseObject[@"data"]];
        
        if (seccessBlock) {
            seccessBlock(accountInfoModel);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        if (failureBlock) {
            failureBlock(error);
        }
        kNetWorkError(@"用户请求失败");
    }];
}

@end

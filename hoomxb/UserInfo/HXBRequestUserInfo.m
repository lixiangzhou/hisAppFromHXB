//
//  HXBRequestUserInfo.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestUserInfo.h"
#import "HXBRequestUserInfoAPI.h"
#import "HXBRequestUserInfoViewModel.h"

@implementation HXBRequestUserInfo
///数据请求
+ (void) downLoadUserInfoWithSeccessBlock: (void(^)(HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure:(void(^)(NSError *error))failureBlock {
    HXBRequestUserInfoAPI *userInfoAPI = [[HXBRequestUserInfoAPI alloc]init];
    
    [userInfoAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        HXBUserInfoModel *userInfoModel = [[HXBUserInfoModel alloc]init];
        [userInfoModel yy_modelSetWithDictionary:responseObject];
        
        HXBRequestUserInfoViewModel *viewModel = [[HXBRequestUserInfoViewModel alloc]init];
        viewModel.userInfoModel = userInfoModel;
        
        if (seccessBlock) {
            seccessBlock(viewModel);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
            
        }
        kNetWorkError(@"用户请求失败");
    }];
}
@end

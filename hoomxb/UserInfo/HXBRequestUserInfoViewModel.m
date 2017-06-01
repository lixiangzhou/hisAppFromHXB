//
//  HXBRequestUserInfoViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRequestUserInfoViewModel.h"
#import "HXBRequestUserInfoViewModel.h"
#import "HXBUserInfoModel.h"
#import "HXBRequestUserInfoAPI.h"
@implementation HXBRequestUserInfoViewModel

///数据请求
- (void) downLoadUserInfoWithSeccessBlock: (void(^)(NYBaseRequest *request,HXBRequestUserInfoViewModel *viewModel))seccessBlock andFailure:(void(^)(NYBaseRequest *request, NSError *error))failureBlock {
    HXBRequestUserInfoAPI *userInfoAPI = [[HXBRequestUserInfoAPI alloc]init];
    
    [userInfoAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        HXBUserInfoModel *userInfoModel = [[HXBUserInfoModel alloc]init];
        [userInfoModel yy_modelSetWithDictionary:responseObject];
        
        HXBRequestUserInfoViewModel *viewModel = [[HXBRequestUserInfoViewModel alloc]init];
        viewModel.userInfoModel = userInfoModel;
        
        if (seccessBlock) {
            seccessBlock(request,viewModel);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (failureBlock) {
            failureBlock(request,error);
        }
    }];
}
@end

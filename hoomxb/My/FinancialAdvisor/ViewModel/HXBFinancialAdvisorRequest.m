//
//  HXBFinancialAdvisorRequest.m
//  hoomxb
//
//  Created by hxb on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancialAdvisorRequest.h"
#import "HXBBaseRequest.h"
#import "HXBFinancialAdvisorModel.h"

@implementation HXBFinancialAdvisorRequest

+ (void)downLoadmyFinancialAdvisorInfoNoHUDWithSeccessBlock:(void(^)(HXBFinancialAdvisorModel *model))seccessBlock andFailure: (void(^)(NSError *error))failureBlock
{
    NYBaseRequest *userInfoAPI = [[NYBaseRequest alloc]init];
    userInfoAPI.requestUrl = kHXBUser_financialAdvisorURL;//@"/account"
    userInfoAPI.requestMethod = NYRequestMethodGet;
    [userInfoAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"获取理财顾问信息%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            kHXBResponsShowHUD
        }
        
        HXBFinancialAdvisorModel *financialAdvisorInfoModel = [[HXBFinancialAdvisorModel alloc]init];
        [financialAdvisorInfoModel yy_modelSetWithDictionary:responseObject[@"data"]];
        
        if (seccessBlock) {
            seccessBlock(financialAdvisorInfoModel);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

/*
-(void)myFinancialAdvisorRequestSuccessBlock:(void (^)(id))successDateBlock andFailureBlock:(void (^)(NSError *))failureBlock{
    
    HXBBaseRequest *financialAdvisorAPI = [[HXBBaseRequest alloc] init];
    financialAdvisorAPI.requestUrl = kHXBUser_financialAdvisorURL;
    financialAdvisorAPI.requestMethod = NYRequestMethodGet;
    
    [financialAdvisorAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"获取理财顾问信息%@",responseObject);
        NSInteger status =  [responseObject[@"status"] integerValue];
        if (status != 0) {
            [HxbHUDProgress showTextWithMessage:responseObject[@"message"]];
            if (failureBlock) {
                failureBlock(nil);
            }
            return;
        }
        if (successDateBlock) {
            successDateBlock(responseObject);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"%@",error);
        [HxbHUDProgress showTextWithMessage:@"获取理财顾问信息失败"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
*/

@end

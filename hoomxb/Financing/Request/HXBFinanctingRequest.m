//
//  HXBFinanctingRequest.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanctingRequest.h"
#import "HXBFinanctingViewModel_HomePage.h"//首页的ViewModel
#import "LoanListAPI.h"//散标列表api
#import "PlanBuyListAPI.h"//红利计划列表api

@implementation HXBFinanctingRequest


#pragma mark - homePage reaquest
//MARK: 红利计划列表api
- (void)planBuyListWithPage: (NSInteger)page andSuccessBlock: (void(^)(NSArray* viewModelArray))successDate andFailureBlock: (void(^)(NSError *error))failureBlock{
    PlanBuyListAPI *planBuyListAPI = [[PlanBuyListAPI alloc]init];
    [planBuyListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if (!responseObject) {
            NSLog(@"✘散标购买请求没有数据");
            return;
        }
        //字典转模型
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            failureBlock(error);
        }
    }];
}

//MARK: 红利计划列表api
- (void)loanBuyListWithPage: (NSInteger)page andSuccessBlock: (void(^)(NSArray* viewModelArray))successDate andFailureBlock: (void(^)(NSError *error))failureBlock{
    LoanListAPI *loanListAPI = [[LoanListAPI alloc]init];
    [loanListAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        if (!responseObject) {
            NSLog(@"✘散标购买请求没有数据");
            return;
        }
        //字典转模型
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (error && failureBlock) {
            failureBlock(error);
        }
    }];
}

@end

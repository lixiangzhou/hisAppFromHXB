//
//  HXBMyPlanDetailsViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanDetailsViewModel.h"
#import "HXBMYViewModel_PlanDetailViewModel.h"
#import "HXBFinDetailViewModel_PlanDetail.h"

@interface HXBMyPlanDetailsViewModel ()

@property (nonatomic, readwrite, strong) HXBMYModel_PlanDetailModel *planDetailsModel;

@end

@implementation HXBMyPlanDetailsViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    self = [super initWithBlock:hugViewBlock];
    if (self) {
        _planDetailsModel = [[HXBMYModel_PlanDetailModel alloc] init];
        _planDetailsViewModel = [[HXBMYViewModel_PlanDetailViewModel alloc] init];
    }
    return self;
}

- (void)accountPlanListDetailsRequestWithPlanID: (NSString *)planID
                                    resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBMY_PlanDetaileURL(planID);
    request.showHud = NO;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *dataDic = responseObject[kResponseData];
        [weakSelf.planDetailsModel yy_modelSetWithDictionary:dataDic];
        weakSelf.planDetailsViewModel.planDetailModel = weakSelf.planDetailsModel;
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

/**
 * 撤销计划退出
 * @param planID 计划id
 */
- (void)accountPlanQuitRequestWithPlanID: (NSString *)planID
                             resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBMY_PlanQuitURL(planID);
    request.requestMethod = NYRequestMethodPost;
    request.showHud = YES;
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}


@end

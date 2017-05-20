//
//  HXBMYViewModel_PlanDetailViewModel.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYViewModel_PlanDetailViewModel.h"
#import "HXBRequestType_MYManager.h"

static NSString *kHXBUI = @"当日提取至红小宝账户";
static NSString *kINVESTUI = @"收益再投资";
static NSString *kHXB = @"HXB";
static NSString *kINVEST = @"INVEST";

@implementation HXBMYViewModel_PlanDetailViewModel
- (void)setPlanDetailModel:(HXBMYModel_PlanDetailModel *)planDetailModel {
    _planDetailModel = planDetailModel;
    if([planDetailModel.cashType isEqualToString:kHXB]) {
        self.cashType = kHXBUI;
    }
    if ([planDetailModel.cashType isEqualToString:kINVEST]) {
        self.cashType = kINVEST;
    }
    self.contractName = [NSString stringWithFormat:@"《%@》",planDetailModel.contractName];
}
@end

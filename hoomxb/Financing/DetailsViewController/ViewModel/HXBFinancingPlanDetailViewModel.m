//
//  HXBFinancingPlanDetailViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/15.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancingPlanDetailViewModel.h"

@implementation HXBFinancingPlanDetailViewModel

- (BOOL)hasExtraInterestRate {
    return [self.planDetailModel.planDetailModel.extraInterestRate floatValue] != 0;
}

- (BOOL)statusCanJoinIn {
    return self.planDetailModel.planDetailModel.unifyStatus.integerValue <= 5;
}

- (NSArray<NSString *> *)tableViewTitleArray {
    return @[@"计划详情",
             @"加入记录",
             @"红利计划服务协议"];
}

- (NSString *)profitString {
    return [self.planDetailModel.planDetailModel.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] && self.planDetailModel.planDetailModel.interestDate ? self.planDetailModel.planDetailModel.interestDate : @"收益复投";
}

- (NSString *)countDownString:(CGFloat)countDown {
    return [[HXBBaseHandDate sharedHandleDate] stringFromDate:@(countDown) andDateFormat:@"mm分ss秒后开始加入"];
}

- (void)setTopViewManagerData:(HXBFin_PlanDetailView_TopViewManager *)manager {
    if (self.hasExtraInterestRate) {
        manager.topViewManager.leftLabelStr = [NSString stringWithFormat:@"%.1f%%+%.1f%%",self.planDetailModel.planDetailModel.baseInterestRate.doubleValue, self.planDetailModel.planDetailModel.extraInterestRate.doubleValue];
    } else {
        manager.topViewManager.leftLabelStr = [NSString stringWithFormat:@"%.1f%%",self.planDetailModel.planDetailModel.expectedRate.doubleValue];
    }
    manager.topViewManager.rightLabelStr = @"平均历史年化收益";
    manager.leftViewManager.leftLabelStr = self.planDetailModel.lockPeriodStr;
    manager.leftViewManager.rightLabelStr = @"锁定期限";
    manager.midViewManager.leftLabelStr = [NSString hxb_getPerMilWithIntegetNumber:[self.planDetailModel.minRegisterAmount doubleValue]];
    manager.midViewManager.rightLabelStr = @"起投";
    manager.rightViewManager.rightLabelStr = self.planDetailModel.remainAmount_constStr;
    manager.rightViewManager.leftLabelStr = self.planDetailModel.remainAmount;
}

- (void)setFlowChartViewManagerData:(HXBFinBase_FlowChartView_Manager *)manager {
    manager.stage = self.planDetailModel.planDetailModel.unifyStatus.integerValue;;
    manager.addTime = self.planDetailModel.beginSellingTime_flow;
    manager.beginTime = self.planDetailModel.financeEndTime_flow;
    manager.leaveTime = self.planDetailModel.endLockingTime_flow;
}

- (HXBFin_Plan_Buy_ViewController *)getAPlanBuyController:(NSString *)hasBindCard userInfo:(HXBRequestUserInfoViewModel *)viewModel{
    HXBFin_Plan_Buy_ViewController *planJoinVC = [[HXBFin_Plan_Buy_ViewController alloc] init];

    float newBiePlanLeftAmount = self.planDetailModel.planDetailModel.newbiePlanLeftAmount.floatValue;
    BOOL isNewPlan = [self.planDetailModel.planDetailModel.novice isEqualToString:@"1"];
    float remainAmount = self.planDetailModel.planDetailModel.remainAmount.floatValue;
    float userRemainAmount = self.planDetailModel.planDetailModel.userRemainAmount.floatValue;
    float creditorVCStr = isNewPlan ? MIN(remainAmount, newBiePlanLeftAmount) : MIN(remainAmount, userRemainAmount);
    
    planJoinVC.isNewPlan = isNewPlan;
    planJoinVC.NewPlanJoinLimit = self.planDetailModel.planDetailModel.newbiePlanAmount;
    planJoinVC.expectedSubsidyInterestAmount = self.planDetailModel.planDetailModel.expectedSubsidyInterestAmount;
    planJoinVC.availablePoint = [NSString stringWithFormat:@"%.2f", creditorVCStr];
    planJoinVC.title = @"加入计划";
    planJoinVC.isFirstBuy               = [self.planDetailModel.planDetailModel.isFirst boolValue];
    planJoinVC.totalInterest            = self.planDetailModel.totalInterest;
    planJoinVC.loanId                   = self.planDetailModel.ID;
    planJoinVC.featuredSlogan           = self.planDetailModel.planDetailModel.incomeApproach;
    planJoinVC.minRegisterAmount        = self.planDetailModel.planDetailModel.minRegisterAmount;
    planJoinVC.cashType                 = self.planDetailModel.planDetailModel.cashType;
    planJoinVC.registerMultipleAmount   = self.planDetailModel.planDetailModel.registerMultipleAmount;
    planJoinVC.placeholderStr           = self.planDetailModel.addCondition;
    planJoinVC.hasBindCard              = hasBindCard;
    planJoinVC.userInfoViewModel        = viewModel;
    planJoinVC.riskType                 = self.planDetailModel.planDetailModel.riskType;
    
    return planJoinVC;
}

- (void)requestPlanDetailWithPlanId:(NSString *)planId resultBlock:(void (^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *planDetaileAPI = [[NYBaseRequest alloc]initWithDelegate:self];
    planDetaileAPI.requestUrl = kHXBFinanc_PlanDetaileURL(planId.integerValue);
    planDetaileAPI.showHud = YES;
    
    [planDetaileAPI loadData:^(NYBaseRequest *request, id responseObject) {
        //数据是否出错
        if ([responseObject[kResponseStatus] integerValue]) {
            kNetWorkError(@"计划详情页 没有数据");
            if(resultBlock) resultBlock(NO);
            return;
        }
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDetailModel_PlanDetail *planDetaileModel = [[HXBFinDetailModel_PlanDetail alloc]init];
        [planDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_PlanDetail *planDetailViewModel = [[HXBFinDetailViewModel_PlanDetail alloc]init];
        planDetailViewModel.planDetailModel = planDetaileModel;
        self.planDetailModel = planDetailViewModel;
        ///回调
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            kNetWorkError(@"红利计划详情")
            resultBlock(NO);
        }
    }];
}

@end

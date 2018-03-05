//
//  HXBFinancingLoanDetailViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/15.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancingLoanDetailViewModel.h"

@implementation HXBFinancingLoanDetailViewModel

- (NSArray<NSString *> *)tableViewTitleArray {
    if (!_tableViewTitleArray) {
        _tableViewTitleArray = @[
                                 @"借款信息",
                                 @"投标记录",
                                 @"借款合同"
                                 ];
    }
    return _tableViewTitleArray;
}

- (NSArray<HXBFinDetail_TableViewCellModel *> *)tableViewModelArray {
    if (!_tableViewModelArray) {
        
        NSArray *tableViewImageArray = @[
                                         @"1",
                                         @"1",
                                         @"1",
                                         ];
        
        NSMutableArray *tableViewModelArrayM = [[NSMutableArray alloc]init];
        for (int i = 0; i < tableViewImageArray.count; i++) {
            NSString *imageName = tableViewImageArray[i];
            NSString *title = self.tableViewTitleArray[i];
            HXBFinDetail_TableViewCellModel *model = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:imageName andOptionIitle:title];
            [tableViewModelArrayM addObject:model];
        }
        _tableViewModelArray = tableViewModelArrayM.copy;
    }
    return _tableViewModelArray;
}

- (void)setLoanDetailViewModel:(HXBFin_DetailsView_LoanDetailsView_ViewModelVM *)viewModelVM {
    viewModelVM.totalInterestStr           = [NSString stringWithFormat:@"%.1f", [self.loanDetailModel.totalInterestPer100 floatValue]];///年利率
    viewModelVM.totalInterestStr_const     = @"年利率";
    viewModelVM.remainAmount               = self.loanDetailModel.surplusAmount;
    viewModelVM.remainAmount_const         = self.loanDetailModel.surplusAmount_ConstStr;
    viewModelVM.startInvestmentStr         = self.loanDetailModel.months;
    viewModelVM.startInvestmentStr_const   = @"标的期限";
    viewModelVM.promptStr                  = @"- 预期收益不代表实际收益，出借需谨慎 -";
    viewModelVM.addButtonStr               = self.loanDetailModel.addButtonStr;
    viewModelVM.remainAmount_const         = self.loanDetailModel.surplusAmount_ConstStr;
    viewModelVM.remainAmount               = self.loanDetailModel.surplusAmount;
    viewModelVM.isUserInteractionEnabled   = self.loanDetailModel.isAddButtonEditing;
    viewModelVM.remainTime                 = self.loanDetailModel.loanDetailModel.remainTime;
    viewModelVM.addButtonTitleColor        = self.loanDetailModel.addButtonTitleColor;
    viewModelVM.addButtonBackgroundColor   = self.loanDetailModel.addButtonBackgroundColor;
    viewModelVM.title                      = @"散标出借";
    
}

- (HXBFin_Loan_Buy_ViewController *)getALoanBuyController:(NSString *)hasBindCard userInfoViewModel:(HXBRequestUserInfoViewModel*)model{
    //跳转加入界
    HXBFin_Loan_Buy_ViewController *loanJoinVC = [[HXBFin_Loan_Buy_ViewController alloc]init];
    loanJoinVC.title                    = @"出借散标";
    loanJoinVC.availablePoint           = [NSString stringWithFormat:@"%.lf", self.loanDetailModel.loanDetailModel.loanVo.surplusAmount.doubleValue];
    loanJoinVC.placeholderStr           = self.loanDetailModel.addCondition;
    loanJoinVC.hasBindCard              = hasBindCard;
    loanJoinVC.loanId                   = self.loanDetailModel.loanDetailModel.userVo.loanId;
    loanJoinVC.minRegisterAmount        = self.loanDetailModel.loanDetailModel.minInverst;
    loanJoinVC.registerMultipleAmount   = self.loanDetailModel.loanDetailModel.minInverst;
    loanJoinVC.userInfoViewModel        = model;
    loanJoinVC.riskType = self.loanDetailModel.loanDetailModel.loanVo.riskLevel;
    
    return loanJoinVC;
}

- (void)requestLoanDetailWithLoanId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *loanDetaileAPI = [[NYBaseRequest alloc]initWithDelegate:self];
    loanDetaileAPI.requestUrl = kHXBFinanc_LoanDetaileURL(loanId.integerValue);
    loanDetaileAPI.showHud = YES;
    
    [loanDetaileAPI loadData:^(NYBaseRequest *request, id responseObject) {
        ///数据是否出错
        if ([responseObject[kResponseStatus] integerValue]) {
            kNetWorkError(@"散标详情页 没有数据");
            if (resultBlock) {
                resultBlock(NO);
            }
        }
        
        NSDictionary *planDetaileDic = [responseObject valueForKey:@"data"];
        HXBFinDatailModel_LoanDetail *loanDetaileModel = [[HXBFinDatailModel_LoanDetail alloc]init];
        [loanDetaileModel yy_modelSetWithDictionary:planDetaileDic];
        HXBFinDetailViewModel_LoanDetail *loanDetailViewModel = [[HXBFinDetailViewModel_LoanDetail alloc]init];
        loanDetailViewModel.loanDetailModel = loanDetaileModel;
        self.loanDetailModel = loanDetailViewModel;
        if (!loanDetailViewModel.loanDetailModel) {
            kNetWorkError(@"散标详情 没有数据");
            if (resultBlock) resultBlock(NO);
            return;
        }
        if (resultBlock) {
            resultBlock(YES);
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            kNetWorkError(@"✘散标计划详情 - 请求没有数据")
            resultBlock(NO);
        }
    }];
}

@end

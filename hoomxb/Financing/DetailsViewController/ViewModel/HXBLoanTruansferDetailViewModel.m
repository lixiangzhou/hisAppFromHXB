//
//  HXBLoanTruansferDetailViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/15.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBLoanTruansferDetailViewModel.h"

@implementation HXBLoanTruansferDetailViewModel

- (NSArray *) tableViewTitleArray {
    if (!_tableViewTitleArray) {
        _tableViewTitleArray = @[@"借款信息", @"转让记录", @"债权转让及受让协议"];
    }
    return _tableViewTitleArray;
}

- (HXBFin_creditorChange_buy_ViewController *)getACreditorChangeBuyController:(NSString *)hasBindCard userInfo:(HXBRequestUserInfoViewModel *)viewModel{
    
    HXBFin_creditorChange_buy_ViewController *loanJoinVC = [[HXBFin_creditorChange_buy_ViewController alloc]init];
    loanJoinVC.title = @"出借债权";
    loanJoinVC.loanId = self.loanTruansferDetailModel.loanTruansferDetailModel.transferId;
    loanJoinVC.hasBindCard = hasBindCard;
    loanJoinVC.placeholderStr = self.loanTruansferDetailModel.startIncrease_Amount;
    loanJoinVC.availablePoint = self.loanTruansferDetailModel.loanTruansferDetailModel.leftTransAmount;
    loanJoinVC.minRegisterAmount = self.loanTruansferDetailModel.loanTruansferDetailModel.minInverst;
    loanJoinVC.registerMultipleAmount = self.loanTruansferDetailModel.loanTruansferDetailModel.minInverst;
    loanJoinVC.userInfoViewModel        = viewModel;
    loanJoinVC.riskType = self.loanTruansferDetailModel.loanTruansferDetailModel.loanVo.riskLevel;
    
    return loanJoinVC;
}

- (void)requestLoanDetailWithLoanTruansferId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *loanTruansferRequest = [[NYBaseRequest alloc]initWithDelegate:self];
    loanTruansferRequest.requestUrl = kHXBFin_LoanTruansfer_DetailURL(loanId.integerValue);
    loanTruansferRequest.showHud = YES;
    
    [loanTruansferRequest loadData:^(NYBaseRequest *request, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            if (resultBlock) {
                resultBlock(NO);
            }
            kNetWorkError(@"债转详情");
            return;
        }
        NSDictionary *dataDic = responseObject[kResponseData];
        
        HXBFinDetailViewModel_LoanTruansferDetail *viewModel = [[HXBFinDetailViewModel_LoanTruansferDetail alloc]init];
        HXBFinDetailModel_LoanTruansferDetail *loanTruansferModel = [[HXBFinDetailModel_LoanTruansferDetail alloc]init];
        [loanTruansferModel yy_modelSetWithDictionary:dataDic];
        viewModel.loanTruansferDetailModel = loanTruansferModel;
        self.loanTruansferDetailModel = viewModel;
        if (resultBlock) {
            resultBlock(YES);
        }
        
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

@end

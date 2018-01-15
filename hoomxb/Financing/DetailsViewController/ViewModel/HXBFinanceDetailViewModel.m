//
//  HXBFinanceDetailViewModel.m
//  hoomxb
//
//  Created by lxz on 2018/1/11.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanceDetailViewModel.h"

@implementation HXBFinanceDetailViewModel




- (void)requestLoanDetailWithLoanTruansferId:(NSString *)loanId resultBlock:(void (^)(BOOL isSuccess))resultBlock {
    HXBBaseRequest *loanTruansferRequest = [[HXBBaseRequest alloc]initWithDelegate:self];
    loanTruansferRequest.requestUrl = kHXBFin_LoanTruansfer_DetailURL(loanId.integerValue);
    
    [loanTruansferRequest loadDataWithSuccess:^(HXBBaseRequest *request, id responseObject) {
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
        
    } failure:^(HXBBaseRequest *request, NSError *error) {
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

@end

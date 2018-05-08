//
//  HXBMyLoanDetailsViewModel.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/6.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyLoanDetailsViewModel.h"
#import "HXBTransferConfirmModel.h"

@interface HXBMyLoanDetailsViewModel()

@property (nonatomic, readwrite, strong) NSDictionary *responseObject;

@end

@implementation HXBMyLoanDetailsViewModel

- (instancetype)initWithBlock:(HugViewBlock)hugViewBlock {
    self = [super initWithBlock:hugViewBlock];
    if (self) {
        _transferConfirmModel = [[HXBTransferConfirmModel alloc] init];
        _responseObject = [[NSDictionary alloc] init];
    }
    return self;
}

// 账户内-债权转让确认页
- (void)accountLoanTransferRequestWithTransferID: (NSString *)transferID
                                     resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestUrl = kHXBFin_TransferRecordURL;
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = @{@"loanId": transferID};
    request.showHud = NO;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSDictionary *dataDic = responseObject[kResponseData];
        [weakSelf.transferConfirmModel yy_modelSetWithDictionary:dataDic];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

// 账户内-债权转让功能接口
- (void)accountLoanTransferRequestResultWithParams:(NSDictionary *)params
                                       resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestArgument = params;
    request.requestUrl = kHXBFin_TransferResultURL;
    kWeakSelf
    [request loadData:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSLog(@"responseObject = %@", responseObject);
        weakSelf.resultModel = [[HXBLazyCatRequestModel alloc] init];
        NSDictionary *data = responseObject[kResponseData];
        [weakSelf.resultModel yy_modelSetWithDictionary:data];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}


@end

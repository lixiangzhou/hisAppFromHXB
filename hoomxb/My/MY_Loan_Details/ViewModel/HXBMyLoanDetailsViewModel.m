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
    request.requestUrl = kHXBFin_TransferRecordURL(transferID);
    request.requestMethod = NYRequestMethodPost;
    request.showHud = NO;
    kWeakSelf
    [request startWithSuccess:^(NYBaseRequest *request, NSDictionary *responseObject) {
        kHXBResponsResultShowHUD
        NSDictionary *dataDic = responseObject[kResponseData];
        [weakSelf.transferConfirmModel yy_modelSetWithDictionary:dataDic];
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}

// 账户内-债权转让功能接口
- (void)accountLoanTransferRequestResultWithTransferID: (NSString *)transferID
                                              password:(NSString *)password
                                  currentTransferValue:(NSString *)currentTransferValue
                                           resultBlock: (void(^)(BOOL isSuccess))resultBlock {
    NYBaseRequest *request = [[NYBaseRequest alloc] initWithDelegate:self];
    request.requestMethod = NYRequestMethodPost;
    request.requestUrl = kHXBFin_TransferResultURL(transferID);
    currentTransferValue = currentTransferValue ? currentTransferValue : @"";
    request.requestArgument = @{@"tradPassword" : password, @"currentTransferValue" : currentTransferValue};
    request.showHud = NO;
    kWeakSelf
    [request startWithSuccess:^(NYBaseRequest *request, NSDictionary *responseObject) {
        NSLog(@"responseObject = %@", responseObject);
        weakSelf.responseObject = responseObject;
//        kHXBResponsResultShowHUD
        if (resultBlock) resultBlock(YES);
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (resultBlock) resultBlock(NO);
    }];
}



@end

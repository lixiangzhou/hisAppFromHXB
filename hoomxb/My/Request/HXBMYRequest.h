//
//  HXBMYRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBMYViewModel_MianPlanViewModel.h"//主界面 planViewModel
#import "HXBMYViewModel_MainLoanViewModel.h"//主界面的 loanViewModel
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"//主界面 资产记录 ViewMOdel
#import "HXBBaseRequest.h"
#import "HXBMY_LoanTruansferViewModel.h"
#import "HXBBaseViewModel.h"

@class HXBMYModel_AssetStatistics_Plan;//资金统计的Model plan
@class HXBMYModel_AssetStatistics_Loan;//资金统计的Model loan
@class HXBMYModel_Plan_planRequestModel;///plan 资产目录
@class HXBMYModel_Loan_LoanRequestModel;///loan 资产目录
@class HXBMY_PlanViewModel_LoanRecordViewModel;
@class HXBTransferConfirmModel;
///关于个人主页的红利计划的 （账户内）
@interface HXBMYRequest : HXBBaseViewModel
///创建单利对象
+ (instancetype) sharedMYRequest;

/**
 交易记录是否显示加载框
 */
@property (nonatomic, assign) BOOL isShowHUD;

#pragma mark - 主要页面的网络请求
///plan 详情页的 交易记录
- (void)loanRecord_my_Plan_WithIsUPData: (BOOL)isUPData
                      andWithRequestUrl: (NSString *)requestUrl
                              andPlanID: (NSString *)planID
                        andSuccessBlock: (void(^)(NSArray<HXBMY_PlanViewModel_LoanRecordViewModel *>* viewModelArray))successDateBlock
                        andFailureBlock: (void(^)(NSError *error))failureBlock;

/**
 账户内-债权转让确认页
 */
- (void)transferRequest_AccountRequestTransferID: (NSString *)transferID
                                       SuccessBlock: (void(^)(HXBTransferConfirmModel *transferConfirmModel))successDateBlock
                                   andFailureBlock: (void(^)(NSError *error))failureBlock;
/**
 账户内-债权转让功能接口
 */
- (void)transferResultRequest_AccountRequestTransferID: (NSString *)transferID
                                                andPWD:(NSString *)pwd
                               andCurrentTransferValue:(NSString *)currentTransferValue
                                          SuccessBlock: (void(^)(id responseObject))successDateBlock
                                       andFailureBlock: (void(^)(NSError *error,id responseObject))failureBlock;
@end

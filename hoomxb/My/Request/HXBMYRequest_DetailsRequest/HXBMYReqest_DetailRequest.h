//
//  HXBMYReqest_DetailRequest.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBMYViewModel_PlanDetailViewModel;
@class HXBMYViewModel_LoanDetailViewModel;
@class HXBMYViewModel_MainCapitalRecortdDetailViewModel;

///里面包含了详情接口，以及 资产统计接口
@interface HXBMYReqest_DetailRequest : NSObject
//MARK: 计划详情 接口
/**
 * 计划列表详情接口
 * @param planID planID
 */
- (void)planListDetails_requestWithFinancePlanID: (NSString *)planID
                                 andSuccessBlock: (void(^)(HXBMYViewModel_PlanDetailViewModel *viewModel))successDateBlock
                                 andFailureBlock: (void(^)(NSError *error))failureBlock;

//MARK: 散标详情 接口
/**
 * 计划 投资记录
 * @param loanID loanID
 * @param requestType 请求类型
 */
- (void)loanListDetails_requestWithFinancePlanID: (NSString *)loanID
                                  andRequestType: (NSString *)requestType
                                 andSuccessBlock: (void(^)(HXBMYViewModel_LoanDetailViewModel *viewModelArray))successDateBlock
                                 andFailureBlock: (void(^)(NSError *error))failureBlock;


@end

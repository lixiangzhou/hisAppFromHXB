//
//  HXBMyPlanCapitalRecordViewModel.h
//  hoomxb
//
//  Created by hxb on 2018/2/8.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBMY_PlanViewModel_LoanRecordViewModel.h"

@interface HXBMyPlanCapitalRecordViewModel : HXBBaseViewModel

@property (nonatomic,assign) NSInteger planLoanRecordPage;
@property (nonatomic,assign) NSUInteger currentPageCount;
@property (nonatomic,strong) NSMutableArray <HXBMY_PlanViewModel_LoanRecordViewModel *>* planLoanRecordViewModel_array;
///plan 详情页的 交易记录
- (void)loanRecord_my_Plan_WithRequestUrl: (NSString *)requestUrl
                                 andPlanID: (NSString *)planID
                           andSuccessBlock: (void(^)(BOOL isSuccess))successDateBlock
                          andFailureBlock: (void(^)(NSError *error))failureBlock;

@end

//
//  HXBFinancialAdvisorRequest.h
//  hoomxb
//
//  Created by hxb on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"

@class HXBFinancialAdvisorModel;
@interface HXBFinancialAdvisorVCViewModel : HXBBaseViewModel

@property (nonatomic, strong) HXBFinancialAdvisorModel *financialAdvisorModel;

/**
 获取理财顾问信息

 @param callBackBlock   回调
 */
- (void)downLoadmyFinancialAdvisorInfoNoHUDWithCallBack:(void(^)(BOOL isSuccess))callBackBlock;

@end

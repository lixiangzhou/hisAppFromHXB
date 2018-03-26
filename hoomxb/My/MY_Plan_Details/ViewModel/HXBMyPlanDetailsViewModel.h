//
//  HXBMyPlanDetailsViewModel.h
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/2/7.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewModel.h"
#import "HXBBaseViewModel+KEYCHAIN.h"
#import "HXBMyPlanDetailsExitModel.h"

@class HXBMYViewModel_PlanDetailViewModel;
@class HXBMYModel_PlanDetailModel;

@interface HXBMyPlanDetailsViewModel : HXBBaseViewModel
// 计划列表详情数据源
@property (nonatomic, readonly, strong) HXBMYViewModel_PlanDetailViewModel *planDetailsViewModel;
@property (nonatomic,strong) HXBMyPlanDetailsExitModel *myPlanDetailsExitModel;
/**
 * 计划列表详情接口
 * @param planID 计划id
 */
- (void)accountPlanListDetailsRequestWithPlanID: (NSString *)planID
                                    resultBlock: (void(^)(BOOL isSuccess))resultBlock;

/**
 * 撤销计划退出
 * @param planID 计划id
 */
- (void)accountPlanQuitRequestWithPlanID: (NSString *)planID
                             resultBlock: (void(^)(BOOL isSuccess))resultBlock;


/**
 冷静期获取账户内红利计划取消加入退出信息
 
 @param planID 计划ID
 @param resultBlock resultBlock description
 */
- (void)loadPlanListDetailsCancelExitInfoWithPlanID: (NSString *)planID
                                  resultBlock: (void(^)(BOOL isSuccess))resultBlock;

@end

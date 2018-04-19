//
//  HXBMyPlanDetailsExitMainView.h
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBMyPlanDetailsExitModel.h"
@class HXBMyPlanDetailsExitMainViewManager;
@interface HXBMyPlanDetailsExitMainView : UIView

@property (nonatomic,strong) HXBMyPlanDetailsExitMainViewManager *manager;
@property (nonatomic,strong) HXBMyPlanDetailsExitModel *myPlanDetailsExitModel;

- (void)setValueManager_PlanDetail_Detail: (HXBMyPlanDetailsExitMainViewManager *(^)(HXBMyPlanDetailsExitMainViewManager *manager))planDDetailManagerBlock;
/**
 确认退出
 */
@property (nonatomic, copy) void(^exitBtnClickBlock)();
/**
 暂不退出
 */
@property (nonatomic, copy) void(^cancelBtnClickBlock)();

@end

@interface HXBMyPlanDetailsExitMainViewManager: NSObject

/**
 加入本金
 当前已赚
 退出时间
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *topViewManager;

@end

//
//  HXBMY_PlanDetailView.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_PlanDetailViewModel;
@class HXBMY_PlanDetailView_Manager;
#import "HXBBaseView_TwoLable_View.h"///两个label的组件
#import "HXBBaseView_MoreTopBottomView.h"///多个topBottomView
@interface HXBMY_PlanDetailView : UIView
@property (nonatomic,strong) HXBMYViewModel_PlanDetailViewModel *planDetailViewModel;

- (void)setUPValueWithViewManagerBlock: (HXBMY_PlanDetailView_Manager *(^)(HXBMY_PlanDetailView_Manager *manager))viewManagerBlock;
@end

@interface HXBMY_PlanDetailView_Manager : NSObject

/**
 顶部的VIew状态
 */
@property (nonatomic,copy) NSString                                 *topViewStatusStr;
/**
 topViewMassge
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager      *topViewMassgeManager;
/**
 标信息的view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager     *infoViewManager;
/**
 type view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager      *typeViewManager;
/**
 合同view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager      *contractViewManager;
/**
 投资记录
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager      *loanRecordViewManager;

@end

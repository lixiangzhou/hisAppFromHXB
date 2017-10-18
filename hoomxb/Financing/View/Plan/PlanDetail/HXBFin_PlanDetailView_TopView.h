//
//  HXBFin_PlanDetailView_TopView.h
//  hoomxb
//
//  Created by HXB on 2017/7/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBColourGradientView.h"
@class HXBFin_PlanDetailView_TopViewManager;

@interface HXBFin_PlanDetailView_TopView : HXBColourGradientView

@property (nonatomic, assign) NSUInteger attributeStringLength;
@property (nonatomic,strong) HXBFin_PlanDetailView_TopViewManager *manager;
- (void)setUPValueWithManager: (HXBFin_PlanDetailView_TopViewManager *(^)(HXBFin_PlanDetailView_TopViewManager *manager))managerBlock;


@end

@interface HXBFin_PlanDetailView_TopViewManager : NSObject
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *topViewManager;//预期年化
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *leftViewManager;//期限
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *midViewManager;//起头
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel *rightViewManager;//剩余金额



@end

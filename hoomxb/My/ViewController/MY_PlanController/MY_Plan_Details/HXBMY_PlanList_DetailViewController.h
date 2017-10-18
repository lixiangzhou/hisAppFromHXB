//
//  HXBMY_PlanList_DetailViewController.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"
@class HXBMYViewModel_MianPlanViewModel;///红利计划的ViewModel
@interface HXBMY_PlanList_DetailViewController : HXBBaseViewController
@property (nonatomic,strong) HXBMYViewModel_MianPlanViewModel *planViewModel;
@property (nonatomic,assign) BOOL isLeave;
/**
 判断是持有中、退出中、已退出
 */
@property (nonatomic, assign) HXBRequestType_MY_PlanRequestType type;
- (void)setUPValue;
@end

//
//  HXBMYList_plan_ Hold_TableView.h
//  hoomxb
//
//  Created by HXB on 2017/8/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_MianPlanViewModel;
@class HXBMYViewModel_MainLoanViewModel;
@interface HXBMYList_plan_Hold_TableView : UITableView
///数据源
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*mainPlanViewModelArray;
///点击了cell
- (void)clickPlanCellFuncWithBlock: (void(^)(HXBMYViewModel_MianPlanViewModel *planViewModel, NSIndexPath *clickPlanCellIndex))clickPlanCellBlock;
@end

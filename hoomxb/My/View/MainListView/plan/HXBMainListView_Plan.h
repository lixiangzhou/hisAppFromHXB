//
//  HXBMainListView_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_MianPlanViewModel;


@interface HXBMainListView_Plan : UIView
//MARK: - 数据源
///持有中
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*hold_Plan_array;
///plan 推出中
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*exiting_Plan_array;
///plan 已退出
@property (nonatomic,strong) NSArray <HXBMYViewModel_MianPlanViewModel *>*exit_Plan_array;
@end

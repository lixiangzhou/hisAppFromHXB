//
//  HXBFin_DetailsViewBase.h
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinDetail_TableViewCellModel;
@class HXBFinDetailViewModel_PlanDetail;
@class HXBFinDetailViewModel_LoanDetail;
///详情页的主视图基类
@interface HXBFin_DetailsViewBase : UIView

///显示视图，在给相关的属性赋值后，一定要调用show方法
- (void)show;
///剩余可投是否分为左右两个
@property (nonatomic,assign) BOOL isFlowChart;
///是否为红利计划
@property (nonatomic,assign) BOOL isPlan;
///底部的tableView的模型数组
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*modelArray;
///计划详情的ViewModel
@property (nonatomic,strong) HXBFinDetailViewModel_PlanDetail *planDetailViewModel;
///散标的ViewModel
@property (nonatomic,strong) HXBFinDetailViewModel_LoanDetail *loanDetailViewModel;
///点击了 详情页底部的tableView的cell
- (void)clickBottomTableViewCellBloakFunc: (void(^)(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model))clickBottomTabelViewCellBlock;
@end

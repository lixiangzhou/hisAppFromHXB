//
//  HXBFin_DetailsView_LoanDetailsView.h
//  hoomxb
//
//  Created by HXB on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailsViewBase.h"
@class HXBFin_DetailsView_LoanDetailsView_ViewModelVM;
@interface HXBFin_DetailsView_LoanDetailsView : UIView
///期限
@property (nonatomic,copy) NSString *timeStr;
///倒计时label
@property (nonatomic,copy) NSString *countDownStr;
///加入的button
@property (nonatomic,strong) UIButton *addButton;
- (void)setSubView;
- (void)setUPViewModelVM: (HXBFin_DetailsView_LoanDetailsView_ViewModelVM * (^)(HXBFin_DetailsView_LoanDetailsView_ViewModelVM *viewModelVM))detailsViewBase_ViewModelVM;

///赋值_plan
- (void)setData_PlanWithPlanDetailViewModel:(HXBFinDetailViewModel_PlanDetail *)planDetailVieModel;

///显示视图，在给相关的属性赋值后，一定要调用show方法
- (void)show;

///底部的tableView的模型数组
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>* modelArray;

///点击了 详情页底部的tableView的cell
- (void)clickBottomTableViewCellBloakFunc: (void(^)(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model))clickBottomTabelViewCellBlock;

/// 点击了立即加入的button
- (void) clickAddButtonFunc: (void(^)())clickAddButtonBlock;

///点击了增信
- (void)clickAddTrustWithBlock:(void(^)())clickAddTrustBlock;
@end



@interface HXBFin_DetailsView_LoanDetailsView_ViewModelVM : NSObject

///* 预期收益不代表实际收益投资需谨慎
@property (nonatomic,copy) NSString *promptStr;
/// title
@property (nonatomic,copy) NSString *title;
///预期计划
@property (nonatomic,copy) NSString *totalInterestStr;
///红利计划为：预期年利率 散标为：年利率
@property (nonatomic,copy) NSString *totalInterestStr_const;

///红利计划：（起投 固定值1000） 散标：（标的期限）
@property (nonatomic,copy) NSString *startInvestmentStr;
@property (nonatomic,copy) NSString *startInvestmentStr_const;

///红利计划：剩余金额 散标列表是（剩余金额）
@property (nonatomic,copy) NSString *remainAmount;
@property (nonatomic,copy) NSString *remainAmount_const;

@property (nonatomic,copy) NSString *addButtonStr;
///期限的string
@property (nonatomic,copy) NSString *lockPeriodStr;
/// 倒计时时间
@property (nonatomic,copy) NSString *countDownStr;
///剩余时间
@property (nonatomic,copy) NSString *remainTime;
/// 倒计时
@property (nonatomic,copy) NSString *diffTime;
///是否倒计时
@property (nonatomic,assign) BOOL isCountDown;
///是否可以点击 addbutton
@property (nonatomic,assign) BOOL isUserInteractionEnabled;
/// 加入按钮的颜色
@property (nonatomic,strong) UIColor *addButtonBackgroundColor;
///加入按钮的字体颜色
@property (nonatomic,strong) UIColor *addButtonTitleColor;
///addbutton 边缘的颜色
@property (nonatomic,strong) UIColor *addButtonBorderColor;
/// 起息日
@property (nonatomic, copy) NSString *interestDate;
/// 标的状态
@property (nonatomic, copy) NSString *status;
@end

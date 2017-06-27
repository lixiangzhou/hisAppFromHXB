//
//  HXBMY_Loan_DetailView.m
//  hoomxb
//
//  Created by HXB on 2017/6/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_Loan_DetailView.h"

#import "HXBMYViewModel_LoanDetailViewModel.h"//loan  detail viewModel

@interface HXBMY_Loan_DetailView ()

/**
 顶部的View
 */
@property (nonatomic,strong) UIView *topView;
/**
 代售金额
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *toRepayLable;
/**
 下一个还款日
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *nextRepayDateLable;
/**
 月收本金
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *monthlyPrincipal;
/**
 已还期数
 */
@property (nonatomic,strong) UILabel *termsLeft;

/**
 中间的展示信息的view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *infoView;
/**
 合同
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *contractLabel;
///manager
@property (nonatomic,strong) HXBMY_Loan_DetailViewManager *manager;
@end

@implementation HXBMY_Loan_DetailView

- (void)setUPValueWithManagerBlock: (HXBMY_Loan_DetailViewManager *(^)(HXBMY_Loan_DetailViewManager *manager))managerBlock {
    self.manager = managerBlock(self.manager);
}
- (void)setManager:(HXBMY_Loan_DetailViewManager *)manager {
    _manager = manager;
    self.termsLeft.text = manager.termsLeftStr;
    //topView setUP
    [self.toRepayLable setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.toRepayLableManager;
    }];
    [self.nextRepayDateLable setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.nextRepayDateLableManager;
    }];
    [self.monthlyPrincipal setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.monthlyPrincipalManager;
    }];
    
    //info setUP
    [self.infoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return manager.infoViewManager;
    }];
    
    //合同 setuP
    [self.contractLabel setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
       return manager.contractLabelManager;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _manager = [[HXBMY_Loan_DetailViewManager alloc]init];
        [self setUP];
    }
    return self;
}

- (void)setUP {
    [self setUPTopView];//顶部的view]
    [self setUPInfoView];//中间的info的view
    [self setUPContractLabel];//底部的合同
    [self setUPViewFrame];//设置frame
}
//顶部的view
- (void) setUPTopView {
    self.topView            = [[UIView alloc]init];
    self.toRepayLable       = [[HXBBaseView_TwoLable_View alloc]init];
    self.nextRepayDateLable = [[HXBBaseView_TwoLable_View alloc]init];
    self.monthlyPrincipal   = [[HXBBaseView_TwoLable_View alloc]init];
    [self addSubview:self.topView];
    [self.topView addSubview:self.toRepayLable];
    [self.topView addSubview:self.monthlyPrincipal];
    [self.topView addSubview:self.nextRepayDateLable];
}
//中间的infoView
- (void)setUPInfoView {
    self.infoView = [[HXBBaseView_MoreTopBottomView alloc] initWithFrame:CGRectZero andTopBottomViewNumber:5 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(30) andTopBottomSpace:0];
    [self addSubview:self.infoView];
}
//合同
- (void)setUPContractLabel {
    self.contractLabel = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:1 andViewClass:[UILabel class] andViewHeight:30 andTopBottomSpace:0];
    [self addSubview:self.contractLabel];
}
//设置frame
- (void)setUPViewFrame {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(100)));
    }];
    [self.toRepayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).offset(kScrAdaptationH(10));
        make.centerX.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(30)));
        make.left.right.equalTo(self);
    }];
    [self.nextRepayDateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView);
        make.left.equalTo(self.topView);
        make.right.equalTo(self.topView.mas_centerX);
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
    [self.monthlyPrincipal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView);
        make.right.equalTo(self.topView);
        make.left.equalTo(self.topView.mas_centerX);
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
    
    //中间的info
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(kScrAdaptationH(8));
        make.right.left.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(160)));
    }];
    [self.contractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(kScrAdaptationH(-80)));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
}
@end
@implementation HXBMY_Loan_DetailViewManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.toRepayLableManager        = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.nextRepayDateLableManager  = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.monthlyPrincipalManager    = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.infoViewManager            = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        self.contractLabelManager       = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    }
    return self;
}
@end

//
//  HXBMainListView_Plan_TopView.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMainListView_Plan_TopView.h"
@interface HXBMainListView_Plan_TopView ()


/**
 持有资产(元)
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *financePlanAssetsView;
/**
 累计收益
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *financePlanSumPlanInterestView;
@end
@implementation HXBMainListView_Plan_TopView

- (void)setUPValueWithManagerBlock: (HXBMainListView_Plan_TopViewManager *(^)(HXBMainListView_Plan_TopViewManager *manager))managerBlock {
    self.manager = managerBlock(_manager);
}
- (void)setManager:(HXBMainListView_Plan_TopViewManager *)manager {
    [self.financePlanAssetsView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = @"持有资产(元)";
        viewModelVM.rightLabelStr = manager.finance;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    [self.financePlanSumPlanInterestView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = @"累计收益(元)";
        viewModelVM.rightLabelStr = manager.interest;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self  = [super initWithFrame: frame]) {
        [self setUP];
        _manager = [[HXBMainListView_Plan_TopViewManager alloc]init];
    }
    return self;
}
- (void)setUP {
   
    self.financePlanAssetsView = [[HXBBaseView_TwoLable_View alloc]init];
    self.financePlanSumPlanInterestView = [[HXBBaseView_TwoLable_View alloc]init];
    [self addSubview:self.financePlanSumPlanInterestView];
    [self addSubview:self.financePlanAssetsView];
}


- (void) willMoveToSuperview:(UIView *)newSuperview {
    [self setUPFrame];
}
- (void) setUPFrame {
    ///持有资产
    [self.financePlanAssetsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(20));
        make.height.equalTo(@(kScrAdaptationH(40)));
        make.left.right.equalTo(self);
    }];
    [self.financePlanSumPlanInterestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.financePlanAssetsView.mas_bottom).offset(kScrAdaptationH(10));
        make.height.equalTo(@(kScrAdaptationH(30)));
        make.left.right.equalTo(self);
    }];
}
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel {
    _userInfoViewModel = userInfoViewModel;
    [self.financePlanAssetsView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = @"持有资产(元)";
        viewModelVM.rightLabelStr = userInfoViewModel.financePlanAssets;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    [self.financePlanSumPlanInterestView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = @"累计收益(元)";
        viewModelVM.rightLabelStr = userInfoViewModel.financePlanSumPlanInterest;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
}
- (void)setValue {
    [[KeyChainManage sharedInstance] downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
       [self.financePlanAssetsView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = @"持有资产(元)";
            viewModelVM.rightLabelStr = viewModel.lenderPrincipal;
           return viewModelVM;
       }];
        [self.financePlanSumPlanInterestView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
            viewModelVM.leftLabelStr = @"累计收益(元)";
            viewModelVM.rightLabelStr = viewModel.lenderEarned;
            return viewModelVM;
        }];
    } andFailure:^(NSError *error) {
    }];
}
@end
@implementation HXBMainListView_Plan_TopViewManager

@end

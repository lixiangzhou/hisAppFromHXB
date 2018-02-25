//
//  HXBMainListView_Plan_TopView.m
//  hoomxb
//
//  Created by HXB on 2017/5/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
        viewModelVM.rightLabelStr = @"持有资产(元)";
        viewModelVM.leftLabelStr = manager.finance;
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(24);
        
        viewModelVM.rightViewColor = kHXBColor_RGB(1, 1, 1, 0.6);
        viewModelVM.leftViewColor = [UIColor whiteColor];
        
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    [self.financePlanSumPlanInterestView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.rightLabelStr = @"累计收益(元)";
        if ([manager.interest containsString:@"-"]) {
            manager.interest = @"0.00元";
        }
        viewModelVM.leftLabelStr = manager.interest;
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(24);
        
        viewModelVM.rightViewColor = kHXBColor_RGB(1, 1, 1, 0.6);
        viewModelVM.leftViewColor = [UIColor whiteColor];
        
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
//    self.endPoint = CGPointMake(0, self.height);
//    self.startPoint = CGPointMake(self.width, 0);
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@1);
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
    lineView.backgroundColor = kHXBColor_RGB(1, 1, 1, 0.15);
    self.financePlanAssetsView = [[HXBBaseView_TwoLable_View alloc]init];
    self.financePlanSumPlanInterestView = [[HXBBaseView_TwoLable_View alloc]init];
    [self addSubview:self.financePlanSumPlanInterestView];
    [self addSubview:self.financePlanAssetsView];
    ///持有资产
    [self.financePlanAssetsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineView.mas_centerY).offset(-kScrAdaptationH(25));
        make.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    [self.financePlanSumPlanInterestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(self.financePlanAssetsView);
        make.left.equalTo(self.financePlanAssetsView.mas_right);
    }];
}


- (void) setUPFrame {
}
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel {
    _userInfoViewModel = userInfoViewModel;
    [self.financePlanAssetsView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.rightLabelStr = @"持有资产(元)";
        viewModelVM.leftLabelStr = userInfoViewModel.financePlanAssets_NOTYUAN;
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(24);
        
        viewModelVM.rightViewColor = kHXBColor_RGB(1, 1, 1, 0.6);
        viewModelVM.leftViewColor = [UIColor whiteColor];
        
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    [self.financePlanSumPlanInterestView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.rightLabelStr = @"累计收益(元)";
        if ([userInfoViewModel.financePlanSumPlanInterest containsString:@"-"]) {
            userInfoViewModel.financePlanSumPlanInterest = @"0.00";
        }
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(12);
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(24);
        
        viewModelVM.rightViewColor = kHXBColor_RGB(1, 1, 1, 0.6);
        viewModelVM.leftViewColor = [UIColor whiteColor];
        
        viewModelVM.leftLabelStr = userInfoViewModel.financePlanSumPlanInterest_NOTYUAN;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
}
- (void)setValue {
    kWeakSelf
    [KeyChain downLoadUserInfoWithResultBlock:nil resultBlock:^(HXBRequestUserInfoViewModel *viewModel, NSError *error) {
        if (viewModel) {
            [weakSelf.financePlanAssetsView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
                viewModelVM.leftLabelStr = @"持有资产(元)";
                viewModelVM.rightLabelStr = viewModel.lenderPrincipal;
                return viewModelVM;
            }];
            [weakSelf.financePlanSumPlanInterestView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
                viewModelVM.leftLabelStr = @"累计收益(元)";
                viewModelVM.rightLabelStr = viewModel.lenderEarned;
                return viewModelVM;
            }];
        }
    }];
    
}
@end
@implementation HXBMainListView_Plan_TopViewManager

@end

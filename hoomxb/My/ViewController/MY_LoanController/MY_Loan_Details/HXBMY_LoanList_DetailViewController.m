//
//  HXBMY_LoanList_DetailViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_LoanList_DetailViewController.h"
#import "HXBMY_Loan_DetailView.h"
#import "HXBMYViewModel_MainLoanViewModel.h"
@interface HXBMY_LoanList_DetailViewController ()
/**
 散标详情
 */
@property (nonatomic,strong) HXBMY_Loan_DetailView *loanDetailView;
@property (nonatomic,strong) UILabel *timeLabel;
@end

@implementation HXBMY_LoanList_DetailViewController

- (void) setLoanDetailViewModel:(HXBMYViewModel_MainLoanViewModel *)loanDetailViewModel {
    _loanDetailViewModel = loanDetailViewModel;
    kWeakSelf

    [self.loanDetailView setUPValueWithManagerBlock:^HXBMY_Loan_DetailViewManager *(HXBMY_Loan_DetailViewManager *manager) {
        _loanDetailViewModel = loanDetailViewModel;
        
        manager.termsLeftStr = weakSelf.loanDetailViewModel.goBackLoanTime;
        
        manager.toRepayLableManager.isLeftRight         = false;
        manager.toRepayLableManager.leftLabelStr        = @"待收金额（元）";
        manager.toRepayLableManager.rightLabelStr       = weakSelf.loanDetailViewModel.toRepay;
        manager.toRepayLableManager.leftLabelAlignment  = NSTextAlignmentCenter;
        manager.toRepayLableManager.rightLabelAlignment = NSTextAlignmentCenter;
        
        manager.nextRepayDateLableManager.isLeftRight   = false;
        manager.nextRepayDateLableManager.leftLabelStr  = @"下一还款日";
        manager.nextRepayDateLableManager.rightLabelStr = weakSelf.loanDetailViewModel.nextRepayDate;
        manager.nextRepayDateLableManager.leftLabelAlignment = NSTextAlignmentCenter;
        manager.nextRepayDateLableManager.rightLabelAlignment = NSTextAlignmentCenter;
        
        manager.monthlyPrincipalManager.isLeftRight     = false;
        manager.monthlyPrincipalManager.leftLabelStr    = @"月收本息（元）";
        manager.monthlyPrincipalManager.rightLabelStr   = weakSelf.loanDetailViewModel.monthlyRepay;
        manager.monthlyPrincipalManager.leftLabelAlignment = NSTextAlignmentCenter;
        manager.monthlyPrincipalManager.rightLabelAlignment = NSTextAlignmentCenter;
        
        manager.infoViewManager.leftStrArray = @[
                                                 @"投资金额",
                                                 @"利率",
                                                 @"期限",
                                                 @"还款方式",
                                                 @"已收本息"
                                                 ];
        manager.infoViewManager.rightStrArray = @[
                                                  weakSelf.loanDetailViewModel.amount,
                                                  weakSelf.loanDetailViewModel.interest,
                                                  weakSelf.loanDetailViewModel.termsInTotal,
                                                  weakSelf.loanDetailViewModel.loanType,
                                                  weakSelf.loanDetailViewModel.repaid
                                                  ];
        manager.infoViewManager.rightLabelAlignment = NSTextAlignmentRight;
        manager.infoViewManager.leftLabelAlignment  = NSTextAlignmentLeft;
        
        
        manager.contractLabelManager.leftStrArray   =  @[@"合同"];
        manager.contractLabelManager.rightStrArray  = @[@"《借款合同》"];
        manager.contractLabelManager.leftLabelAlignment = NSTextAlignmentLeft;
        manager.contractLabelManager.rightLabelAlignment = NSTextAlignmentRight;
        
        return manager;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPView];
    self.isColourGradientNavigationBar = true;
    self.timeLabel = [[UILabel alloc]init];
    [self.view addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kScrAdaptationH(64));
        make.height.equalTo(@(kScrAdaptationH(80)));
        make.width.equalTo(@(kScrAdaptationW(150)));
    }];
    self.timeLabel.text = self.loanDetailViewModel.goBackLoanTimeCellValue;
    self.timeLabel.font = [UIFont systemFontOfSize:10];
}

- (void)setUPView {
    self.loanDetailView = [[HXBMY_Loan_DetailView alloc]initWithFrame:self.view.frame];
    
    [self.hxbBaseVCScrollView addSubview:self.loanDetailView];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    self.loanDetailViewModel = _loanDetailViewModel;
    }
@end

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
#import "HXBFinDetail_TableView.h"
#import "HXBFinContract_contraceWebViewVC_Loan.h"
@interface HXBMY_LoanList_DetailViewController ()
/**
 散标详情
 */
@property (nonatomic,strong) HXBMY_Loan_DetailView *loanDetailView;

@end

@implementation HXBMY_LoanList_DetailViewController

- (void) setLoanDetailViewModel:(HXBMYViewModel_MainLoanViewModel *)loanDetailViewModel {
    _loanDetailViewModel = loanDetailViewModel;
    kWeakSelf

    [self.loanDetailView setUPValueWithManagerBlock:^HXBMY_Loan_DetailViewManager *(HXBMY_Loan_DetailViewManager *manager) {
        _loanDetailViewModel = loanDetailViewModel;
        
        manager.termsLeftStr = weakSelf.loanDetailViewModel.goBackLoanTimeCellValue;
        manager.statusImageName = @"yihuanqishu";
        manager.strArray = @[@"借款合同"];
        
        manager.toRepayLableManager.isLeftRight         = false;
        manager.toRepayLableManager.rightLabelStr       = @"待收金额（元）";
        manager.toRepayLableManager.leftLabelStr        = weakSelf.loanDetailViewModel.toRepay;
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
    self.title = self.loanDetailViewModel.loanTitle;
    [self setUPView];
    self.isColourGradientNavigationBar = true;
}

- (void)setUPView {
    self.loanDetailView = [[HXBMY_Loan_DetailView alloc]initWithFrame:self.view.frame];
    
    [self.hxbBaseVCScrollView addSubview:self.loanDetailView];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    self.loanDetailViewModel = _loanDetailViewModel;
    [self.loanDetailView clickBottomTableViewCellBloakFunc:^(NSInteger index) {
        switch (index) {
            case 0:
                [self clickContrace];
                break;
                
            default:
                break;
        }
    }];
}
///服务协议
- (void)clickContrace {
    HXBFinContract_contraceWebViewVC_Loan *vc = [[HXBFinContract_contraceWebViewVC_Loan alloc]init];
    [self.navigationController pushViewController:vc animated:true];
    
    vc.URL = kHXB_Negotiate_ServeLoan_AccountURL(self.loanDetailViewModel.loanModel.loanId);
    vc.title = @"借款合同";
}

@end

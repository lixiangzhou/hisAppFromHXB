//
//  HXBMY_LoanList_DetailViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  账户内散标债转详情

#import "HXBMY_LoanList_DetailViewController.h"
#import "HXBMY_Loan_DetailView.h"
#import "HXBMYViewModel_MainLoanViewModel.h"
#import "HXBFinDetail_TableView.h"
#import "HXBMY_Plan_Capital_ViewController.h"
#import "HXBTransferCreditorViewController.h"
@interface HXBMY_LoanList_DetailViewController ()
/**
 散标详情
 */
@property (nonatomic,strong) HXBMY_Loan_DetailView *loanDetailView;

//底部按钮
@property (nonatomic, strong) UIButton *transferBtn;

@end

@implementation HXBMY_LoanList_DetailViewController

- (void) setLoanDetailViewModel:(HXBMYViewModel_MainLoanViewModel *)loanDetailViewModel {
    _loanDetailViewModel = loanDetailViewModel;
    self.transferBtn.userInteractionEnabled = loanDetailViewModel.loanModel.isTransferable;
    self.transferBtn.backgroundColor = loanDetailViewModel.loanModel.isTransferable ? COR29:COR12;
    kWeakSelf
    [self.loanDetailView setUPValueWithManagerBlock:^HXBMY_Loan_DetailViewManager *(HXBMY_Loan_DetailViewManager *manager) {
        _loanDetailViewModel = loanDetailViewModel;
        
        manager.termsLeftStr = weakSelf.loanDetailViewModel.goBackLoanTimeCellValue;
        manager.statusImageName = @"yihuanqishu";
//        manager.strArray = @[@"借款合同",@"转让记录"];//打开就有转让记录了
         manager.strArray = @[@"借款合同"];
        
        manager.toRepayLableManager.isLeftRight         = NO;
        manager.toRepayLableManager.rightLabelStr       = @"待收金额（元）";
        manager.toRepayLableManager.leftLabelStr        = weakSelf.loanDetailViewModel.toRepay;
        manager.toRepayLableManager.leftLabelAlignment  = NSTextAlignmentCenter;
        manager.toRepayLableManager.rightLabelAlignment = NSTextAlignmentCenter;
        
        manager.nextRepayDateLableManager.isLeftRight   = NO;
        manager.nextRepayDateLableManager.leftLabelStr  = weakSelf.loanDetailViewModel.nextRepayDate;
        manager.nextRepayDateLableManager.rightLabelStr =  @"下一还款日";
        manager.nextRepayDateLableManager.leftLabelAlignment = NSTextAlignmentCenter;
        manager.nextRepayDateLableManager.rightLabelAlignment = NSTextAlignmentCenter;
        
        manager.monthlyPrincipalManager.isLeftRight     = NO;
        manager.monthlyPrincipalManager.leftLabelStr    = weakSelf.loanDetailViewModel.monthlyRepay;
        manager.monthlyPrincipalManager.rightLabelStr   = @"月收本息（元）";
        manager.monthlyPrincipalManager.leftLabelAlignment = NSTextAlignmentCenter;
        manager.monthlyPrincipalManager.rightLabelAlignment = NSTextAlignmentCenter;
        
        manager.infoViewManager.leftStrArray = @[
                                                 @"出借金额",
                                                 @"年利率",
                                                 @"期限",
                                                 @"还款方式",
                                                 @"已收本息"
                                                 ];
        manager.infoViewManager.rightStrArray = @[
                                                  weakSelf.loanDetailViewModel.amount,
                                                  weakSelf.loanDetailViewModel.interest,
                                                  [NSString stringWithFormat:@"%@个月", weakSelf.loanDetailViewModel.termsInTotal],
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
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = self.loanDetailViewModel.loanTitle;
    [self setUPView];
    self.isColourGradientNavigationBar = YES;
}

- (void)setUPView {
    self.loanDetailView = [[HXBMY_Loan_DetailView alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, self.view.height - HXBStatusBarAndNavigationBarHeight)];
    [self.view addSubview:self.loanDetailView];
    [self.view addSubview:self.transferBtn];
    [self.transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.offset(kScrAdaptationH(50));
        make.bottom.equalTo(self.view).offset(-HXBBottomAdditionHeight);
    }];
    
    self.loanDetailViewModel = _loanDetailViewModel;
    [self.loanDetailView clickBottomTableViewCellBloakFunc:^(NSInteger index) {
        switch (index) {
            case 0:
            {
                [self clickContrace];
               
            }
                break;
                case 1:
            {
                HXBMY_Plan_Capital_ViewController *capitalVC = [[HXBMY_Plan_Capital_ViewController alloc]init];
                capitalVC.planID = self.loanDetailViewModel.loanModel.loanId;
                capitalVC.type = HXBTransferRecord;
                [self.navigationController pushViewController:capitalVC animated:YES];
            }
                break;
            default:
                break;
        }
    }];
}

- (void)transferBtnClick
{
    HXBTransferCreditorViewController *transferCreditorVC = [[HXBTransferCreditorViewController alloc] init];
    transferCreditorVC.creditorID = self.loanDetailViewModel.loanModel.loanId;
    [self.navigationController pushViewController:transferCreditorVC animated:YES];
}

///服务协议
- (void)clickContrace {
    [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_ServeLoan_AccountURL(self.loanDetailViewModel.loanModel.loanId)] fromController:self];
}

/**
 底部按钮
 */
- (UIButton *)transferBtn
{
    if (!_transferBtn) {
        _transferBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_transferBtn setTitle:@"转让" forState:(UIControlStateNormal)];
        _transferBtn.backgroundColor = COR29;
        [_transferBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_transferBtn addTarget:self action:@selector(transferBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _transferBtn;
}

@end

//
//  HXBFin_Detail_DetailVC_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Detail_DetailVC_Loan.h"
#import "HXBLoanInformation.h"
#import "HXBLoanInstructionView.h"
#import "HXBHXBBorrowUserinforView.h"
#import "HXBFinDetailViewModel_LoanDetail.h"


#import "HXBFin_LoanInfoView.h"
@interface HXBFin_Detail_DetailVC_Loan ()
@property (nonatomic, strong) HXBFin_LoanInfoView *loanInfo;
//@property (nonatomic, strong) UIScrollView *scrollView;

//@property (nonatomic, strong) HXBLoanInformation *loanInformation;
//
//@property (nonatomic, strong) HXBLoanInstructionView *loanInstructionView;
//
//@property (nonatomic, strong) HXBHXBBorrowUserinforView *borrowUserinforView;
@end

@implementation HXBFin_Detail_DetailVC_Loan
/////借款说明
//- (HXBLoanInstructionView *)loanInstructionView
//{
//    if (!_loanInstructionView) {
//        _loanInstructionView = [[HXBLoanInstructionView alloc] initWithFrame:CGRectZero];
//    }
//    return _loanInstructionView;
//}
//
//- (HXBLoanInformation *)loanInformation
//{
//    if (!_loanInformation) {
//        _loanInformation = [[HXBLoanInformation alloc] initWithFrame:CGRectZero];
//    }
//    return _loanInformation;
//}
/////用户信息
//- (HXBHXBBorrowUserinforView *)borrowUserinforView
//{
//    if (!_borrowUserinforView) {
//        _borrowUserinforView = [[HXBHXBBorrowUserinforView alloc] initWithFrame:CGRectZero];
//    }
//    return _borrowUserinforView;
//}

//-(void)loadView {
//    [super loadView];
//    self.isTransparentNavigationBar = true;
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
//    self.view = self.scrollView;
//}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.borrowUserinforView.y = CGRectGetMaxY(self.loanInstructionView.frame) + 20;
//}
//
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    self.scrollView.contentSize = CGSizeMake(0, self.borrowUserinforView.bottom);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"借款信息";
//    self.scrollView.backgroundColor = COR11;
//    [self.scrollView addSubview:self.loanInformation];
//    [self.scrollView addSubview:self.loanInstructionView];
//    [self.scrollView addSubview:self.borrowUserinforView];
//    
//    [self.loanInstructionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.scrollView).offset(kScrAdaptationH(10));
//        make.left.equalTo(self.scrollView);
//        make.width.equalTo(self.scrollView);
//    }];
//    [self.borrowUserinforView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.loanInstructionView.mas_bottom).offset(kScrAdaptationH(10));
//        make.left.equalTo(self.scrollView);
//        make.width.equalTo(self.scrollView);
//        make.height.equalTo(@(kScrAdaptationH(744)));
//    }];
//    self.loanInformation.loanDetailViewModel = self.loanDetailViewModel;
//    self.loanInstructionView.loanDetailViewModel = self.loanDetailViewModel;
//    self.borrowUserinforView.loanDetailViewModel = self.loanDetailViewModel;
    
    self.loanInfo = [[HXBFin_LoanInfoView alloc]initWithFrame:CGRectZero];
    self.loanInfo.loan_finDatailModel = self.loanDetailViewModel;
    [self.hxbBaseVCScrollView addSubview:self.loanInfo];
    [self.loanInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}




@end

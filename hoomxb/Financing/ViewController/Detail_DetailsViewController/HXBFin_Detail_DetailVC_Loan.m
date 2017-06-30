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
@interface HXBFin_Detail_DetailVC_Loan ()
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HXBLoanInformation *loanInformation;

@property (nonatomic, strong) HXBLoanInstructionView *loanInstructionView;

@property (nonatomic, strong) HXBHXBBorrowUserinforView *borrowUserinforView;
@end

@implementation HXBFin_Detail_DetailVC_Loan

- (HXBLoanInstructionView *)loanInstructionView
{
    if (!_loanInstructionView) {
        _loanInstructionView = [[HXBLoanInstructionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loanInformation.frame) + 20, kScreenWidth, 0)];
    }
    return _loanInstructionView;
}

- (HXBLoanInformation *)loanInformation
{
    if (!_loanInformation) {
        _loanInformation = [[HXBLoanInformation alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 166.5)];
    }
    return _loanInformation;
}

- (HXBHXBBorrowUserinforView *)borrowUserinforView
{
    if (!_borrowUserinforView) {
        _borrowUserinforView = [[HXBHXBBorrowUserinforView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    }
    return _borrowUserinforView;
}

-(void)loadView {
    [super loadView];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view = self.scrollView;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.borrowUserinforView.y = self.loanInstructionView.bottom + 20;
    self.scrollView.contentSize = CGSizeMake(0, self.borrowUserinforView.bottom);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"借款信息";
    self.scrollView.backgroundColor = COR11;
    [self.scrollView addSubview:self.loanInformation];
    [self.scrollView addSubview:self.loanInstructionView];
    [self.scrollView addSubview:self.borrowUserinforView];
    
    self.loanInformation.loanDetailViewModel = self.loanDetailViewModel;
    self.loanInstructionView.loanDetailViewModel = self.loanDetailViewModel;
    self.borrowUserinforView.loanDetailViewModel = self.loanDetailViewModel;
    
//    kWeakSelf
//    [self.scrollView hxb_HeaderWithHeaderRefreshCallBack:^{
//        [weakSelf.scrollView endRefresh];
//    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
//        
//    }];
}




@end

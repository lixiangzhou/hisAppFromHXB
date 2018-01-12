//
//  HXBFinAddRecordVC_LoanTruansfer.m
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddRecordVC_LoanTruansfer.h"
#import "HXBFinanctingRequest.h"
#import "HXBFinAddRecortdTableView_Plan.h"
#import "HXBFinModel_AddRecortdModel_LoanTruansfer.h"
#import "FinModel_AddRecortdModel_Loan.h"
#import "HXBFinAddRecordViewModel.h"

@interface HXBFinAddRecordVC_LoanTruansfer ()
@property (nonatomic,strong) HXBFinAddRecortdTableView_Plan *addRecortdTableView;
@property (nonatomic,strong) HXBFinAddRecordViewModel *loanTruansferViewModel;
@end

@implementation HXBFinAddRecordVC_LoanTruansfer

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    self.loanTruansferViewModel = [[HXBFinAddRecordViewModel alloc]initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    [self setUPViews];
    [self downLoadDataWihtIsUPLoad:YES];
    self.title = @"转让记录";
}

- (void)downLoadDataWihtIsUPLoad:(BOOL)isUPLoad{
    kWeakSelf
    [self.loanTruansferViewModel requestLoanTruaLnsferAddRecortdWithId:self.loanTruansferID loanTruansferAddRecortdWithISUPLoad:isUPLoad andOrder:nil resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.addRecortdTableView.loanTruansferModelArray = weakSelf.loanTruansferViewModel.loanTruansferRecortdModelArray;
        }
    } andFailureBlock:^(NSError *error) {
    }];
}

- (void)setUPViews {
    self.isColourGradientNavigationBar = YES;
    self.addRecortdTableView = [[HXBFinAddRecortdTableView_Plan alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, self.view.width, self.view.height - HXBStatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.addRecortdTableView];
}

@end

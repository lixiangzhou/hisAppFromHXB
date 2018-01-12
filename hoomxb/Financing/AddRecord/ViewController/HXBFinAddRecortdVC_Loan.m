//
//  HXBFinAddRecortdVC_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddRecortdVC_Loan.h"
#import "HXBFinanctingRequest.h"
#import "HXBFinAddRecortdTableView_Plan.h"
#import "HXBFinAddRecordViewModel.h"

@interface HXBFinAddRecortdVC_Loan ()
@property (nonatomic,strong) HXBFinAddRecortdTableView_Plan *addRecortdTableView;
@property (nonatomic,strong) HXBFinAddRecordViewModel *loadRecordViewModel;
@end

@implementation HXBFinAddRecortdVC_Loan

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    self.loadRecordViewModel = [[HXBFinAddRecordViewModel alloc]initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    [self setUPViews];
    [self downLoadData];
    self.title = @"投标记录";
}

- (void)downLoadData {
    kWeakSelf
    [self.loadRecordViewModel requestLoanAddRecortdWithId:self.loanID loadAddRecortdWithISUPLoad:true andOrder:nil resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.addRecortdTableView.loanModel = weakSelf.loadRecordViewModel.addRecortdModel_LoanModel;
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

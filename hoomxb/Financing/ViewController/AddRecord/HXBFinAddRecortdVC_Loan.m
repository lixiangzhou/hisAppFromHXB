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
@interface HXBFinAddRecortdVC_Loan ()
@property (nonatomic,strong) HXBFinAddRecortdTableView_Plan *addRecortdTableView;
@end

@implementation HXBFinAddRecortdVC_Loan

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPViews];
    [self downLoadData];
    self.title = @"投标记录";
}

- (void)downLoadData {
      [[HXBFinanctingRequest sharedFinanctingRequest] loanAddRecortdWithISUPLoad:YES andFinanceLoanId:self.loanID andOrder:nil andSuccessBlock:^(FinModel_AddRecortdModel_Loan *model) {
          self.addRecortdTableView.loanModel = model;
      } andFailureBlock:^(NSError *error) {
          
      }];
}

- (void)setUPViews {
    self.isColourGradientNavigationBar = YES;
    self.addRecortdTableView = [[HXBFinAddRecortdTableView_Plan alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, self.view.width, self.view.height - HXBStatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.addRecortdTableView];
}


- (void) footerRefresh {
    [self.addRecortdTableView hxb_footerWithRefreshBlock:^{
        
    }];
}

- (void)headerRefresh {
    [self.addRecortdTableView hxb_headerWithRefreshBlock:^{
        [self downLoadData];
    }];
}

@end

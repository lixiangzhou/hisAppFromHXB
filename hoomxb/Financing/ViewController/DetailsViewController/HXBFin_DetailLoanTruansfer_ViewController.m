//
//  HXBFin_DetailLoanTruansfer_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailLoanTruansfer_ViewController.h"
///详情的VIEW
#import "HXBFin_LoanTruansferDetailView.h"
@interface HXBFin_DetailLoanTruansfer_ViewController ()
@property (nonatomic,strong) HXBFin_LoanTruansferDetailView *detailView;
@end

@implementation HXBFin_DetailLoanTruansfer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
}

#pragma mark - setUP
- (void) setUP {
    self.detailView = [[HXBFin_LoanTruansferDetailView alloc]init];
    self.detailView.frame = self.view.bounds;
    [self.view addSubview:self.detailView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

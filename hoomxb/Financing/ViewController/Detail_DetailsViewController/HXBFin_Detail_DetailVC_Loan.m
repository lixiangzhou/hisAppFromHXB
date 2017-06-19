//
//  HXBFin_Detail_DetailVC_Loan.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Detail_DetailVC_Loan.h"

@interface HXBFin_Detail_DetailVC_Loan ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation HXBFin_Detail_DetailVC_Loan

-(void)loadView {
    [super loadView];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.view = self.scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    [self.scrollView hxb_HeaderWithHeaderRefreshCallBack:^{
        [weakSelf.scrollView endRefresh];
    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

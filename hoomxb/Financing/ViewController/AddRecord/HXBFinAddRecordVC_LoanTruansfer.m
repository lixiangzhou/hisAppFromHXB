//
//  HXBFinAddRecordVC_LoanTruansfer.m
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinAddRecordVC_LoanTruansfer.h"
#import "HXBFinanctingRequest.h"
#import "HXBFinAddRecortdTableView_Plan.h"
#import "HXBFinModel_AddRecortdModel_LoanTruansfer.h"
#import "FinModel_AddRecortdModel_Loan.h"
@interface HXBFinAddRecordVC_LoanTruansfer ()
@property (nonatomic,strong) HXBFinAddRecortdTableView_Plan *addRecortdTableView;
@end

@implementation HXBFinAddRecordVC_LoanTruansfer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPViews];
    [self downLoadDataWihtIsUPLoad:true];
    self.title = @"转让记录";
}

- (void)downLoadDataWihtIsUPLoad:(BOOL)isUPLoad{
    [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansferAddRecortdWithISUPLoad:isUPLoad andFinanceLoanId:self.loanTruansferID andOrder:nil andSuccessBlock:^(NSArray<HXBFinModel_AddRecortdModel_LoanTruansfer *> *loanTruansferRecortdModelArray) {
        self.addRecortdTableView.loanTruansferModelArray = loanTruansferRecortdModelArray;
    } andFailureBlock:^(NSError *error, NYBaseRequest *request) {
        NSString *massage = request.responseObject[kResponseMessage] ? request.responseObject[kResponseMessage] : @"请求失败";
        [HxbHUDProgress showMessageCenter:massage inView:self.view];
    }];
}

- (void)setUPViews {
    self.isColourGradientNavigationBar = true;
    self.addRecortdTableView = [[HXBFinAddRecortdTableView_Plan alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.addRecortdTableView];
}


- (void) footerRefresh {
    [self.addRecortdTableView hxb_GifFooterWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        [self downLoadDataWihtIsUPLoad:false];
    } andSetUpGifFooterBlock:^(MJRefreshBackGifFooter *footer) {
        
    }];
}

- (void)headerRefresh {
    [self.addRecortdTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        [self downLoadDataWihtIsUPLoad:true];
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
    }];
    
}





//- (HXBFinAddRecortdTableView_Plan *)addRecortdTableView {
//    if (!_addRecortdTableView) {
//        _addRecortdTableView = [[HXBFinAddRecortdTableView_Plan alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    }
//    return _addRecortdTableView;
//}
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

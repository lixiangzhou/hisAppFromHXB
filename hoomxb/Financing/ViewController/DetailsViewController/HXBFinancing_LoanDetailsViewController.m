//
//  HXBFinancing_LoanDetailsViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_LoanDetailsViewController.h"
#import "HXBFinDetail_TableView.h"

#import "HXBFin_DetailsView_LoanDetailsView.h"//贷款详情的View
#import "HXBFinanctingRequest.h"//网络请求类
#import "HXBFinDetailViewModel_LoanDetail.h"//贷款详情的ViewModel
#import "HXBFinHomePageViewModel_LoanList.h"//贷款详情的Model
#import "HXBFinHomePageModel_LoanList.h"//贷款列表的Model

#import "HXBFin_Detail_DetailVC_Loan.h"//贷款信息的控制器
#import "HXBFinAddRecortdVC_Loan.h"//贷款记录的控制器
#import "HXBFinContract_contraceWebViewVC_Loan.h"//贷款合同的控制器

#import "HXBFinBuy_Loan_ViewController.h"//加入

#import "HXBFin_Loan_BuyViewController.h"//加入界面
//#import "HXBFinDetailView"

@interface HXBFinancing_LoanDetailsViewController ()

@property(nonatomic,strong) HXBFin_DetailsView_LoanDetailsView *loanDetailsView;

@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*tableViewModelArray;
///tableView的tatile
@property (nonatomic,strong) NSArray <NSString *>* tableViewTitleArray;
///详情底部的tableView的图片数组
@property (nonatomic,strong) NSArray <NSString *>* tableViewImageArray;
@end

@implementation HXBFinancing_LoanDetailsViewController


- (void)setLoanListViewMode:(HXBFinHomePageViewModel_LoanList *)loanListViewMode {
    _loanListViewMode = loanListViewMode;
    //标题
    self.title = self.loanListViewMode.loanListModel.title;
    self.loanID = self.loanListViewMode.loanListModel.loanId;
}
///给self. tableViewarray赋值
- (void) setupTableViewArray {
    self.tableViewImageArray = @[
                                 @"1",
                                 @"1",
                                 @"1",
                                 ];
    self.tableViewTitleArray = @[
                                 @"借款信息",
                                 @"投标记录",
                                 @"借款合同"
                                 ];
}
- (NSArray<HXBFinDetail_TableViewCellModel *> *)tableViewModelArray {
    if (!_tableViewModelArray) {
        [self setupTableViewArray];
        NSMutableArray *tableViewModelArrayM = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.tableViewImageArray.count; i++) {
            NSString *imageName = self.tableViewImageArray[i];
            NSString *title = self.tableViewTitleArray[i];
            HXBFinDetail_TableViewCellModel *model = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:imageName andOptionIitle:title];
            [tableViewModelArrayM addObject:model];
        }
        _tableViewModelArray = tableViewModelArrayM.copy;
    }
    return _tableViewModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    [self setup];
    [self downLoadData];
    [self registerEvent];
}
- (void)clickLeftBarButtonItem {
    [self.navigationController popViewControllerAnimated:true];
}
//MARK: ------ setup -------
- (void)setup {
    kWeakSelf
    [self.hxbBaseVCScrollView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
        [weakSelf downLoadData];
    } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
        
    }];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.hxbBaseVCScrollView.backgroundColor = [UIColor whiteColor];
    self.loanDetailsView = [[HXBFin_DetailsView_LoanDetailsView alloc]initWithFrame:self.view.frame];
    [self.hxbBaseVCScrollView addSubview:self.loanDetailsView];
    
    
    //是否为计划界面
    self.loanDetailsView.isPlan = false;
    self.loanDetailsView.isFlowChart = true;
    self.loanDetailsView.loanListViewModel = self.loanListViewMode;
}


- (void) registerEvent {
    [self registerClickCell];
    [self registerClickAddButton];
}

- (void)registerClickCell {
    __weak typeof (self)weakSelf = self;
    [self.loanDetailsView clickBottomTableViewCellBloakFunc:^(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model) {
        //跳转相应的页面
        NSLog(@"%@",model.optionTitle);
        ///点击了借款信息
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[0]]) {
            HXBFin_Detail_DetailVC_Loan *detail_DetailLoanVC = [[HXBFin_Detail_DetailVC_Loan alloc]init];
            //            detail_DetailLoanVC. = self.planDetailViewModel;
            [weakSelf.navigationController pushViewController:detail_DetailLoanVC animated:true];
        }
        ///  借款记录
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[1]]) {
            HXBFinAddRecortdVC_Loan *loanAddRecordVC = [[HXBFinAddRecortdVC_Loan alloc]init];
            //            loanAddRecordVC.planDetailModel = self.planDetailViewModel.planDetailModel;
            loanAddRecordVC.loanID = weakSelf.loanID;
            [weakSelf.navigationController pushViewController:loanAddRecordVC animated:true];
        }
        ///合同
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[2]]) {
            //跳转一个webView
            HXBFinContract_contraceWebViewVC_Loan * contractWebViewVC = [[HXBFinContract_contraceWebViewVC_Loan alloc]init];
            //            contractWebViewVC.URL = self.planDetailViewModel.planDetailModel.principalBalanceContractNameUrl;
            [weakSelf.navigationController pushViewController:contractWebViewVC animated:true];
        }
        
    }];
}

///点击了立即加入
- (void)registerClickAddButton {
    kWeakSelf
    [self.loanDetailsView clickAddButtonFunc:^{
        //如果不是登录 那么就登录
        if (![KeyChainManage sharedInstance].isLogin) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        }
        
        //判断是否风险测评
        
        //跳转加入界面
        HXBFin_Loan_BuyViewController *loanJoinVC = [[HXBFin_Loan_BuyViewController alloc]init];
        loanJoinVC.loanViewModel = weakSelf.loanDetailsView.loanDetailViewModel;
        [weakSelf.navigationController pushViewController:loanJoinVC animated:true];
    }];
}


//MARK: 网络数据请求
- (void)downLoadData {
    __weak typeof(self)weakSelf = self;
    [[HXBFinanctingRequest sharedFinanctingRequest] loanDetaileWithLoanID:self.loanID andSuccessBlock:^(HXBFinDetailViewModel_LoanDetail *viewModel) {
        weakSelf.loanDetailsView.loanDetailViewModel = viewModel;
        weakSelf.loanDetailsView.modelArray = weakSelf.tableViewModelArray;
        [weakSelf.hxbBaseVCScrollView endRefresh];
    } andFailureBlock:^(NSError *error) {
        [weakSelf.hxbBaseVCScrollView endRefresh];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

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
#import "HXBFinDetailViewModel_LoanDetail.h"
#import "HXBFin_Loan_BuyViewController.h"//加入界面
#import "HXBFinAddTruastWebViewVC.h"

#pragma mark --- (肖扬 散标计划详情)

@interface HXBFinancing_LoanDetailsViewController ()
//假的navigationBar
@property (nonatomic,strong) UIImageView *topImageView;
@property(nonatomic,strong) HXBFin_DetailsView_LoanDetailsView *loanDetailsView;
@property (nonatomic,strong) HXBFinDetailViewModel_LoanDetail *loanDetailViewModel;
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*tableViewModelArray;
///tableView的tatile
@property (nonatomic,strong) NSArray <NSString *>* tableViewTitleArray;
///详情底部的tableView的图片数组
@property (nonatomic,strong) NSArray <NSString *>* tableViewImageArray;
@property (nonatomic,copy) NSString *availablePoint;//可用余额；
@property (nonatomic,assign) BOOL isIdPassed;
@end

@implementation HXBFinancing_LoanDetailsViewController

- (void) setLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)loanDetailViewModel {
    _loanDetailViewModel = loanDetailViewModel;
    kWeakSelf
    [self.loanDetailsView setUPViewModelVM:^HXBFin_DetailsView_LoanDetailsView_ViewModelVM *(HXBFin_DetailsView_LoanDetailsView_ViewModelVM *viewModelVM) {
        viewModelVM.totalInterestStr           = [NSString stringWithFormat:@"%.1f", [weakSelf.loanDetailViewModel.totalInterestPer100 floatValue]];///年利率
        viewModelVM.totalInterestStr_const     = @"年利率";
        viewModelVM.remainAmount               = weakSelf.loanDetailViewModel.surplusAmount;
        viewModelVM.remainAmount_const         = weakSelf.loanDetailViewModel.surplusAmount_ConstStr;
        viewModelVM.startInvestmentStr         = weakSelf.loanDetailViewModel.months;
        viewModelVM.startInvestmentStr_const   = @"标的期限";
        viewModelVM.promptStr                  = @"* 预期收益不代表实际收益，投资需谨慎";
        viewModelVM.addButtonStr               = weakSelf.loanDetailViewModel.addButtonStr;
        viewModelVM.remainAmount_const         = weakSelf.loanDetailViewModel.surplusAmount_ConstStr;
        viewModelVM.remainAmount               = weakSelf.loanDetailViewModel.surplusAmount;
        viewModelVM.isUserInteractionEnabled   = weakSelf.loanDetailViewModel.isAddButtonEditing;
        viewModelVM.remainTime                 = weakSelf.loanDetailViewModel.loanDetailModel.remainTime;
        viewModelVM.addButtonTitleColor        = weakSelf.loanDetailViewModel.addButtonTitleColor;
        viewModelVM.addButtonBackgroundColor   = weakSelf.loanDetailViewModel.addButtonBackgroundColor;
        viewModelVM.title                      = @"散标投资";
        return viewModelVM;
    }];
}
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
    //判断是否风险测评
    [[KeyChainManage sharedInstance] downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        _availablePoint = viewModel.availablePoint;
        _isIdPassed = viewModel.userInfoModel.userInfo.isIdPassed.integerValue;
    } andFailure:^(NSError *error) {
        
    }];
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
    
    [self setUPTopImageView];
    
    self.isTransparentNavigationBar = true;
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    self.hxbBaseVCScrollView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    self.loanDetailsView = [[HXBFin_DetailsView_LoanDetailsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [self.hxbBaseVCScrollView addSubview:self.loanDetailsView];
    
    [self.view addSubview:self.loanDetailsView.addButton];
    self.loanDetailsView.addButton.frame = CGRectMake(0, kScreenHeight - kScrAdaptationH(60), kScreenWidth, kScrAdaptationH(60));
}
- (void)setUPTopImageView {
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.topImageView.image = [UIImage imageNamed:@"NavigationBar"];
    [self.view addSubview:self.topImageView];
}

- (void) registerEvent {
    [self registerClickCell];
    [self registerClickAddButton];
    [self registerAddTrust];
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
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager = weakSelf.loanDetailViewModel.fin_LoanInfoView_Manager;
            [weakSelf.navigationController pushViewController:detail_DetailLoanVC animated:true];
        }
        ///  借款记录
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[1]]) {
            HXBFinAddRecortdVC_Loan *loanAddRecordVC = [[HXBFinAddRecortdVC_Loan alloc]init];
            //loanAddRecordVC.planDetailModel = self.planDetailViewModel.planDetailModel;
            loanAddRecordVC.loanID = weakSelf.loanID;
            [weakSelf.navigationController pushViewController:loanAddRecordVC animated:true];
        }
        ///合同
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[2]]) {
            //跳转一个webView
            HXBFinContract_contraceWebViewVC_Loan * contractWebViewVC = [[HXBFinContract_contraceWebViewVC_Loan alloc]init];
            contractWebViewVC.URL = weakSelf.loanDetailViewModel.agreementURL;
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
//            [HXBAlertManager alertManager_loginAgainAlertWithView:self.view];
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            return;
        }
        [HXBAlertManager checkOutRiskAssessmentWithSuperVC:weakSelf andWithPushBlock:^{
            [weakSelf enterLoanBuyViewController];
        }];
    }];
}

- (void)registerAddTrust {
    kWeakSelf
    [self.loanDetailsView clickAddTrustWithBlock:^{
        HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
        vc.URL = kHXB_Negotiate_AddTrustURL;
        [weakSelf.navigationController pushViewController:vc animated:true];
    }];
}
- (void)enterLoanBuyViewController
{
    //跳转加入界面
    HXBFin_Loan_BuyViewController *loanJoinVC = [[HXBFin_Loan_BuyViewController alloc]init];
    loanJoinVC.title = @"散标投资";
    loanJoinVC.loanViewModel = self.loanDetailViewModel;
    loanJoinVC.availablePoint = _availablePoint;
    [self.navigationController pushViewController:loanJoinVC animated:true];
}

//MARK: 网络数据请求
- (void)downLoadData {
    __weak typeof(self)weakSelf = self;
    [[HXBFinanctingRequest sharedFinanctingRequest] loanDetaileWithLoanID:self.loanID andSuccessBlock:^(HXBFinDetailViewModel_LoanDetail *viewModel) {
        weakSelf.loanDetailViewModel = viewModel;
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

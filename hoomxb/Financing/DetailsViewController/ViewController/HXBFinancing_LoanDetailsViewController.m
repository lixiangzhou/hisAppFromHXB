//
//  HXBFinancing_LoanDetailsViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancing_LoanDetailsViewController.h"
#import "HXBFin_DetailsView_LoanDetailsView.h"//贷款详情的View
#import "HXBFinHomePageViewModel_LoanList.h"//贷款详情的Model
#import "HXBFinHomePageModel_LoanList.h"//贷款列表的Model
#import "HXBFin_Detail_DetailVC_Loan.h"//贷款信息的控制器
#import "HXBFinAddRecortdVC_Loan.h"//贷款记录的控制器
#import "HXBFinancingLoanDetailViewModel.h"

@interface HXBFinancing_LoanDetailsViewController ()
@property(nonatomic,strong) HXBFin_DetailsView_LoanDetailsView *loanDetailsView;

@property (nonatomic,copy) NSString *availablePoint;//可用余额；
@property (nonatomic,assign) BOOL isIdPassed;


@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic, strong) HXBFinancingLoanDetailViewModel *viewModel;

@property (nonatomic, strong) HXBAlertManager* alertManager;
@end

@implementation HXBFinancing_LoanDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf
    self.viewModel = [[HXBFinancingLoanDetailViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    self.isRedColorWithNavigationBar = YES;
    //判断是否风险评测
    [self.viewModel downLoadUserInfo:YES resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.availablePoint = weakSelf.viewModel.userInfoModel.availablePoint;
            weakSelf.isIdPassed = weakSelf.viewModel.userInfoModel.userInfoModel.userInfo.isIdPassed.integerValue;
        }
    }];
    [self setup];
    [self downLoadData];
    [self registerEvent];
}

- (HXBAlertManager *)alertManager {
    if(!_alertManager) {
        kWeakSelf
        _alertManager = [[HXBAlertManager alloc] initWithBlock:^UIView *{
            return weakSelf.view;
        }];
    }
    
    return _alertManager;
}

- (void)clickLeftBarButtonItem {
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: ------ setup -------
- (void)setup {
    kWeakSelf
    [self.hxbBaseVCScrollView hxb_headerWithRefreshBlock:^{
        [weakSelf downLoadData];
    }];
    
    self.isTransparentNavigationBar = YES;
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.hxbBaseVCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight));//.offset(kScrAdaptationH(30))
    }];

    self.loanDetailsView = [[HXBFin_DetailsView_LoanDetailsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.hxbBaseVCScrollView addSubview:self.loanDetailsView];
    [self.view addSubview:self.loanDetailsView.addButton];

    [self.loanDetailsView.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.hxbBaseVCScrollView.mas_bottom);
        make.height.equalTo(@(kScrAdaptationH(50)));
        make.bottom.equalTo(@(-HXBBottomAdditionHeight));
    }];
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
        if ([model.optionTitle isEqualToString:weakSelf.viewModel.tableViewTitleArray[0]]) {
            HXBFin_Detail_DetailVC_Loan *detail_DetailLoanVC = [[HXBFin_Detail_DetailVC_Loan alloc]init];
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager = weakSelf.viewModel.loanDetailModel.fin_LoanInfoView_Manager;
            
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.overDueStatus = self.viewModel.loanDetailModel.loanDetailModel.userVo.overDueStatus;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.otherPlatStatus = self.viewModel.loanDetailModel.loanDetailModel.userVo.otherPlatStatus;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.protectSolution = self.viewModel.loanDetailModel.loanDetailModel.userVo.protectSolution;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.userFinanceStatus = self.viewModel.loanDetailModel.loanDetailModel.userVo.userFinanceStatus;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.repaymentCapacity = self.viewModel.loanDetailModel.loanDetailModel.userVo.repaymentCapacity;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.punishedStatus = self.viewModel.loanDetailModel.loanDetailModel.userVo.punishedStatus;
            
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.creditInfoItems = weakSelf.viewModel.loanDetailModel.loanDetailModel.loanVo.creditInfoItems;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.riskLevel = weakSelf.viewModel.loanDetailModel.loanDetailModel.loanVo.riskLevel;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.riskLevelDesc = weakSelf.viewModel.loanDetailModel.loanDetailModel.loanVo.riskLevelDesc;
            detail_DetailLoanVC.loanDetailViewModel = weakSelf.viewModel.loanDetailModel;
            [weakSelf.navigationController pushViewController:detail_DetailLoanVC animated:YES];
        }
        ///  借款记录
        if ([model.optionTitle isEqualToString:weakSelf.viewModel.tableViewTitleArray[1]]) {
            HXBFinAddRecortdVC_Loan *loanAddRecordVC = [[HXBFinAddRecortdVC_Loan alloc]init];
            loanAddRecordVC.loanID = weakSelf.loanID;
            [weakSelf.navigationController pushViewController:loanAddRecordVC animated:YES];
        }
        ///合同
        if ([model.optionTitle isEqualToString:weakSelf.viewModel.tableViewTitleArray[2]]) {
            //跳转一个webView
            [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_ServeLoanURL] fromController:weakSelf];
        }
    }];
}

///点击了立即加入
- (void)registerClickAddButton {
    kWeakSelf
    [self.loanDetailsView clickAddButtonFunc:^{
        //如果不是登录 那么就登录
        if (!KeyChain.isLogin) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            return;
        }
        
        [weakSelf.alertManager checkOutRiskAssessmentWithSuperVC:weakSelf andWithPushBlock:^(NSString *hasBindCard, HXBRequestUserInfoViewModel *model) {
            [weakSelf enterLoanBuyViewControllerWithHasBindCard:hasBindCard userInfoViewModel:model];
        }];
    }];
}

- (void)registerAddTrust {
    kWeakSelf
    [self.loanDetailsView clickAddTrustWithBlock:^{
        [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_AddTrustURL] fromController:weakSelf];
    }];
}

- (void)enterLoanBuyViewControllerWithHasBindCard:(NSString *)hasBindCard userInfoViewModel:(HXBRequestUserInfoViewModel*)model{
    [self.navigationController pushViewController:[self.viewModel getALoanBuyController:hasBindCard userInfoViewModel:model] animated:YES];
}

//MARK: 网络数据请求
- (void)downLoadData {
    __weak typeof(self)weakSelf = self;
    [self.viewModel requestLoanDetailWithLoanId:self.loanID resultBlock:^(BOOL isSuccess) {
        [weakSelf.hxbBaseVCScrollView endRefresh];
        if (isSuccess) {
            [weakSelf setLoanDetailViewModel:weakSelf.viewModel.loanDetailModel];
            weakSelf.title = weakSelf.viewModel.loanDetailModel.loanDetailModel.loanVo.title;
            weakSelf.loanDetailsView.modelArray = weakSelf.viewModel.tableViewModelArray;
        }
    }];
}

- (void) setLoanDetailViewModel:(HXBFinDetailViewModel_LoanDetail *)loanDetailViewModel {
    kWeakSelf
    [self.loanDetailsView setUPViewModelVM:^HXBFin_DetailsView_LoanDetailsView_ViewModelVM *(HXBFin_DetailsView_LoanDetailsView_ViewModelVM *viewModelVM) {
        [weakSelf.viewModel setLoanDetailViewModel:viewModelVM];
        return viewModelVM;
    }];
}

- (void)setLoanListViewMode:(HXBFinHomePageViewModel_LoanList *)loanListViewMode {
    _loanListViewMode = loanListViewMode;
    //标题
    self.title = self.loanListViewMode.loanListModel.title;
    self.loanID = self.loanListViewMode.loanListModel.loanId;
}

- (UITableView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
        
        _hxbBaseVCScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
        _hxbBaseVCScrollView.tableFooterView = [[UIView alloc]init];
        _hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_hxbBaseVCScrollView];
    }
    return _hxbBaseVCScrollView;
}
@end

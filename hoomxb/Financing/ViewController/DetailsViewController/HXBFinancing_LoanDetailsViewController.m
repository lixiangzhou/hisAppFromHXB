//
//  HXBFinancing_LoanDetailsViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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

//#import "HXBFin_Loan_BuyViewController.h"//加入界面

#pragma mark --- (肖扬 散标计划详情)
#import "HXBFin_creditorChange_buy_ViewController.h"
#import "HXBFin_Loan_Buy_ViewController.h"

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


@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);

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
        viewModelVM.promptStr                  = @"- 预期收益不代表实际收益，投资需谨慎 -";
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
    
    self.isColourGradientNavigationBar = YES;
    //判断是否风险评测
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        _availablePoint = viewModel.availablePoint;
        _isIdPassed = viewModel.userInfoModel.userInfo.isIdPassed.integerValue;
    } andFailure:^(NSError *error) {
        
    }];
    [self setup];
    [self downLoadData];
    [self registerEvent];
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
    
    [self setUPTopImageView];
    
    self.isTransparentNavigationBar = YES;
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.hxbBaseVCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.topImageView.mas_bottom);//.offset(kScrAdaptationH(30))
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
- (void)setUPTopImageView {
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, HXBStatusBarAndNavigationBarHeight)];
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
            [weakSelf.navigationController pushViewController:detail_DetailLoanVC animated:YES];
        }
        ///  借款记录
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[1]]) {
            HXBFinAddRecortdVC_Loan *loanAddRecordVC = [[HXBFinAddRecortdVC_Loan alloc]init];
            //loanAddRecordVC.planDetailModel = self.planDetailViewModel.planDetailModel;
            loanAddRecordVC.loanID = weakSelf.loanID;
            [weakSelf.navigationController pushViewController:loanAddRecordVC animated:YES];
        }
        ///合同
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[2]]) {
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
//            [HXBAlertManager alertManager_loginAgainAlertWithView:self.view];
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            return;
        }
        [HXBAlertManager checkOutRiskAssessmentWithSuperVC:weakSelf andWithPushBlock:^(NSString *hasBindCard, HXBRequestUserInfoViewModel *model) {
            [weakSelf enterLoanBuyViewControllerWithHasBindCard:hasBindCard userInfo:model];
        }];
    }];
}

- (void)registerAddTrust {
    kWeakSelf
    [self.loanDetailsView clickAddTrustWithBlock:^{
        [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_AddTrustURL] fromController:weakSelf];
    }];
}
- (void)enterLoanBuyViewControllerWithHasBindCard:(NSString *)hasBindCard userInfo:(HXBRequestUserInfoViewModel *)viewModel{
    //跳转加入界
    HXBFin_Loan_Buy_ViewController *loanJoinVC = [[HXBFin_Loan_Buy_ViewController alloc]init];
    loanJoinVC.title                    = @"投资散标";
    loanJoinVC.availablePoint           = [NSString stringWithFormat:@"%.lf", self.loanDetailViewModel.loanDetailModel.loanVo.surplusAmount.doubleValue];
    loanJoinVC.placeholderStr           = self.loanDetailViewModel.addCondition;
    loanJoinVC.hasBindCard              = hasBindCard;
    loanJoinVC.loanId                   = self.loanDetailViewModel.loanDetailModel.userVo.loanId;
    loanJoinVC.minRegisterAmount        = self.loanDetailViewModel.loanDetailModel.minInverst;
    loanJoinVC.registerMultipleAmount   = self.loanDetailViewModel.loanDetailModel.minInverst;
    loanJoinVC.userInfoViewModel        = viewModel;
    [self.navigationController pushViewController:loanJoinVC animated:YES];
}

//MARK: 网络数据请求
- (void)downLoadData {
    __weak typeof(self)weakSelf = self;
    [[HXBFinanctingRequest sharedFinanctingRequest] loanDetaileWithLoanID:self.loanID andSuccessBlock:^(HXBFinDetailViewModel_LoanDetail *viewModel) {
        weakSelf.loanDetailViewModel = viewModel;
        weakSelf.title = viewModel.loanDetailModel.loanVo.title;
//        weakSelf.timeLabel.attributedText = [NSMutableAttributedString setupAttributeStringWithString:[NSString stringWithFormat:@"剩余投标时间：%@", viewModel.remainTime] WithRange:NSMakeRange(7, viewModel.remainTime.length) andAttributeColor:[UIColor orangeColor] andAttributeFont:weakSelf.timeLabel.font];
//        if ([viewModel.addButtonStr hasPrefix:@"立即"]) {
//            weakSelf.timeLabel.hidden = NO;
//        }
        weakSelf.loanDetailsView.modelArray = weakSelf.tableViewModelArray;
        [weakSelf.hxbBaseVCScrollView endRefresh];
    } andFailureBlock:^(NSError *error) {
        [weakSelf.hxbBaseVCScrollView endRefresh];
    }];
}

- (UITableView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
        
        _hxbBaseVCScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
        [_hxbBaseVCScrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _hxbBaseVCScrollView.tableFooterView = [[UIView alloc]init];
        _hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_hxbBaseVCScrollView];
    }
    return _hxbBaseVCScrollView;
}

- (void)dealloc {
    [self.hxbBaseVCScrollView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
    NSLog(@"✅被销毁 %@",self);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        NSNumber *tracking = change[NSKeyValueChangeNewKey];
        if (tracking.integerValue == UIGestureRecognizerStateBegan && self.trackingScrollViewBlock) {
            self.trackingScrollViewBlock(self.hxbBaseVCScrollView);
        }
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
}

@end

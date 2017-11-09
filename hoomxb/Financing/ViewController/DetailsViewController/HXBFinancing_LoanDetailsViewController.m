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
#import "HXBFinContract_contraceWebViewVC_Loan.h"//贷款合同的控制器

//#import "HXBFin_Loan_BuyViewController.h"//加入界面
#import "HXBFinAddTruastWebViewVC.h"

#pragma mark --- (肖扬 散标计划详情)
#import "HXBFin_creditorChange_buy_ViewController.h"

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
    self.navigationController.navigationBarHidden = false;
    //判断是否风险评测
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
    [self.hxbBaseVCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);//.offset(kScrAdaptationH(30))
        make.bottom.equalTo(self.view).offset(kScrAdaptationH(-50)); //注意适配iPhone X
    }];
//    self.hxbBaseVCScrollView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    self.loanDetailsView = [[HXBFin_DetailsView_LoanDetailsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [self.hxbBaseVCScrollView addSubview:self.loanDetailsView];
    
//    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.timeLabel];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view).offset(-kScrAdaptationH(50));
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.height.offset(kScrAdaptationH(25));
//    }];
//    self.timeLabel.hidden = YES;
//    self.timeLabel.textColor = [UIColor grayColor];
//    self.timeLabel.textAlignment = NSTextAlignmentCenter;
//    self.timeLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:self.loanDetailsView.addButton];
//    self.loanDetailsView.addButton.frame = CGRectMake(0, kScreenHeight - kScrAdaptationH(50), kScreenWidth, kScrAdaptationH(50));
    [self.loanDetailsView.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(50)));
    }];
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
- (void)enterLoanBuyViewController {
    //跳转加入界
    HXBFin_creditorChange_buy_ViewController *loanJoinVC = [[HXBFin_creditorChange_buy_ViewController alloc]init];
    loanJoinVC.title = @"投资散标";
    loanJoinVC.availablePoint = [NSString stringWithFormat:@"%.lf", self.loanDetailViewModel.loanDetailModel.loanVo.surplusAmount.doubleValue];
    loanJoinVC.placeholderStr = self.loanDetailViewModel.addCondition;
    loanJoinVC.loanId = self.loanDetailViewModel.loanDetailModel.userVo.loanId;
    loanJoinVC.minRegisterAmount = self.loanDetailViewModel.loanDetailModel.minInverst;
    loanJoinVC.registerMultipleAmount = self.loanDetailViewModel.loanDetailModel.minInverst;
    loanJoinVC.type = HXB_Loan;
    [self.navigationController pushViewController:loanJoinVC animated:true];
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
        if (LL_iPhoneX) {
            _hxbBaseVCScrollView.frame = CGRectMake(0, 88, kScreenWidth, kScreenHeight - 88);
        }
        
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

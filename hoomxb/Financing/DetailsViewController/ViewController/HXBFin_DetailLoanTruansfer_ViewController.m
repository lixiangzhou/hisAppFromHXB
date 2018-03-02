//
//  HXBFin_DetailLoanTruansfer_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  债转详情

#import "HXBFin_DetailLoanTruansfer_ViewController.h"
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"
#import "HXBFin_Detail_DetailVC_Loan.h"
///详情的VIEW
#import "HXBFinDetail_TableView.h"
#import "HXBFinAddRecordVC_LoanTruansfer.h"//转让记录
#import "HXBFinanctingDetail_imageCell.h"
#import "HXBFinanctingDetail_progressCell.h"
#import "HXBFin_LoanTruansferDetail_TopView.h"
#import "HXBFinanctingDetail_trustCell.h"
#import "HXBLoanTruansferDetailViewModel.h"
#import "HXBFin_creditorChange_buy_ViewController.h"
#import "HXBFinDetailViewModel_LoanDetail.h"

@interface HXBFin_DetailLoanTruansfer_ViewController ()<UITableViewDelegate, UITableViewDataSource>
///底部的tableView被点击
@property (nonatomic,copy) void (^clickBottomTabelViewCellBlock)(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model);
@property (nonatomic,copy) void (^clickAddButtonBlock)();
///详情的viewModel
@property (nonatomic,copy) NSString *addButtonStr;
///加入的button
@property (nonatomic,strong) UIButton *addButton;
///倒计时
@property (nonatomic,copy) NSString *diffTime;
/// 是否倒计时
@property (nonatomic,assign) BOOL isContDown;
///立即加入 倒计时
@property (nonatomic,strong) UILabel *countDownLabel;
///倒计时管理
@property (nonatomic,strong) HXBBaseCountDownManager_lightweight *countDownManager;
/// 表头视图
@property (nonatomic,strong) HXBFin_LoanTruansferDetail_TopView *topView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) HXBLoanTruansferDetailViewModel *viewModel;

@property (nonatomic, strong) HXBAlertManager* alertManager;
@end

@implementation HXBFin_DetailLoanTruansfer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf
    self.viewModel = [[HXBLoanTruansferDetailViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    self.isRedColorWithNavigationBar = YES;
    [self setUP];
    [self setupAddView];
    [self downLoadData];
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

- (void) setUP {
    kWeakSelf
    [self.tableView hxb_headerWithRefreshBlock:^{
        [weakSelf downLoadData];
    }];
    self.isTransparentNavigationBar = YES;
    self.tableView.backgroundColor = kHXBColor_BackGround;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight));
    }];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [self tableViewHeadView];
    self.tableView.tableFooterView = [self tableViewFootView];
    self.self.automaticallyAdjustsScrollViewInsets = NO;
}

//MARK: - 立即加入按钮的添加
- (void)setupAddView {
    self.addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
        make.height.equalTo(@(kScrAdaptationH(50)));
        make.bottom.equalTo(@(-HXBBottomAdditionHeight));
    }];
    [self.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.backgroundColor = COR29;
    [self.addButton setTitle:@"确认购买" forState:(UIControlStateNormal)];
    self.countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.addButton.height)];
    self.countDownLabel.textAlignment = NSTextAlignmentCenter;
    self.countDownLabel.hidden = YES;
    [self.addButton addSubview: self.countDownLabel];
    self.addButton.userInteractionEnabled = YES;
}

// 表头
- (UIView *)tableViewHeadView {
    self.topView = [[HXBFin_LoanTruansferDetail_TopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(268) - 64)];
    return self.topView;
}

- (UIView *)tableViewFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(10))];
    footView.backgroundColor = [UIColor clearColor];
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScrAdaptationH(10), kScreenWidth, kScrAdaptationH(17))];
    if (KeyChain.baseTitle.length > 0) {
        promptLabel.text = [NSString stringWithFormat:@"- %@ -",KeyChain.baseTitle];
        footView.height = kScrAdaptationH(37);
    }
    promptLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    promptLabel.textColor = kHXBColor_RGB(0.6, 0.6, 0.6, 1);
    promptLabel.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:promptLabel];
    return footView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    } else {
        return self.viewModel.tableViewTitleArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kScrAdaptationH(80);
    } else if (indexPath.section == 1) {
        return kScrAdaptationH(80);
    } else {
        return kScrAdaptationH(44.5);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HXBFinanctingDetail_imageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trustCell"];
        if (!cell) {
            cell = [[HXBFinanctingDetail_imageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"trustCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.trustView.image = [UIImage imageNamed:@"hxb_增信"];
        return cell;
    } else if (indexPath.section == 1) {
        HXBFinanctingDetail_trustCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trustCell"];
        if (!cell) {
            cell = [[HXBFinanctingDetail_trustCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"trustCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.repaymentType = self.viewModel.loanTruansferDetailModel.repaymentType;
        cell.nextRepayDate = self.viewModel.loanTruansferDetailModel.nextRepayDate;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        cell.separatorInset = UIEdgeInsetsMake(0, kScrAdaptationW(15), 0, kScrAdaptationW(15));
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.viewModel.tableViewTitleArray[indexPath.row];
        cell.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_AddTrustURL] fromController:self];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {

            HXBFin_Detail_DetailVC_Loan *detail_DetailLoanVC = [[HXBFin_Detail_DetailVC_Loan alloc]init];
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager = self.loanTruansferDetailViewModel.fin_LoanInfoView_Manager;
            
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.overDueStatus = self.loanTruansferDetailViewModel.loanTruansferDetailModel.userVo.overDueStatus;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.otherPlatStatus = self.loanTruansferDetailViewModel.loanTruansferDetailModel.userVo.otherPlatStatus;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.protectSolution = self.loanTruansferDetailViewModel.loanTruansferDetailModel.userVo.protectSolution;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.userFinanceStatus = self.loanTruansferDetailViewModel.loanTruansferDetailModel.userVo.userFinanceStatus;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.repaymentCapacity = self.loanTruansferDetailViewModel.loanTruansferDetailModel.userVo.repaymentCapacity;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.punishedStatus = self.loanTruansferDetailViewModel.loanTruansferDetailModel.userVo.punishedStatus;
            
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.loanInstruction = self.loanTruansferDetailViewModel.loanTruansferDetailModel.userVo.descriptionStr;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.creditInfoItems = self.loanTruansferDetailViewModel.loanTruansferDetailModel.loanVo.creditInfoItems;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.riskLevel = self.loanTruansferDetailViewModel.loanTruansferDetailModel.loanVo.riskLevel;
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager.riskLevelDesc = self.loanTruansferDetailViewModel.loanTruansferDetailModel.loanVo.riskLevelDesc;
            [self.navigationController pushViewController:detail_DetailLoanVC animated:YES];
        } else if (indexPath.row == 1) {
            HXBFinAddRecordVC_LoanTruansfer *loanAddRecordVC = [[HXBFinAddRecordVC_LoanTruansfer alloc]init];
            loanAddRecordVC.loanTruansferID = self.loanTransfer_ViewModel.transferId;
            [self.navigationController pushViewController:loanAddRecordVC animated:YES];
        } else {
            [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_LoanTruansferURL] fromController:self];
        }
    }
}

///点击了立即加入
- (void)clickAddButton:(UIButton *)sender {
    if (!KeyChain.isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        return;
    }
    ///判断是否实名。。。。
    kWeakSelf
    [self.alertManager checkOutRiskAssessmentWithSuperVC:self andWithPushBlock:^(NSString *hasBindCard, HXBRequestUserInfoViewModel *model) {
        [weakSelf enterLoanBuyViewControllerWithHasBindCard:hasBindCard userInfo:model];
    }];
}

- (void)enterLoanBuyViewControllerWithHasBindCard:(NSString *)hasBindCard userInfo:(HXBRequestUserInfoViewModel *)viewModel {
    if ([self.viewModel.loanTruansferDetailModel.loanTruansferDetailModel.enabledBuy isEqualToString:@"0"]) {
        [HxbHUDProgress showTextWithMessage:@"自己转让的债权无法再次购买"];
        return;
    }
    
    [self.navigationController pushViewController:[self.viewModel getACreditorChangeBuyController:hasBindCard userInfo:viewModel] animated:YES];
}


#pragma mark - downLoadData

//MARK: 网络数据请求
- (void)downLoadData {
    kWeakSelf
    
    [self.viewModel requestLoanDetailWithLoanTruansferId:self.loanID resultBlock:^(BOOL isSuccess) {
        [weakSelf.tableView endRefresh];
        if (isSuccess) {
            [weakSelf setData];
            weakSelf.tableView.hidden = NO;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)setData {
    self.topView.interestLabelLeftStr = self.loanTransfer_ViewModel.loanTruansferListModel.interest;
    self.topView.remainTimeLabelLeftStr = self.viewModel.loanTruansferDetailModel.leftMonths;
    self.topView.truansferAmountLabelLeftStr = self.viewModel.loanTruansferDetailModel.leftTransAmount;
    self.topView.nextOneText = @"下一还款日";
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        [self.view insertSubview:_tableView atIndex:0];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_tableView];
    }
    return _tableView;
}

@end

//
//  HXBFin_DetailLoanTruansfer_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/7/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_DetailLoanTruansfer_ViewController.h"
#import "HXBFinanctingRequest.h"
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"
#import "HXBFin_Detail_DetailVC_Loan.h"
///详情的VIEW
#import "HXBFinDetail_TableView.h"
#import "HXBFin_LoanTruansferDetailViewController.h"
#import "HXBMYViewModel_MainLoanViewModel.h"///借款信息
#import "HXBFinAddRecortdVC_Loan.h"///转让记录
#import "HXBFinLoanTruansfer_ContraceWebViewVC.h"//转让协议
#import "HXBFinDetailViewModel_LoanTruansferDetail.h"//详情的viewModel
#import "HXBFinAddRecordVC_LoanTruansfer.h"//转让记录
#import "HXBFinAddTruastWebViewVC.h"///曾信页
#import "HXBFinanctingDetail_imageCell.h"
#import "HXBFinanctingDetail_progressCell.h"
#import "HXBFin_LoanTruansferDetail_TopView.h"
#import "HXBFinanctingDetail_trustCell.h"
#import "HXBFin_creditorChange_buy_ViewController.h"


@interface HXBFin_DetailLoanTruansfer_ViewController ()<UITableViewDelegate, UITableViewDataSource>

//假的navigationBar
@property (nonatomic,strong) UIImageView *topImageView;
///底部的tableView被点击
@property (nonatomic,copy) void (^clickBottomTabelViewCellBlock)(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model);
@property (nonatomic,copy) void (^clickAddButtonBlock)();

///tableView的tatile
@property (nonatomic,strong) NSArray *tableViewTitleArray;
///详情的viewModel
@property (nonatomic,strong) HXBFinDetailViewModel_LoanTruansferDetail *loanTruansferDetailViewModel;
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


@end

@implementation HXBFin_DetailLoanTruansfer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPTopImageView];
    [self setUP];
    [self setupAddView];
    [self downLoadData];
}

- (void)setUPTopImageView {
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.topImageView.image = [UIImage imageNamed:@"NavigationBar"];
    [self.view addSubview:self.topImageView];
}

- (void) setUP {
    kWeakSelf
    [self.hxbBaseVCScrollView hxb_HeaderWithHeaderRefreshCallBack:^{
        [weakSelf downLoadData];
    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
        [weakSelf.hxbBaseVCScrollView endRefresh];
    }];
    self.isTransparentNavigationBar = true;
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    [self.hxbBaseVCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);//.offset(kScrAdaptationH(30))
        make.bottom.equalTo(self.view).offset(kScrAdaptationH(-50)); //注意适配iPhone X
    }];
//    self.hxbBaseVCScrollView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - kScrAdaptationH(50));
    self.hxbBaseVCScrollView.delegate = self;
    self.hxbBaseVCScrollView.dataSource = self;
    self.hxbBaseVCScrollView.tableHeaderView = [self tableViewHeadView];
    self.hxbBaseVCScrollView.tableFooterView = [self tableViewFootView];
//    self.hxbBaseVCScrollView.hidden = YES;
    //    self.detailView = [[HXBFin_LoanTruansferDetailView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    //    [self.hxbBaseVCScrollView addSubview:self.detailView];
    self.hxb_automaticallyAdjustsScrollViewInsets = false;
}

//MARK: - 立即加入按钮的添加
- (void)setupAddView {
    self.addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.addButton.frame = CGRectMake(0, kScreenHeight - kScrAdaptationH(50), kScreenWidth, kScrAdaptationH(50));
    [self.view addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(50)));
    }];
    [self.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.backgroundColor = COR29;
    [self.addButton setTitle:@"确认购买" forState:(UIControlStateNormal)];
    self.countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.addButton.height)];
    self.countDownLabel.textAlignment = NSTextAlignmentCenter;
    self.countDownLabel.hidden = YES;
    [self.addButton addSubview: self.countDownLabel];
    self.addButton.userInteractionEnabled = true;
}



// 表头
- (UIView *)tableViewHeadView {
    self.topView = [[HXBFin_LoanTruansferDetail_TopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(268) - 64)];
    return self.topView;
}

- (UIView *)tableViewFootView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(37))];
    footView.backgroundColor = [UIColor clearColor];
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScrAdaptationH(10), kScreenWidth, kScrAdaptationH(17))];
    promptLabel.text = @"- 预期收益不代表实际收益，投资需谨慎 -";
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
        return self.tableViewTitleArray.count;
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
        cell.repaymentType = self.loanTruansferDetailViewModel.repaymentType;
        cell.nextRepayDate = self.loanTruansferDetailViewModel.nextRepayDate;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.tableViewTitleArray[indexPath.row];
        cell.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
        vc.URL = kHXB_Negotiate_AddTrustURL;
        [self.navigationController pushViewController:vc animated:true];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            HXBFin_Detail_DetailVC_Loan *detail_DetailLoanVC = [[HXBFin_Detail_DetailVC_Loan alloc]init];
            detail_DetailLoanVC.fin_Detail_DetailVC_LoanManager = self.loanTruansferDetailViewModel.fin_LoanInfoView_Manager;
            [self.navigationController pushViewController:detail_DetailLoanVC animated:true];
        } else if (indexPath.row == 1) {
            HXBFinAddRecordVC_LoanTruansfer *loanAddRecordVC = [[HXBFinAddRecordVC_LoanTruansfer alloc]init];
            loanAddRecordVC.loanTruansferID = self.loanTransfer_ViewModel.transferId;
            [self.navigationController pushViewController:loanAddRecordVC animated:true];
        } else {
            HXBFinLoanTruansfer_ContraceWebViewVC * contractWebViewVC = [[HXBFinLoanTruansfer_ContraceWebViewVC alloc]init];
            contractWebViewVC.URL = self.loanTruansferDetailViewModel.agreementURL;
            [self.navigationController pushViewController:contractWebViewVC animated:true];
        }
    }
}

///点击了立即加入
- (void)clickAddButton:(UIButton *)sender {
    if (![KeyChainManage sharedInstance].isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        return;
    }
    ///判断是否实名。。。。
    [HXBAlertManager checkOutRiskAssessmentWithSuperVC:self andWithPushBlock:^{
        [self enterLoanBuyViewController];
    }];
}

- (void)enterLoanBuyViewController {
    if ([self.loanTruansferDetailViewModel.loanTruansferDetailModel.enabledBuy isEqualToString:@"0"]) {
        [HxbHUDProgress showTextWithMessage:@"自己转让的债权无法再次购买"];
        return;
    }
    HXBFin_creditorChange_buy_ViewController *loanJoinVC = [[HXBFin_creditorChange_buy_ViewController alloc]init];
    loanJoinVC.title = @"投资债权";
    loanJoinVC.type = HXB_Creditor;
    loanJoinVC.loanId = self.loanTruansferDetailViewModel.loanTruansferDetailModel.transferId;
    loanJoinVC.placeholderStr = self.loanTruansferDetailViewModel.startIncrease_Amount;
    loanJoinVC.availablePoint = self.loanTruansferDetailViewModel.loanTruansferDetailModel.leftTransAmount;
    loanJoinVC.minRegisterAmount = self.loanTruansferDetailViewModel.loanTruansferDetailModel.minInverst;
    loanJoinVC.registerMultipleAmount = self.loanTruansferDetailViewModel.loanTruansferDetailModel.minInverst;
    [self.navigationController pushViewController:loanJoinVC animated:true];
}


#pragma mark - downLoadData

//MARK: 网络数据请求
- (void)downLoadData {
    kWeakSelf
    [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansferDetileRequestWithLoanID:weakSelf.loanID andSuccessBlock:^(HXBFinDetailViewModel_LoanTruansferDetail *viewModel) {
        weakSelf.loanTruansferDetailViewModel = viewModel;
        [weakSelf setData];
        weakSelf.hxbBaseVCScrollView.hidden = NO;
        [weakSelf.hxbBaseVCScrollView reloadData];
        [weakSelf.hxbBaseVCScrollView endRefresh];
    } andFailureBlock:^(NSError *error, NSDictionary *respons) {
        [weakSelf.hxbBaseVCScrollView endRefresh];
        [HxbHUDProgress showMessageCenter:respons[kResponseMessage] inView:weakSelf.view];
    }];
}

- (void) setData {
    self.topView.interestLabelLeftStr = self.loanTransfer_ViewModel.loanTruansferListModel.interest;
    self.topView.remainTimeLabelLeftStr = self.loanTruansferDetailViewModel.leftMonths;
    self.topView.truansferAmountLabelLeftStr = self.loanTruansferDetailViewModel.leftTransAmount;
    self.topView.nextOneText = @"下个还款日";
}

- (NSArray *) tableViewTitleArray {
    if (!_tableViewTitleArray) {
        _tableViewTitleArray = @[@"借款信息", @"转让记录", @"债权转让及受让协议"];
    }
    return _tableViewTitleArray;
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

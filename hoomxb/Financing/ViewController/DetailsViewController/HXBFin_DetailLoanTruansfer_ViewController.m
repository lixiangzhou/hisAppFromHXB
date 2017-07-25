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
#import "HXBFin_LoanTruansferDetailView.h"
#import "HXBFinDetail_TableView.h"
#import "HXBFin_LoanTruansferDetailViewController.h"
#import "HXBMYViewModel_MainLoanViewModel.h"///借款信息
#import "HXBFinAddRecortdVC_Loan.h"///转让记录
#import "HXBFinLoanTruansfer_ContraceWebViewVC.h"//转让协议
#import "HXBFin_LoanTruansfer_BuyViewController.h"///转让购买
#import "HXBFinDetailViewModel_LoanTruansferDetail.h"//详情的viewModel
#import "HXBFinAddRecordVC_LoanTruansfer.h"//转让记录
#import "HXBFinAddTruastWebViewVC.h"///曾信页

@interface HXBFin_DetailLoanTruansfer_ViewController ()

//假的navigationBar
@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) HXBFin_LoanTruansferDetailView *detailView;
///底部的tableView被点击
@property (nonatomic,copy) void (^clickBottomTabelViewCellBlock)(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model);
@property (nonatomic,copy) void (^clickAddButtonBlock)();

///tableView的tatile
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>*tableViewTitleArray;
///详情的viewModel
@property (nonatomic,strong) HXBFinDetailViewModel_LoanTruansferDetail *loanTruansferDetailViewModel;
@end

@implementation HXBFin_DetailLoanTruansfer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    [self downLoadData];
    [self registerEvent];
}

#pragma mark - setUP
- (void) setUP {
    kWeakSelf
    self.title = @"消费债权";
    [self.hxbBaseVCScrollView hxb_HeaderWithHeaderRefreshCallBack:^{
        [weakSelf downLoadData];
    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
        [weakSelf.hxbBaseVCScrollView endRefresh];
    }];
    
    [self setUPTopImageView];
    
    self.isTransparentNavigationBar = true;
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    self.hxbBaseVCScrollView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    self.detailView = [[HXBFin_LoanTruansferDetailView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [self.hxbBaseVCScrollView addSubview:self.detailView];
    self.hxb_automaticallyAdjustsScrollViewInsets = false;
}
- (void)setUPTopImageView {
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.topImageView.image = [UIImage imageNamed:@"NavigationBar"];
    [self.view addSubview:self.topImageView];
}

- (void)setLoanTransfer_ViewModel:(HXBFinHomePageViewModel_LoanTruansferViewModel *)loanTransfer_ViewModel {
    _loanTransfer_ViewModel = loanTransfer_ViewModel;
}


- (void) registerEvent {
    [self registerClickCell];
    [self registerClickAddButton];
    [self registerAddTrust];
}

- (void)registerClickCell {
    __weak typeof (self)weakSelf = self;
    [self.detailView clickBottomTableViewCellBloakFunc:^(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model) {
        //跳转相应的页面
        NSLog(@"%@",model.optionTitle);
        ///点击了借款信息
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[0].optionTitle]) {
            HXBFin_Detail_DetailVC_Loan *detail_DetailLoanVC = [[HXBFin_Detail_DetailVC_Loan alloc]init];
            //            detail_DetailLoanVC. = self.planDetailViewModel;
//            detail_DetailLoanVC.loanDetailViewModel = weakSelf.loanDetailViewModel;
            [weakSelf.navigationController pushViewController:detail_DetailLoanVC animated:true];
        }
        ///  转让记录
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[1].optionTitle]) {
            HXBFinAddRecordVC_LoanTruansfer *loanAddRecordVC = [[HXBFinAddRecordVC_LoanTruansfer alloc]init];
            loanAddRecordVC.loanTruansferID = weakSelf.loanID;
            [weakSelf.navigationController pushViewController:loanAddRecordVC animated:true];
        }
        ///合同
        if ([model.optionTitle isEqualToString:weakSelf.tableViewTitleArray[2].optionTitle]) {
            //跳转一个webView
            HXBFinLoanTruansfer_ContraceWebViewVC * contractWebViewVC = [[HXBFinLoanTruansfer_ContraceWebViewVC alloc]init];
            contractWebViewVC.URL = self.loanTruansferDetailViewModel.agreementURL;
            [weakSelf.navigationController pushViewController:contractWebViewVC animated:true];
        }
    }];
}

///点击了立即加入
- (void)registerClickAddButton {
    kWeakSelf
    [self.detailView clickAddButtonBlock:^(UIButton *button) {
        //如果不是登录 那么就登录
        if (![KeyChainManage sharedInstance].isLogin) {
            //            [HXBAlertManager alertManager_loginAgainAlertWithView:self.view];
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            return;
        }
        ///判断是否实名。。。。
        [HXBAlertManager checkOutRiskAssessmentWithSuperVC:weakSelf andWithPushBlock:^{
            [weakSelf enterLoanBuyViewController];
        }];
    }];
}

- (void)enterLoanBuyViewController
{
    //跳转加入界面
    HXBFin_LoanTruansfer_BuyViewController *loanJoinVC = [[HXBFin_LoanTruansfer_BuyViewController alloc]init];
    loanJoinVC.title = @"散标投资";
    loanJoinVC.loanTruansferViewModel = self.loanTruansferDetailViewModel;
//    loanJoinVC.availablePoint = _availablePoint;
    [self.navigationController pushViewController:loanJoinVC animated:true];
}

- (void)registerAddTrust {
    kWeakSelf
    [self.detailView clickAddTrustWithBlock:^{
        HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
        vc.URL = kHXB_Negotiate_AddTrustURL;
        [weakSelf.navigationController pushViewController:vc animated:true];
    }];
}
#pragma mark - downLoadData

//MARK: 网络数据请求
- (void)downLoadData {
    __weak typeof(self)weakSelf = self;
    [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansferDetileRequestWithLoanID:self.loanID andSuccessBlock:^(HXBFinDetailViewModel_LoanTruansferDetail *viewModel) {
        self.loanTruansferDetailViewModel = viewModel;
        [self setData];
        [weakSelf.hxbBaseVCScrollView endRefresh];
    } andFailureBlock:^(NSError *error, NSDictionary *respons) {
        [weakSelf.hxbBaseVCScrollView endRefresh];
        [HxbHUDProgress showMessageCenter:respons[kResponseMessage] inView:self.view];
    }];
}

- (void) setData {
    kWeakSelf
    [self.detailView setUPValueWithManager:^HXBFin_LoanTruansferDetailViewManger *(HXBFin_LoanTruansferDetailViewManger *manager) {
        ///顶部的品字形
        /**
         下个还款日 05-31
         品字形 上右
         */
        manager.topViewManager.nextOneLabel = @"下个还款日";
        /**
         年利率 label
         品字形 上
         */
        manager.topViewManager.interestLabelManager.rightLabelStr = @"年利率";
        manager.topViewManager.interestLabelManager.leftLabelStr = weakSelf.loanTransfer_ViewModel.loanTruansferListModel.interest;

        /**
         剩余期限
         品字形 左
         */
        manager.topViewManager.remainTimeLabelManager.rightLabelStr = @"剩余期限";
        manager.topViewManager.remainTimeLabelManager.leftLabelStr = weakSelf.loanTruansferDetailViewModel.leftMonths;
        /**
         待转让金额
         品字形 右
         */
        manager.topViewManager.truansferAmountLabelManager.rightLabelStr = @"待转让金额";
        manager.topViewManager.truansferAmountLabelManager.leftLabelStr = weakSelf.loanTruansferDetailViewModel.creatTransAmount;

        /**
         左侧的stringArray
         */
        manager.loanType_InterestLabelManager.leftStrArray = @[@"下一个还款日",@"还款方式"];
        /**
         右侧的stringArray
         */
        manager.loanType_InterestLabelManager.rightStrArray = @[@"00-00",
                                                                weakSelf.loanTruansferDetailViewModel.loanTruansferDetailModel.loanVo.repaymentType];
        /**
         图片- 文字- 图片 的tableView
         */
        manager.detailTableViewArray = weakSelf.tableViewTitleArray;
        /**
         * 预期收益不代表实际收益，投资需谨慎
         */
        manager.promptLabelStr = @"* 预期收益不代表实际收益，投资需谨慎";
        /**
         加入按钮
         */
        manager.addButtonStr = weakSelf.loanTruansferDetailViewModel.status;
        manager.isAddButtonClick = weakSelf.loanTruansferDetailViewModel.isUserInteractionEnabled;
        manager.addButtonBackgroundColor = weakSelf.loanTruansferDetailViewModel.addButtonBackgroundColor;
        manager.addButtonTitleColor = weakSelf.loanTruansferDetailViewModel.addButtonTitleColor;
        return manager;
    }];
}

- (NSArray <HXBFinDetail_TableViewCellModel *> *) tableViewTitleArray {
    if (!_tableViewTitleArray) {
        HXBFinDetail_TableViewCellModel *model1 = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:@"1" andOptionIitle:@"借款信息"];
        HXBFinDetail_TableViewCellModel *model2 = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:@"1" andOptionIitle:@"转让记录"];
        HXBFinDetail_TableViewCellModel *model3 = [[HXBFinDetail_TableViewCellModel alloc]initWithImageName:@"1" andOptionIitle:@"《债权转让及受让协议》及《反洗钱及出借风险提示书》"];
        _tableViewTitleArray = @[model1,model2,model3];
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

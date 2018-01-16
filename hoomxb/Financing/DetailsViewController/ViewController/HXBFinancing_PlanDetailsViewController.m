//
//  HXBFinancing_PlanViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  计划详情

#import "HXBFinancing_PlanDetailsViewController.h"
#import "HXBFin_PlanDetailView.h"///红利计划详情页的主视图
#import "HXBFinHomePageViewModel_PlanList.h"//红利计划的Viewmodel
#import "HXBFinHomePageModel_PlanList.h"//红利计划的Model
#import "HXBFinAddRecordVC_Plan.h"//红利计划的加入记录
#import "HXBFin_Detail_DetailsVC_Plan.h"//红利计划详情中的详情
#import "HXBFinanctingDetail_imageCell.h"
#import "HXBFinanctingDetail_progressCell.h"
#import "HXBFin_PlanDetailView_TopView.h"
#import "HXBFinBase_FlowChartView.h"
#import "HXBFinancingPlanDetailViewModel.h"

@interface HXBFinancing_PlanDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,weak) HXBFin_PlanDetailView_ViewModelVM *planDetailVM;
@property (nonatomic,copy) NSString *availablePoint;//可用余额；
@property (nonatomic,assign) BOOL isIdPassed;
@property (nonatomic,assign) BOOL isVerify;
/// 表头视图
@property (nonatomic,strong) HXBFin_PlanDetailView_TopView *topView;
@property (nonatomic,copy) NSString *lockPeriodStr;
///红利计划：（起投 固定值1000） 散标：（标的期限）
@property (nonatomic,copy) NSString *startInvestmentStr;
@property (nonatomic,copy) NSString *startInvestmentStr_const;
///红利计划：剩余金额 散标列表是（剩余金额）
@property (nonatomic,copy) NSString *remainAmount;
@property (nonatomic,copy) NSString *remainAmount_const;

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
///倒计时完成刷新数据
@property (nonatomic,copy) void(^downLodaDataBlock)();

@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;

@property (nonatomic, strong) HXBFinancingPlanDetailViewModel *viewModel;

@end

@implementation HXBFinancing_PlanDetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf
    self.viewModel = [[HXBFinancingPlanDetailViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    self.isRedColorWithNavigationBar = YES;
    
    [self setup];
    [self downLoadData];

    [self setupAddView];
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        _availablePoint = viewModel.availablePoint;
        _isIdPassed = viewModel.userInfoModel.userInfo.isIdPassed.integerValue;
    } andFailure:^(NSError *error) {
        
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadData) name:kHXBNotification_starCountDown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadData) name:kHXBNotification_checkLoginSuccess object:nil];
}

/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
    [self downLoadData];
}

//MARK: - 立即加入按钮的添加
- (void)setupAddView {
    self.addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    self.addButton.frame = CGRectMake(0, kScreenHeight - kScrAdaptationH(50), kScreenWidth, kScrAdaptationH(50));
    [self.view addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(50)));
        make.top.equalTo(self.hxbBaseVCScrollView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-HXBBottomAdditionHeight);
    }];
    [self.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.backgroundColor = [UIColor clearColor];
    [self.addButton setTitle:self.addButtonStr forState:UIControlStateNormal];
    
    self.countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.addButton.height)];
    self.countDownLabel.textAlignment = NSTextAlignmentCenter;
    [self.addButton addSubview: self.countDownLabel];
    self.addButton.userInteractionEnabled = YES;
}

- (void)clickAddButton: (UIButton *)button {
    if(!KeyChain.isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        return;
    }

    [HXBAlertManager checkOutRiskAssessmentWithSuperVC:self andWithPushBlock:^{
        [self enterPlanBuyViewController];
    }];
}

- (void) setAddButtonStr:(NSString *)addButtonStr {
    _addButtonStr = addButtonStr;
    [self.addButton setTitle:addButtonStr forState:UIControlStateNormal];
}

///MARK: 倒计时的判断
- (void)setIsContDown:(BOOL)isContDown {
    kWeakSelf
    _isContDown = isContDown;
    if (isContDown) {
        [self.countDownManager resumeTimer];
        [self.countDownManager countDownCallBackFunc:^(CGFloat countDownValue) {
            if (countDownValue < 0) {
                if (weakSelf.downLodaDataBlock) weakSelf.downLodaDataBlock();
                [weakSelf.addButton setTitle:@"立即加入" forState:UIControlStateNormal];
                [weakSelf.addButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                weakSelf.countDownLabel.text = @"立即加入";
                weakSelf.countDownLabel.textColor = [UIColor whiteColor];
                weakSelf.addButton.backgroundColor = COR29;
                weakSelf.addButton.userInteractionEnabled = YES;
                [weakSelf.countDownManager stopTimer];
                return;
            }
            [weakSelf.addButton setTitle:[weakSelf.viewModel countDownString:countDownValue] forState:UIControlStateNormal];
        }];
    }else {
        if (weakSelf.viewModel.statusCanJoinIn) {//等待加入
            [weakSelf.addButton setTitle:weakSelf.viewModel.planDetailModel.remainTimeString forState:UIControlStateNormal];
        }
    }
}

- (void)setDiffTime:(NSString *)diffTime {
    _diffTime = diffTime;
}

- (void)setPlanAddButton:(NSString *)planAddButton {
    _planAddButton = planAddButton;
}

- (void)setPlanListViewModel:(HXBFinHomePageViewModel_PlanList *)planListViewModel {
    _planListViewModel = planListViewModel;
    self.planID = planListViewModel.planListModel.ID;
}

///MARK: 设置值
- (void)setPlanDetailViewModel:(HXBFinDetailViewModel_PlanDetail *)planDetailViewModel {
    kWeakSelf
    [self.topView setUPValueWithManager:^HXBFin_PlanDetailView_TopViewManager *(HXBFin_PlanDetailView_TopViewManager *manager) {
        if (weakSelf.viewModel.hasExtraInterestRate) {
            weakSelf.topView.attributeStringLength = weakSelf.viewModel.planDetailModel.planDetailModel.extraInterestRate.length + 2;
        }
        [weakSelf.viewModel setTopViewManagerData:manager];
        return manager;
    }];
    self.diffTime = weakSelf.viewModel.planDetailModel.countDownStr;
    self.isContDown = weakSelf.viewModel.planDetailModel.isContDown;
    
    //加入button设置 数据
    self.addButton.userInteractionEnabled = self.viewModel.planDetailModel.isAddButtonInteraction;
        [self.addButton setTitleColor:self.viewModel.planDetailModel.addButtonTitleColor forState:UIControlStateNormal];
    if (self.viewModel.statusCanJoinIn) {//等待加入
        [self.addButton setTitle:self.viewModel.planDetailModel.remainTimeString forState:UIControlStateNormal];
    }else
    {
        [self.addButton setTitle:self.viewModel.planDetailModel.addButtonStr forState:UIControlStateNormal];

    }
    self.addButton.backgroundColor = self.viewModel.planDetailModel.addButtonBackgroundColor;
}

//MARK: ------ setup -------
- (void)setup {
    kWeakSelf
    [self.hxbBaseVCScrollView hxb_headerWithRefreshBlock:^{
        [weakSelf downLoadData];
    }];

    self.isTransparentNavigationBar = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    [self.hxbBaseVCScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight));
    }];
    self.hxbBaseVCScrollView.separatorColor = COR12;
    if ([self.hxbBaseVCScrollView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.hxbBaseVCScrollView setSeparatorInset:UIEdgeInsetsMake(0, kScrAdaptationW(15), 0, kScrAdaptationW(15))];
    }
    if ([self.hxbBaseVCScrollView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.hxbBaseVCScrollView setLayoutMargins:UIEdgeInsetsMake(0, kScrAdaptationW(15), 0, kScrAdaptationW(15))];
    }
    self.hxbBaseVCScrollView.delegate = self;
    self.hxbBaseVCScrollView.dataSource = self;
    self.hxbBaseVCScrollView.tableHeaderView = [self tableViewHeadView];
    self.hxbBaseVCScrollView.tableFooterView = [self tableViewFootView];
    [self.hxbBaseVCScrollView reloadData];
    
}



// 表头
- (UIView *)tableViewHeadView {
    self.topView = [[HXBFin_PlanDetailView_TopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(268) - 64)];
    self.topView.backgroundColor = [UIColor greenColor];
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
        return kScrAdaptationH(108);
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
        HXBFinanctingDetail_progressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flowChartCell"];
        if (!cell) {
            cell = [[HXBFinanctingDetail_progressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"flowChartCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        kWeakSelf
        if (self.viewModel.planDetailModel.planDetailModel.unifyStatus.integerValue) {
            cell.flowChartView.stage = self.viewModel.planDetailModel.planDetailModel.unifyStatus.integerValue;
            [cell.flowChartView setUPFlowChartViewManagerWithManager:^HXBFinBase_FlowChartView_Manager *(HXBFinBase_FlowChartView_Manager *manager) {
                [weakSelf.viewModel setFlowChartViewManagerData:manager];
                return manager;
            }];
            cell.flowChartView.profitStr = self.viewModel.profitString;
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
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
            HXBFin_Detail_DetailsVC_Plan *detail_DetailPlanVC = [[HXBFin_Detail_DetailsVC_Plan alloc] init];
            detail_DetailPlanVC.planDetailModel = self.viewModel.planDetailModel;
            [self.navigationController pushViewController:detail_DetailPlanVC animated:YES];
        } else if (indexPath.row == 1) {
            HXBFinAddRecordVC_Plan *planAddRecordVC = [[HXBFinAddRecordVC_Plan alloc]init];
            planAddRecordVC.planListViewModel = self.planListViewModel;
            planAddRecordVC.planID = self.planID;
            [self.navigationController pushViewController:planAddRecordVC animated:YES];
        } else {
            
            NSString *urlStr = [self.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] ? kHXB_Negotiate_ServePlanMonthURL : kHXB_Negotiate_ServePlanURL;
            [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:urlStr] fromController:self];
        }
    }
}

/**
 跳转加入界面
 */
- (void)enterPlanBuyViewController {
    [self.navigationController pushViewController:[self.viewModel getAPlanBuyController] animated:YES];
}

- (HXBBaseCountDownManager_lightweight *)countDownManager {
    if (!_countDownManager) {
        _countDownManager = [[HXBBaseCountDownManager_lightweight alloc]initWithCountDownEndTime:self.diffTime.floatValue  andCountDownEndTimeType:HXBBaseCountDownManager_lightweight_CountDownEndTime_CompareType_Now andCountDownDuration:3600 andCountDownUnit:1];
    }
    return _countDownManager;
}

//MARK: 网络数据请求
- (void)downLoadData {
    kWeakSelf
    [self.viewModel requestPlanDetailWithPlanId:self.planID resultBlock:^(BOOL isSuccess) {
        [weakSelf.hxbBaseVCScrollView endRefresh];
        if (isSuccess) {
            
            [weakSelf setPlanDetailViewModel:weakSelf.viewModel.planDetailModel];
            weakSelf.cashType = weakSelf.viewModel.planDetailModel.planDetailModel.cashType;
            if (weakSelf.viewModel.planDetailModel.isContDown) {
                weakSelf.countDownManager.countDownEndTime = [weakSelf.viewModel.planDetailModel.countDownStr floatValue];
            } else {
                if (weakSelf.viewModel.planDetailModel.planDetailModel.unifyStatus.integerValue <= 5) {//等待加入
                    [weakSelf.addButton setTitle:weakSelf.viewModel.planDetailModel.remainTimeString forState:UIControlStateNormal];
                } else {
                    [weakSelf.addButton setTitle:weakSelf.viewModel.planDetailModel.addButtonStr forState:UIControlStateNormal];
                }
                [weakSelf.countDownManager stopTimer];
            }
            weakSelf.hxbBaseVCScrollView.hidden = NO;
            weakSelf.title = weakSelf.viewModel.planDetailModel.planDetailModel.name;
            [weakSelf.hxbBaseVCScrollView reloadData];
        }
    }];
}

- (UITableView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
        
        _hxbBaseVCScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight) style:UITableViewStylePlain];

        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
        _hxbBaseVCScrollView.tableFooterView = [[UIView alloc]init];
        _hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_hxbBaseVCScrollView];
    }
    return _hxbBaseVCScrollView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHXBNotification_starCountDown object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHXBNotification_checkLoginSuccess object:nil];
    NSLog(@"✅被销毁 %@",self);
}
@end

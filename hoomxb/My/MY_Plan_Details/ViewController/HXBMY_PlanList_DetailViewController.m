//
//  HXBMY_PlanList_DetailViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  账户内计划详情

#import "HXBMY_PlanList_DetailViewController.h"
#import "HXBMYViewModel_MianPlanViewModel.h"//红利计划列表页的ViewModel
#import "HXBMYModel_MainPlanModel.h"//红利计划列表页的Model

#import "HXBMYViewModel_PlanDetailViewModel.h"//红利计划详情页的ViewModel
#import "HXBMYModel_PlanDetailModel.h"//红利计划详情的Model

#import "HXBMY_PlanDetailView.h"//详情页的View
//#import "HXBMYPlanListDetailsExitViewController.h" //结果确认页
#import "HXBFinDetailViewModel_PlanDetail.h"//viewMode 购买
#import "HXBFinDetailModel_PlanDetail.h"//model 购买
#import "HXBMYViewModel_MianPlanViewModel.h"
#import "HXBMY_Plan_Capital_ViewController.h"//投资记录
#import "HXBMyPlanDetailsViewModel.h"
#import "HXBMYPlanListDetailsExitViewController.h"

@interface HXBMY_PlanList_DetailViewController ()
@property (nonatomic, strong) HXBMY_PlanDetailView *planDetailView;
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *buttonDescLabel;
@property (nonatomic, strong) HXBMyPlanDetailsViewModel *viewModel;
@end

@implementation HXBMY_PlanList_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isColourGradientNavigationBar = YES;
    [self setUP];
    kWeakSelf
    _viewModel = [[HXBMyPlanDetailsViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    self.title = self.planViewModel.planModelDataList.name;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self downData];
}

- (void) setUP {
    kWeakSelf
    HXBMY_PlanDetailView *planDetailView = [[HXBMY_PlanDetailView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, (kScrAdaptationH(447) + self.cake * kScrAdaptationH(37.5))) andInfoHaveCake:self.cake];
    
    UIButton *addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UILabel *buttonDescLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.buttonDescLabel = buttonDescLabel;
    self.addButton = addButton;
    self.planDetailView = planDetailView;
    self.buttonDescLabel.textColor = kHXBColor_666666_100;
    self.buttonDescLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.buttonDescLabel.backgroundColor = BACKGROUNDCOLOR;
    self.buttonDescLabel.numberOfLines = 0;
    [self.addButton addTarget:self action:@selector(clickAddButton) forControlEvents:(UIControlEventTouchUpInside)];
    self.addButton.titleLabel.numberOfLines = 0;
    self.addButton.titleLabel.textColor = [UIColor whiteColor];
    [self.addButton setBackgroundColor:COR29];
    self.addButton.hidden = YES;
    [self.planDetailView clickBottomTableViewCellBloakFunc:^(NSInteger index) {
        switch (index) {
            case 0: ///点击了出借记录
                [weakSelf clickLoanRecord];
                break;
            case 1://服务协议
                [weakSelf clickNegotiate];
                break;
        }
    }];
    
    self.planDetailView.tipClickBlock = ^{
        HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"按月提取收益" Massage:@"收益会按月返回到账户内，如当月无此提取日，则当月最后一天为收益提取日。" force:2 andLeftButtonMassage:nil andRightButtonMassage:@"确定"];
        alertVC.isHIddenLeftBtn = YES;
        alertVC.isCenterShow = YES;
        [weakSelf presentViewController:alertVC animated:YES completion:nil];
    };
    self.planDetailView.tipNoviceClickBlock = ^{
        HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"温馨提示" Massage:[NSString stringWithFormat:@"计划按照%.1lf%%计息，加息收益%.2lf元将在计划退出时发放至您的账户",weakSelf.planViewModel.planModelDataList.expectedRate.floatValue,weakSelf.planViewModel.planModelDataList.expectedSubsidyInterestAmount.floatValue] force:2 andLeftButtonMassage:nil andRightButtonMassage:@"确定"];
        alertVC.isHIddenLeftBtn = YES;
        alertVC.isCenterShow = YES;
        [weakSelf presentViewController:alertVC animated:YES completion:nil];
    };
    
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.buttonDescLabel];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakSelf.view);
        make.height.equalTo(@(kScrAdaptationH(50)));
        make.bottom.equalTo(weakSelf.view).offset(-HXBBottomAdditionHeight);
    }];
    [self.buttonDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(kScrAdaptationW(15));
        make.right.equalTo(weakSelf.view).offset(kScrAdaptationW(-15));
        make.bottom.equalTo(weakSelf.view).offset(-HXBBottomAdditionHeight - kScrAdaptationH(50) - kScrAdaptationH(8));
    }];
    
}
//服务协议
- (void)clickNegotiate {
    NSString *url = kHXB_Negotiate_ServePlan_AccountURL(self.viewModel.planDetailsViewModel.planDetailModel.ID);
    if (self.viewModel.planDetailsViewModel.isMonthyPayment) {
        url = kHXB_Negotiate_ServeMonthPlan_AccountURL(self.viewModel.planDetailsViewModel.planDetailModel.ID);
    }
    [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:url] fromController:self];
}

//投资记录
- (void)clickLoanRecord {
    HXBMY_Plan_Capital_ViewController *capitalVC = [[HXBMY_Plan_Capital_ViewController alloc]init];
    capitalVC.planID = self.planViewModel.planModelDataList.ID;
    capitalVC.type = HXBInvestmentRecord;
    capitalVC.investmentType = self.type;
    [self.navigationController pushViewController:capitalVC animated:YES];
}

// 点击按钮
- (void)clickAddButton {
    if ([self.viewModel.planDetailsViewModel.quitStatus isEqualToString:QUIT] || self.viewModel.planDetailsViewModel.planDetailModel.inCoolingOffPeriod) {
        
        HXBMYPlanListDetailsExitViewController *planBuyVC = [[HXBMYPlanListDetailsExitViewController alloc] init];
        planBuyVC.planID = self.viewModel.planDetailsViewModel.planDetailModel.ID;
        planBuyVC.mobile = self.viewModel.userInfoModel.userInfoModel.userInfo.mobile;
        planBuyVC.inCoolingOffPeriod = self.viewModel.planDetailsViewModel.planDetailModel.inCoolingOffPeriod;
        // 冷静期 点击取消加入 先获取数据传下一页
        if (self.viewModel.planDetailsViewModel.planDetailModel.inCoolingOffPeriod) {
            kWeakSelf
            [self.viewModel loadPlanListDetailsCancelExitInfoWithPlanID:self.viewModel.planDetailsViewModel.planDetailModel.ID  resultBlock:^(BOOL isSuccess) {
                if (isSuccess) {
                    planBuyVC.myPlanDetailsExitModel = weakSelf.viewModel.myPlanDetailsExitModel;
                    [weakSelf.navigationController pushViewController:planBuyVC animated:YES];
                }
            }];
        } else if ([self.viewModel.planDetailsViewModel.quitStatus isEqualToString:QUIT]) {
            planBuyVC.myPlanDetailsExitModel = nil;
            [self.navigationController pushViewController:planBuyVC animated:YES];
        }
    } else if ([self.viewModel.planDetailsViewModel.quitStatus isEqualToString:ANNUL_QUIT]) {
        [self annulQuit];
    }
    
}

// 撤销退出
- (void)annulQuit {
    kWeakSelf
    HXBGeneralAlertVC *alertVC = [[HXBGeneralAlertVC alloc] initWithMessageTitle:@"您是否撤销退出" andSubTitle:@"您撤销退出，撤销后依然继续享有收益。" andLeftBtnName:@"继续退出" andRightBtnName:@"继续持有" isHideCancelBtn:YES isClickedBackgroundDiss:NO];
    alertVC.isCenterShow = NO;
    [alertVC setRightBtnBlock:^{
        [weakSelf.viewModel accountPlanQuitRequestWithPlanID:weakSelf.planViewModel.planModelDataList.ID resultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                [weakSelf downData];
            }
        }];
    }];
    [self presentViewController:alertVC animated:NO completion:nil];
}

#pragma mark - 网络数据的请求
- (void)downData {
    kWeakSelf
    NSString *planID = self.planViewModel.planModelDataList.ID;
    [self.viewModel accountPlanListDetailsRequestWithPlanID:planID resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            
            [weakSelf dispatchValueWithDetailViewModel:weakSelf.viewModel.planDetailsViewModel];
        } else {
            weakSelf.tabelView.hidden = NO;
            weakSelf.addButton.hidden = weakSelf.buttonDescLabel.hidden = YES;
        }
    }];
}

- (void)dispatchValueWithDetailViewModel: (HXBMYViewModel_PlanDetailViewModel *)viewModel {
    kWeakSelf
    
    NSString *buttonTitle = viewModel.planDetailModel.inCoolingOffPeriod ? @"取消加入" : viewModel.quitStatus;
    NSString *buttonLabelText = viewModel.planDetailModel.inCoolingOffPeriod ? viewModel.planDetailModel.cancelBuyDesc : viewModel.quitSubTitle;
    [self.addButton setTitle:buttonTitle forState:(UIControlStateNormal)];
    self.buttonDescLabel.text = buttonLabelText;
    
    [self.planDetailView setUPValueWithViewManagerBlock:^HXBMY_PlanDetailView_Manager *(HXBMY_PlanDetailView_Manager *manager) {
        
        manager.topViewMassgeManager.rightLabelStr = @"已获收益（元）";
        manager.topViewMassgeManager.leftLabelStr = viewModel.earnAmount;
        
        manager.type = weakSelf.type;
        manager.planDetailModel = viewModel.planDetailModel;
        
        ///判断到底是哪种
        [weakSelf judgementStatusWithStauts: viewModel.statusInt andManager:manager andHXBMYViewModel_PlanDetailViewModel:viewModel];

        manager.typeViewManager.leftStrArray = @[@"收益处理方式"];
        
        manager.typeViewManager.rightStrArray = @[viewModel.planDetailModel.incomeApproach ?: @""];
        
        if (viewModel.isMonthyPayment) {
            manager.monthlyPamentViewManager.leftStrArray = @[@"收益提取日"];
            manager.monthlyPamentViewManager.rightStrArray = @[viewModel.planDetailModel.interestDate ?: @""];
        }
   
        manager.strArray = @[@"出借记录", @"红利计划服务协议"];
        return manager;
    }];
    weakSelf.tabelView.hidden = NO;
}

- (UITableView *)tabelView {
    if (!_tabelView) {
        _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight - HXBTabbarSafeBottomMargin) style:UITableViewStylePlain];
        [self.view insertSubview:_tabelView atIndex:0];
        _tabelView.hidden = YES;
        _tabelView.tableHeaderView = [[UIView alloc] init];
        _tabelView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_tabelView];
    }
    return _tabelView;
}

- (void)judgementStatusWithStauts: (NSInteger)status andManager: (HXBMY_PlanDetailView_Manager *)manager andHXBMYViewModel_PlanDetailViewModel: (HXBMYViewModel_PlanDetailViewModel *)viewModel {
    /**
     statusInt
     1: 表示等待计息
     2: 表示受益中
     3: 表示退出中
     4: 表示已退出
     */
    switch (status) {
            //表示等待计息
        case 1:
            self.planDetailView.cake = 4;
            self.cake = 4;
            manager.infoViewManager.leftStrArray = @[
                                                     @"加入金额",
                                                     @"平均历史年化收益",
                                                     @"锁定期",
                                                     @"加入日期"
                                                     ];
            manager.infoViewManager.rightStrArray = @[
                                                      viewModel.addAuomt,
                                                      viewModel.expectedRate,
                                                      viewModel.lockTime,
                                                      viewModel.addTime
                                                      ];
            manager.typeImageName = @"zhaiquanpipei";
            self.addButton.hidden = YES;
            self.buttonDescLabel.hidden = YES;
            break;
            //2: 表示持有中
        case 10:
        case 11:
        case 12:
            self.planDetailView.cake = 5;
            self.cake = 5;
            manager.infoViewManager.leftStrArray = @[
                                                     @"加入金额",
                                                     @"平均历史年化收益",
                                                     @"锁定期",
                                                     @"加入日期",
                                                     @"锁定期结束日"
                                                     ];
            manager.infoViewManager.rightStrArray = @[
                                                      viewModel.addAuomt,
                                                      viewModel.expectedRate,
                                                      viewModel.lockTime,
                                                      viewModel.addTime,
                                                      viewModel.endLockingTime
                                                      ];
            manager.typeImageName = viewModel.statusImageName;
            self.addButton.hidden = !([viewModel.quitStatus isEqualToString:@"可退出"] || [viewModel.quitStatus isEqualToString:@"撤销退出"] || viewModel.planDetailModel.inCoolingOffPeriod);
            self.buttonDescLabel.hidden = self.addButton.hidden;
            manager.topViewStatusStr = viewModel.leaveStatus;
            break;
            //3: 表示退出中
        case 3:
            self.planDetailView.cake = 5;
            self.cake = 5;
            manager.infoViewManager.leftStrArray = @[
                                                     @"加入金额",
                                                     @"平均历史年化收益",
                                                     @"锁定期",
                                                     @"加入日期",
                                                     @"待转出金额"
                                                     ];
            manager.infoViewManager.rightStrArray = @[
                                                      viewModel.addAuomt,
                                                      viewModel.expectedRate,
                                                      viewModel.lockTime,
                                                      viewModel.addTime,
                                                      viewModel.redProgressLeft
                                                      ];
            manager.typeImageName = @"tuichu";
            self.addButton.hidden = YES;
            self.buttonDescLabel.hidden = YES;
            manager.topViewStatusStr = viewModel.planDetailModel.exitWay;
            break;
            //4: 表示已退出
        case 4:
            self.planDetailView.cake = 4;
            self.cake = 4;
            manager.infoViewManager.leftStrArray = @[
                                                     @"加入金额",
                                                     @"平均历史年化收益",
                                                     @"锁定期",
                                                     @"实际退出日期"
                                                     ];
            manager.infoViewManager.rightStrArray = @[
                                                      viewModel.addAuomt,
                                                      viewModel.expectedRate,
                                                      viewModel.lockTime,
                                                      viewModel.endLockingTime
                                                      ];
            manager.typeImageName = @"tuichu";
            self.addButton.hidden = YES;
            self.buttonDescLabel.hidden = YES;
            manager.topViewStatusStr = viewModel.planDetailModel.exitWay;
            break;
        default:
            break;
            
    }
    self.tabelView.tableHeaderView = nil;
    self.planDetailView.height = kScrAdaptationH(447) + self.cake * kScrAdaptationH(37.5);
    self.tabelView.tableHeaderView = self.planDetailView;
    
    NSString *buttonLabelText = viewModel.planDetailModel.inCoolingOffPeriod ? viewModel.planDetailModel.cancelBuyDesc : viewModel.quitSubTitle;
    CGFloat height = [buttonLabelText boundingRectWithSize:CGSizeMake(kScreenWidth - kScrAdaptationW(30), 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: self.buttonDescLabel.font} context:nil].size.height;
    
    if (self.addButton.hidden) {
        self.tabelView.frame = CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight - HXBTabbarSafeBottomMargin);
    } else {
        self.tabelView.frame = CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight - kScrAdaptationH(66) - height - HXBTabbarSafeBottomMargin);
    }
}


- (void)dealloc {
    NSLog(@"✅被销毁 %@",self);
}

@end

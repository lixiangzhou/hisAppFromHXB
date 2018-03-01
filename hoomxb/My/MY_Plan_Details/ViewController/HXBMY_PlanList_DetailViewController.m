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
#import "HXBFin_Plan_BuyViewController.h"//购买的planvc
#import "HXBFinDetailViewModel_PlanDetail.h"//viewMode 购买
#import "HXBFinDetailModel_PlanDetail.h"//model 购买
#import "HXBMYViewModel_MianPlanViewModel.h"
#import "HXBMY_Plan_Capital_ViewController.h"//投资记录
#import "HXBMyPlanDetailsViewModel.h"

@interface HXBMY_PlanList_DetailViewController ()
@property (nonatomic,weak) HXBMY_PlanDetailView *planDetailView;
@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);
@property (nonatomic, strong) HXBMyPlanDetailsViewModel *viewModel;
@end

@implementation HXBMY_PlanList_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isColourGradientNavigationBar = YES;
    [self setUP];
    kWeakSelf
    _viewModel = [[HXBMyPlanDetailsViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    self.title = self.planViewModel.planModelDataList.name;
    [self downData];
}

- (void) setUP {
    kWeakSelf
    int cake = 4;
    if (self.isLeave) {
        cake = 5;
    }

    HXBMY_PlanDetailView *planDetailView = [[HXBMY_PlanDetailView alloc]initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight) andInfoHaveCake:cake];
    self.planDetailView = planDetailView;
    //tableView 的点击
    [self.planDetailView clickBottomTableViewCellBloakFunc:^(NSInteger index) {
        switch (index) {
            case 0: ///点击了投资记录button
                [weakSelf clickLoanRecord];
                break;
            case 1://服务协议
                [weakSelf clickNegotiate];
                break;
        }
    }];
    
    self.planDetailView.tipClickBlock = ^{
        HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:@"按月付息" Massage:@"购买该计划产品的用户，收益将会按当月时间返回到账内即可提取，如当月无此付息日，则统一为当月最后一天为该月付息日。" force:2 andLeftButtonMassage:nil andRightButtonMassage:@"确定"];
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
    ///点击了立即加入button
    [self.planDetailView clickAddButtonWithBlock:^(UIButton *button) {
        [weakSelf clickAddButton];
    }];
    [weakSelf.hxbBaseVCScrollView addSubview:planDetailView];
}
//服务协议
- (void)clickNegotiate {
    NSLog(@"点击了服务协议%@",self);
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
//加入按钮
- (void)clickAddButton {
    if (!KeyChain.isLogin) {
         [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
        return;
    }
    
    /*
     PlanDetailModel planDetailModel = new PlanDetailModel();
     planDetailModel.setId(privatePlanDetailModel.getId());//计划id
     planDetailModel.setRegisterMultipleAmount(privatePlanDetailModel.getRegisterMultipleAmount());//注册递增
     planDetailModel.setUserRemainAmount(privatePlanDetailModel.getUserRemainAmount());//用户剩余
     planDetailModel.setRemainAmount(privatePlanDetailModel.getRemainAmount());//计划剩余
     planDetailModel.setTotalInterest(privatePlanDetailModel.getTotalInterest());//收益率
     planDetailModel.setDiffTime((long) 0);//倒计时 由于
     planDetailModel.setIsFirst("0");//倒计时 由于
     */
    kWeakSelf
    HXBFin_Plan_BuyViewController *planBuyVC = [[HXBFin_Plan_BuyViewController alloc]init];
    //获取计划信息
    HXBFinDetailViewModel_PlanDetail *BuyPlanDetailViewModel = [[HXBFinDetailViewModel_PlanDetail alloc]init];
    BuyPlanDetailViewModel.planDetailModel = [[HXBFinDetailModel_PlanDetail alloc]init];
    ///加入条件加入金额%@元起，%@元的整数倍递增
    BuyPlanDetailViewModel.addCondition = [NSString stringWithFormat:@"%@元的整数倍递增",[NSString hxb_getPerMilWithDoubleNum:weakSelf.viewModel.planDetailsViewModel.planDetailModel.registerMultipleAmount.doubleValue]];
    ///余额 title
    ///收益方法
    BuyPlanDetailViewModel.profitType_UI = weakSelf.planViewModel.profitType_UI;
    ///待转金额
    BuyPlanDetailViewModel.remainAmount = weakSelf.viewModel.planDetailsViewModel.planDetailModel.remainAmount;
    ///服务协议 button str
    BuyPlanDetailViewModel.contractName = weakSelf.viewModel.planDetailsViewModel.contractName;
    BuyPlanDetailViewModel.totalInterest = weakSelf.planViewModel.totalInterest;
    BuyPlanDetailViewModel.minRegisterAmount = weakSelf.viewModel.planDetailsViewModel.planDetailModel.registerMultipleAmount;
    ///用户可用余额
    BuyPlanDetailViewModel.planDetailModel.userRemainAmount = weakSelf.viewModel.planDetailsViewModel.planDetailModel.userRemainAmount;
    ///计划余额
    BuyPlanDetailViewModel.planDetailModel.remainAmount = weakSelf.viewModel.planDetailsViewModel.planDetailModel.remainAmount;
    //递增金额
    BuyPlanDetailViewModel.planDetailModel.registerMultipleAmount = weakSelf.viewModel.planDetailsViewModel.planDetailModel.registerMultipleAmount;
    planBuyVC.planViewModel = BuyPlanDetailViewModel;
    planBuyVC.ID = weakSelf.viewModel.planDetailsViewModel.planDetailModel.ID.integerValue;
    planBuyVC.planViewModel.ID = weakSelf.viewModel.planDetailsViewModel.planDetailModel.ID;
    

    
    [planBuyVC clickLookMYInfoButtonWithBlock:^{
        __block UIViewController *vc = nil;
        [weakSelf.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"HXBMY_PlanListViewController")]) {
                vc = obj;
                *stop = YES;
            }
        }];
        [weakSelf.navigationController popToViewController:vc animated:YES];
//        [[NSNotificationCenter defaultCenter]postNotificationName:kHXBNotification_ShowMYVC_PlanList object:nil];
    }];
    [weakSelf.navigationController pushViewController:planBuyVC animated:YES];

}

#pragma mark - 网络数据的请求
- (void)downData {
    kWeakSelf
    NSString *planID = self.planViewModel.planModelDataList.ID;
    [self.viewModel accountPlanListDetailsRequestWithPlanID:planID resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf dispatchValueWithDetailViewModel:weakSelf.viewModel.planDetailsViewModel];
        }
    }];
}

- (void)dispatchValueWithDetailViewModel: (HXBMYViewModel_PlanDetailViewModel *)viewModel {
    kWeakSelf
    [self.planDetailView setUPValueWithViewManagerBlock:^HXBMY_PlanDetailView_Manager *(HXBMY_PlanDetailView_Manager *manager) {
        manager.topViewStatusStr = viewModel.status;
        manager.topViewMassgeManager.rightLabelStr = @"已获收益（元）";
        manager.topViewMassgeManager.leftLabelStr = viewModel.earnAmount;
        manager.type = weakSelf.type;
        manager.planDetailModel = viewModel.planDetailModel;
        ///判断到底是哪种
        [weakSelf judgementStatusWithStauts: viewModel.statusInt andManager:manager andHXBMYViewModel_PlanDetailViewModel:viewModel];

        manager.typeViewManager.leftStrArray = @[@"收益处理方式"];
        
        manager.typeViewManager.rightStrArray = @[viewModel.planDetailModel.incomeApproach ?: @""];
        
        if (viewModel.isMonthyPayment) {
            manager.monthlyPamentViewManager.leftStrArray = @[@"付息日"];
            manager.monthlyPamentViewManager.rightStrArray = @[viewModel.planDetailModel.interestDate ?: @""];
        }
   
        manager.strArray = @[@"投资记录", @"红利计划服务协议"];
        
        manager.isHiddenAddButton = viewModel.isAddButtonHidden;
        return manager;
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

- (void)judgementStatusWithStauts: (NSInteger)status andManager: (HXBMY_PlanDetailView_Manager *)manager andHXBMYViewModel_PlanDetailViewModel: (HXBMYViewModel_PlanDetailViewModel *)viewModel{
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
            manager.infoViewManager.leftStrArray = @[
                                                     @"加入金额",
                                                     @"平均历史年化收益",
                                                     @"期限",
                                                     @"加入日期",
                                                     ];
            manager.infoViewManager.rightStrArray = @[
                                                      viewModel.addAuomt,
                                                      viewModel.expectedRate,
                                                      viewModel.lockTime,
                                                      viewModel.addTime
                                                      ];
            manager.typeImageName = @"zhaiquanpipei";
            break;
            //2: 表示受益中
        case 2:
            manager.infoViewManager.leftStrArray = @[
                                                     @"加入金额",
                                                     @"平均历史年化收益",
                                                     @"期限",
                                                     @"加入日期",
                                                     ];
            manager.infoViewManager.rightStrArray = @[
                                                      viewModel.addAuomt,
                                                      viewModel.expectedRate,
                                                      viewModel.lockTime,
                                                      viewModel.addTime
                                                      ];
            manager.typeImageName = @"jutuichu";
            break;
            //3: 表示退出中
        case 3:
            manager.infoViewManager.leftStrArray = @[
                                                     @"加入金额",
                                                     @"平均历史年化收益",
                                                     @"期限",
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
            break;
            //4: 表示已退出
        case 4:
            manager.infoViewManager.leftStrArray = @[
                                                     @"加入金额",
                                                     @"平均历史年化收益",
                                                     @"期限",
                                                     @"实际退出日期"
                                                     ];
            manager.infoViewManager.rightStrArray = @[
                                                      viewModel.addAuomt,
                                                      viewModel.expectedRate,
                                                      viewModel.lockTime,
                                                      viewModel.endLockingTime
                                                      ];
            manager.typeImageName = @"tuichu";
            break;
        default:
            break;
    }
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

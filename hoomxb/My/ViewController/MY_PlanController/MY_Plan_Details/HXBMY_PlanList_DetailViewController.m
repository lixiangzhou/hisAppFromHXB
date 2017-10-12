//
//  HXBMY_PlanList_DetailViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanList_DetailViewController.h"

#import "HXBMYReqest_DetailRequest.h"//请求的工具类

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
#import "HXBFinContract_contraceWebViewVC_Loan.h"
@interface HXBMY_PlanList_DetailViewController ()
@property (nonatomic,strong) HXBMYReqest_DetailRequest *detailRequest;
@property (nonatomic,weak) HXBMY_PlanDetailView *planDetailView;
@property (nonatomic,strong)HXBMYViewModel_PlanDetailViewModel *viewModel;
@end

@implementation HXBMY_PlanList_DetailViewController
#pragma mark - getter 
- (HXBMYReqest_DetailRequest *)detailRequest {
    if (!_detailRequest) {
        _detailRequest = [[HXBMYReqest_DetailRequest alloc]init];
    }
    return _detailRequest;
}

//- (void)setPlanViewModel:(HXBMYViewModel_MianPlanViewModel *)planViewModel {
//    _planViewModel = planViewModel;
//    [self downData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    self.isColourGradientNavigationBar = true;
    [self setUP];
    self.title = self.planViewModel.planModelDataList.name;
    [self downData];
}

- (void) setUP {
    kWeakSelf
    int cake = 4;
    if (self.isLeave) {
        cake = 5;
    }

    HXBMY_PlanDetailView *planDetailView = [[HXBMY_PlanDetailView alloc]initWithFrame:kVCViewFrame_64 andInfoHaveCake:cake];
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

    ///点击了立即加入button
    [self.planDetailView clickAddButtonWithBlock:^(UIButton *button) {
        [weakSelf clickAddButton];
    }];
    [weakSelf.hxbBaseVCScrollView addSubview:planDetailView];
}
//服务协议
- (void)clickNegotiate {
    NSLog(@"点击了服务协议%@",self);
    HXBFinContract_contraceWebViewVC_Loan *vc = [[HXBFinContract_contraceWebViewVC_Loan alloc]init];
    [self.navigationController pushViewController:vc animated:true];
    vc.URL = kHXB_Negotiate_ServePlan_AccountURL(self.viewModel.planDetailModel.ID);
    vc.title = @"红利计划服务协议";
}
//投资记录
- (void)clickLoanRecord {
    HXBMY_Plan_Capital_ViewController *capitalVC = [[HXBMY_Plan_Capital_ViewController alloc]init];
    capitalVC.planID = self.planViewModel.planModelDataList.ID;
    capitalVC.type = HXBInvestmentRecord;
    [self.navigationController pushViewController:capitalVC animated:true];
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
    BuyPlanDetailViewModel.addCondition = [NSString stringWithFormat:@"%@元的整数倍递增",[NSString hxb_getPerMilWithDoubleNum:weakSelf.viewModel.planDetailModel.registerMultipleAmount.doubleValue]];
    ///余额 title
    ///收益方法
    BuyPlanDetailViewModel.profitType_UI = weakSelf.planViewModel.profitType_UI;
    ///待转金额
    BuyPlanDetailViewModel.remainAmount = weakSelf.viewModel.planDetailModel.remainAmount;
    ///服务协议 button str
    BuyPlanDetailViewModel.contractName = weakSelf.viewModel.contractName;
    BuyPlanDetailViewModel.totalInterest = weakSelf.planViewModel.totalInterest;
    BuyPlanDetailViewModel.minRegisterAmount = weakSelf.viewModel.planDetailModel.registerMultipleAmount;
    ///用户可用余额
    BuyPlanDetailViewModel.planDetailModel.userRemainAmount = weakSelf.viewModel.planDetailModel.userRemainAmount;
    ///计划余额
    BuyPlanDetailViewModel.planDetailModel.remainAmount = weakSelf.viewModel.planDetailModel.remainAmount;
    //递增金额
    BuyPlanDetailViewModel.planDetailModel.registerMultipleAmount = weakSelf.viewModel.planDetailModel.registerMultipleAmount;
    planBuyVC.planViewModel = BuyPlanDetailViewModel;
    planBuyVC.ID = weakSelf.viewModel.planDetailModel.ID.integerValue;
    planBuyVC.planViewModel.ID = weakSelf.viewModel.planDetailModel.ID;
    

    
    [planBuyVC clickLookMYInfoButtonWithBlock:^{
        __block UIViewController *vc = nil;
        [weakSelf.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"HXBMY_PlanListViewController")]) {
                vc = obj;
                *stop = true;
            }
        }];
        [weakSelf.navigationController popToViewController:vc animated:true];
//        [[NSNotificationCenter defaultCenter]postNotificationName:kHXBNotification_ShowMYVC_PlanList object:nil];
    }];
    [weakSelf.navigationController pushViewController:planBuyVC animated:true];

}

#pragma mark - 网络数据的请求
- (void)downData {
    __weak typeof (self)weakSelf = self;
    NSString *planID = self.planViewModel.planModelDataList.ID;
    [self.detailRequest planListDetails_requestWithFinancePlanID:planID andSuccessBlock:^(HXBMYViewModel_PlanDetailViewModel *viewModel) {
        [weakSelf dispatchValueWithDetailViewModel:viewModel];
    } andFailureBlock:^(NSError *error) {
    }];
}

- (void)dispatchValueWithDetailViewModel: (HXBMYViewModel_PlanDetailViewModel *)viewModel {
    self.viewModel = viewModel;
    kWeakSelf
    [self.planDetailView setUPValueWithViewManagerBlock:^HXBMY_PlanDetailView_Manager *(HXBMY_PlanDetailView_Manager *manager) {
        manager.topViewStatusStr = viewModel.status;
        manager.topViewMassgeManager.rightLabelStr = @"已获收益（元）";
        manager.topViewMassgeManager.leftLabelStr = viewModel.earnAmount;
        
        ///判断到底是哪种
        [weakSelf judgementStatusWithStauts: viewModel.statusInt andManager:manager andHXBMYViewModel_PlanDetailViewModel:viewModel];

        manager.typeViewManager.leftStrArray = @[
                                                 @"收益处理方式"
                                                 ];
        manager.typeViewManager.rightStrArray = @[viewModel.cashType];
   


        manager.strArray = @[
                             @"投资记录",
                             @"红利计划服务协议"
                             ];
        manager.isHiddenAddButton = viewModel.isAddButtonHidden;
        return manager;
    }];
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
                                                     @"实际退出日期",
                                                     @"期限",
                                                     ];
            manager.infoViewManager.rightStrArray = @[
                                                      viewModel.addAuomt,
                                                      viewModel.expectedRate,
                                                      viewModel.endLockingTime,
                                                      viewModel.lockTime
                                                      ];
            manager.typeImageName = @"tuichu";
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

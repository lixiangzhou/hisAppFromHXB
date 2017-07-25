//
//  HXBPlan_JoinImmediatelyViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Plan_BuyViewController.h"
#import "HXBJoinImmediateView.h"
#import "HXBFinModel_Buy_Plan.h"
#import "HXBFinanctingRequest.h"
#import "HXBFinDetailViewModel_PlanDetail.h"
#import "HXBFinDetailModel_PlanDetail.h"
#import "HXBFin_Plan_BuyViewModel.h"
#import "HXBFin_Plan_BuySuccessViewController.h"//购买成功
#import "HXBFin_Plan_BugFailViewController.h" //购买失败
@interface HXBFin_Plan_BuyViewController ()
@property (nonatomic,strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@property (nonatomic,strong) HXBJoinImmediateView *joinimmediateView;
@property (nonatomic,copy) void (^clickLookMYInfoButtonBlock)();
@end

@implementation HXBFin_Plan_BuyViewController

- (void)clickLookMYInfoButtonWithBlock: (void(^)())clickLoockMYInfoButton {
    self.clickLookMYInfoButtonBlock = clickLoockMYInfoButton;
}

- (void)setIsPlan:(BOOL)isPlan {
    _isPlan = isPlan;
    self.joinimmediateView.isPlan = isPlan;
}

- (void)viewDidLoad {
    kWeakSelf
    [super viewDidLoad];
    [self.hxbBaseVCScrollView hxb_HeaderWithHeaderRefreshCallBack:^{
        [weakSelf.hxbBaseVCScrollView endRefresh];
    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
    }];
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    self.isColourGradientNavigationBar = true;
    //判断是否登录
    [self isLogin];

    ///UI的搭建
    [self setUPViews];
    
    //传递值
    [self setValue];
    
    //事件的传递
    [self registerEvent];
}

///判断是否登录
- (void)isLogin {
//    if (!KeyChain.isLogin) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
//    }
}

///UI搭建
- (void)setUPViews {
    kWeakSelf
    self.joinimmediateView = [[HXBJoinImmediateView alloc] init];
    [self.hxbBaseVCScrollView addSubview:self.joinimmediateView];
    
    [self trackingScrollViewBlock:^(UIScrollView *scrollView) {
        weakSelf.joinimmediateView.isEndEditing = true;
    }];
    
    self.joinimmediateView.frame = self.view.frame;
}

 - (void) registerEvent {
     __weak typeof(self) weakSelf = self;
     ///点击了充值
     [self.joinimmediateView clickRechargeFunc:^{
         [HxbHUDProgress showTextWithMessage:@"余额不足，请先到官网充值后再进行投资"];
     }];
     ///点击了一键购买
     [self.joinimmediateView clickBuyButtonFunc:^(NSString *capitall, UITextField *textField) {
         ///用户余额，
         CGFloat userInfo_availablePoint = weakSelf.userInfoViewModel.userInfoModel.userAssets.availablePoint.floatValue;
         if (!userInfo_availablePoint) {
             [HxbHUDProgress showTextWithMessage:@"余额不足，请先到官网充值后再进行投资"];
             return;
         }
    
         ///加入上线 (min (用户可投， 本期剩余))
         NSString *str = nil;
         if (weakSelf.planViewModel.planDetailModel.userRemainAmount.floatValue < weakSelf.planViewModel.planDetailModel.remainAmount.floatValue) {
             str = weakSelf.planViewModel.planDetailModel.userRemainAmount;
         }else {
             str = weakSelf.planViewModel.planDetailModel.remainAmount;
         }
         textField.text = [NSString stringWithFormat:@"%.2lf",str.floatValue];
     }];
     ///点击了加入
     [self.joinimmediateView clickAddButtonFunc:^(NSString *capital) {
         // 先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍
         CGFloat minRegisterAmount = weakSelf.planViewModel.minRegisterAmount.floatValue;
         if ((capital.floatValue < minRegisterAmount)) {
             NSLog(@"请输入大于等于1000");
             [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"起投金额%.2lf元",minRegisterAmount]];
             return;
         }
         
         NSInteger minRegisterAmountInteger = minRegisterAmount;
         if ((capital.integerValue % minRegisterAmountInteger) != 0) {
             NSLog(@"1000的整数倍");
             NSString *message = [NSString stringWithFormat:@"投资金额应为%ld的整数倍",(long)minRegisterAmountInteger];
             [HxbHUDProgress showTextWithMessage:message];
             return;
         }
         ///查看是否大于上线
         NSString *str = nil;
         if (weakSelf.planViewModel.planDetailModel.userRemainAmount.floatValue < weakSelf.planViewModel.planDetailModel.remainAmount.floatValue) {
             str = weakSelf.planViewModel.planDetailModel.userRemainAmount;
         }else {
             str = weakSelf.planViewModel.planDetailModel.remainAmount;
         }
         /// 加入上线  为0
         if (!str.floatValue) {
             [HxbHUDProgress showTextWithMessage:@"提示信息为加入金额已达上限" andView:self.view];
         }
         
         //判断是否安全认证
         kWeakSelf
         [[KeyChainManage sharedInstance] isVerifyWithBlock:^(NSString *isVerify) {
             if (!isVerify) {
                 [HxbHUDProgress showTextWithMessage:@"去安全认证"];
             } else {
                 [[HXBFinanctingRequest sharedFinanctingRequest] plan_buyReslutWithPlanID:weakSelf.planViewModel.ID andAmount:capital cashType:self.planViewModel.profitType andSuccessBlock:^(HXBFin_Plan_BuyViewModel *model) {
                     ///加入成功
                     HXBFBase_BuyResult_VC *planBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
                     planBuySuccessVC.imageName = @"successful";
                     planBuySuccessVC.buy_title = @"加入成功";
                     planBuySuccessVC.buy_description = model.lockStart;
                     planBuySuccessVC.buy_ButtonTitle = @"查看我的投资";
                     planBuySuccessVC.title = @"投资成功";
                     [planBuySuccessVC clickButtonWithBlock:^{
                         [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
                         [self.navigationController popToRootViewControllerAnimated:true];
                     }];
                     
                     [self.navigationController pushViewController:planBuySuccessVC animated:true];
// [self.navigationController popToRootViewControllerAnimated:true];
                 } andFailureBlock:^(NSError *error, NSInteger status) {
                     
                     HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc]init];
                     failViewController.title = @"投资结果";
                     switch (status) {
                         case 3408:
                             failViewController.imageName = @"yuebuzu";
                             failViewController.buy_title = @"可用余额不足，请重新购买";
                             failViewController.buy_ButtonTitle = @"重新投资";
                             break;
                         case 3100:
                             failViewController.imageName = @"shouqin";
                             failViewController.buy_title = @"手慢了，已售罄";
                             failViewController.buy_ButtonTitle = @"重新投资";
                             break;
                         default:
                             failViewController.imageName = @"failure";
                             failViewController.buy_title = @"加入失败";
                             failViewController.buy_ButtonTitle = @"重新投资";
                     }
                     [failViewController clickButtonWithBlock:^{
                         [self.navigationController popToRootViewControllerAnimated:true];  //跳回理财页面
                     }];
                     [weakSelf.navigationController pushViewController:failViewController animated:true];
                 }];
             }
         }];
     }];
     //点击了 服务协议
     [self.joinimmediateView clickNegotiateButtonFunc:^{
         
     }];
}

- (void)setValue {
    [self setUPModel];
    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.userInfoViewModel = viewModel;
        [self setUPModel];
        } andFailure:^(NSError *error) {
    }];
}
///赋值
- (void) setUPModel {
    kWeakSelf
    [self.joinimmediateView setUPValueWithModelBlock:^HXBJoinImmediateView_Model *(HXBJoinImmediateView_Model *model) {
        ///预计收益Const
        model.profitLabel_consttStr = @"预期收益";
        ///服务协议
        model.negotiateLabelStr = @"我已阅读并同意";
        ///余额 title
        model.balanceLabel_constStr = @"可用余额";
        ///充值的button str
        model.rechargeButtonStr = @"充值";
        ///一键购买的str
        model.buyButtonStr = @"一键购买";
        ///收益方式
        model.profitTypeLable_ConstStr = @"收益处理方式";
        ///加入上限
        model.upperLimitLabel_constStr = @"本期计划加入上限";
        ///余额 title
        model.balanceLabelStr = [NSString hxb_getPerMilWithDouble:weakSelf.userInfoViewModel.userInfoModel.userAssets.availablePoint.floatValue];
        ///收益方法
        model.profitTypeLabelStr = weakSelf.planViewModel.profitType_UI;
        /// ￥1000起投，1000递增 placeholder
        model.rechargeViewTextField_placeholderStr = weakSelf.planViewModel.addCondition;
        
        ///服务协议 button str
        model.negotiateButtonStr = weakSelf.planViewModel.contractName;
        model.totalInterest = weakSelf.planViewModel.totalInterest;
        
        ///加入上线 (min (用户可投， 本期剩余))
        if (weakSelf.planViewModel.planDetailModel.userRemainAmount.floatValue < weakSelf.planViewModel.planDetailModel.remainAmount.floatValue) {
            model.upperLimitLabelStr = weakSelf.planViewModel.planDetailModel.userRemainAmount;
        }else {
             model.upperLimitLabelStr = weakSelf.planViewModel.planDetailModel.remainAmount;
        }
        
        ///确认加入的Buttonstr
        model.addButtonStr = @"确认加入";
        return model;
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

//
//  HXBFin_LoanTruansfer_BuyViewController.m
//  hoomxb
//
//  Created by HXB on 2017/7/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanTruansfer_BuyViewController.h"

#import "HXBFin_Loan_BuyViewController.h"
#import "HXBFin_JoinimmediateView_Loan.h"
#import "HXBFinanctingRequest.h"
#import "HXBJoinImmediateView.h"
#import "HXBRechargeView.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
#import "HXBFinDatailModel_LoanDetail.h"
#import "HXBFinModel_Buy_Plan.h"
#import "HXBFinModel_BuyResoult_PlanModel.h"
#import "HXBFinModel_Buy_LoanModel.h"
#import "HXBFinModel_BuyResoult_LoanModel.h"
#import "HXBFinDatailModel_LoanDetail.h"
#import "HXBFin_Plan_BugFailViewController.h"
#import "HXBFin_Plan_BuySuccessViewController.h"
#import "HXBFinDetailModel_LoanTruansferDetail.h"
#import "HXBFinDetailViewModel_LoanTruansferDetail.h"
#import "HXBFin_LoanTruansfer_BuyResoutViewModel.h"
#import "hxbMyTopUpViewController.h"//充值
@interface HXBFin_LoanTruansfer_BuyViewController ()
@property (nonatomic,strong) HXBFin_JoinimmediateView_Loan *joinimmediateView_Loan;
///个人总资产
@property (nonatomic,copy) NSString *assetsTotal;

//可用余额
@end

@implementation HXBFin_LoanTruansfer_BuyViewController

- (void) setLoanTruansferViewModel:(HXBFinDetailViewModel_LoanTruansferDetail *)loanTruansferViewModel {
    _loanTruansferViewModel = loanTruansferViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf
    [self.hxbBaseVCScrollView hxb_HeaderWithHeaderRefreshCallBack:^{
        [weakSelf.hxbBaseVCScrollView endRefresh];
    } andSetUpGifHeaderBlock:^(MJRefreshNormalHeader *header) {
    }];
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    self.isColourGradientNavigationBar = true;
    
    
    //请求 个人数据
    [[KeyChainManage sharedInstance] downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        _availablePoint = viewModel.userInfoModel.userAssets.availablePoint;
        _assetsTotal = viewModel.userInfoModel.userAssets.assetsTotal;
    } andFailure:^(NSError *error) {
        
    }];
    
    //判断是否登录
    [self isLogin];
    
    ///UI的搭建
    [self setUPViews];
    
    ///UI传值
    [self setViewValue];
    //事件的传递
    [self registerEvent];
}
///判断是否登录
- (void)isLogin {
    if (!KeyChain.isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
    }
}

///UI搭建
- (void)setUPViews {
    kWeakSelf
    self.joinimmediateView_Loan = [[HXBFin_JoinimmediateView_Loan alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    [self.hxbBaseVCScrollView addSubview:self.joinimmediateView_Loan];
    self.hxb_automaticallyAdjustsScrollViewInsets = true;
    [self trackingScrollViewBlock:^(UIScrollView *scrollView) {
        weakSelf.joinimmediateView_Loan.isEndEditing = true;
    }];
    
    self.joinimmediateView_Loan.frame = self.view.frame;
}

- (void) registerEvent {
    ///点击了充值
    [self registerClickRecharge];
    ///点击了一键购买
    [self registerClickBuyButton];
    ///点击了加入
    [self registerClickAddButton];
    //点击了 服务协议
    [self registerClickNegotiateButton];
}

///点击了充值 直接把 可投金额传过去，充值
- (void)registerClickRecharge {
    [self.joinimmediateView_Loan clickRechargeFunc:^(UITextField *textField) {
//        [HxbHUDProgress showTextWithMessage:@"余额不足，请先到官网充值后再进行投资"];
        NSLog(@"余额不足，请先到官网充值后再进行投资");
        [self pushTopUPViewControllerWithAmount:textField.text];
    }];
}
- (void) pushTopUPViewControllerWithAmount:(NSString *)amount {
        HxbMyTopUpViewController *hxbMyTopUpViewController = [[HxbMyTopUpViewController alloc]init];
        hxbMyTopUpViewController.amount = amount;
        [self.navigationController pushViewController:hxbMyTopUpViewController animated:YES];
}
///点击了一键购买
- (void)registerClickBuyButton {
    kWeakSelf
    [self.joinimmediateView_Loan clickBuyButtonFunc:^(NSString *capitall, UITextField *textField) {
        textField.text = [NSString stringWithFormat:@"%.2lf", weakSelf.loanTruansferViewModel.loanTruansferDetailModel.leftTransAmount.floatValue];
    }];
}

///点击了加入
- (void)registerClickAddButton {
    kWeakSelf
    [self.joinimmediateView_Loan clickAddButtonFunc:^(NSString *capital) {
        //先判断
        [HXBAlertManager checkOutRiskAssessmentWithSuperVC:self andWithPushBlock:^{
            [weakSelf buyWithCapital:capital];
        }];
    }];
}

//购买的逻辑
- (void)buyWithCapital:(NSString *)capital {
    kWeakSelf
    ///债转剩余金额
    CGFloat truansferRemainAmount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.transferDetail.leftTransAmount.floatValue;
    //         先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍
    ///最小投资金额
    CGFloat minRegisterAmount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.minInverst.floatValue;
    ///投资金额的增长基数
    NSInteger instertAmount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.loanVo.finishedRatio.integerValue;
    if ((capital.floatValue < minRegisterAmount && truansferRemainAmount >= minRegisterAmount)) {
        NSLog(@"请输入大于等于1000");
        [HxbHUDProgress showMessageCenter:[NSString stringWithFormat:@"起投金额%.2lf元",minRegisterAmount] inView:self.view];
        return;
    }
    
    if ((capital.integerValue % instertAmount) != 0 && truansferRemainAmount >= minRegisterAmount && capital.floatValue != truansferRemainAmount) {
        NSLog(@"1000的整数倍");
        NSString *message = [NSString stringWithFormat:@"投资金额应为%ld的整数倍",(long)instertAmount];
        [HxbHUDProgress showMessageCenter:message inView:self.view];
        return;
    }
    
    //是否大于用户剩余金额 给个提示，然后跳转到充值界面
    if (capital.floatValue > self.assetsTotal.floatValue) {
        NSLog(@"%@",@"输入金额大于了用户剩余金额");
        NSString *amount = [NSString stringWithFormat:@"%.2lf",(capital.floatValue)];
        ///弹框
        [HxbHUDProgress showMessageCenter:@"余额不足，请先充值" inView:self.view andBlock:^{
            [self pushTopUPViewControllerWithAmount: amount];
        }];
        return;
    }
    //是否大于标的剩余金额
    if (capital.floatValue > truansferRemainAmount) {
        [HxbHUDProgress showMessageCenter:@"输入金额大于了标的剩余金额" inView:self.view];
        return;
    }
    
    //判断 购买后 的债转剩余金额是否小于 起投金额 + 递增金额
    if ((capital.floatValue - truansferRemainAmount) < minRegisterAmount + instertAmount) {
        
    }
    
    //        //判断是否安全认证
    //        [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
    //            if (!viewModel.userInfoModel.userInfo.isAllPassed.integerValue) {
    //                [HxbHUDProgress showMessageCenter:@"去安全认证"inView:self.view];
    //            }else {
    [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansfer_confirmBuyReslutWithLoanID:weakSelf.loanTruansferViewModel.loanTruansferDetailModel.transferId andInvestAmount:capital andSuccessBlock:^(HXBFin_LoanTruansfer_BuyResoutViewModel *model) {
        ///加入成功
        HXBFBase_BuyResult_VC *loanTruansferBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
        [loanTruansferBuySuccessVC clickButtonWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
            [self.navigationController popToRootViewControllerAnimated:true];
        }];
        loanTruansferBuySuccessVC.imageName = @"successful";
        loanTruansferBuySuccessVC.buy_title = @"购买成功";
        loanTruansferBuySuccessVC.massage_Left_StrArray = @[
                                                   @"下一个还款日",
                                                   @"投资金额",
                                                   @"实际买入本金",
                                                   @"公允利息"
                                                   ];
        loanTruansferBuySuccessVC.massage_Right_StrArray = @[
                                                    model.nextRepayDate,
                                                    model.buyAmount,
                                                    model.principal,
                                                    model.interest
                                                    ];
        loanTruansferBuySuccessVC.buy_description = @"公允利息为您垫付的转让人持有天利息，还款人将会在下个还款日予以返回";
        loanTruansferBuySuccessVC.buy_ButtonTitle = @"查看我的投资";
        [self.navigationController pushViewController:loanTruansferBuySuccessVC animated:true];
        
    } andFailureBlock:^(NSError *error, NSDictionary *response) {
        NSInteger status = [response[kResponseStatus] integerValue];
        HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc]init];
        failViewController.buy_title = @"投资结果";
        switch (status) {
            case 3408:
                failViewController.buy_title = @"投资结果";
                failViewController.imageName = @"yuebuzu";
                failViewController.buy_title = @"可用余额不足，请重新购买";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 3100:
                failViewController.buy_title = @"投资成功";
                failViewController.imageName = @"shouqin";
                failViewController.buy_title = @"手慢了，已售罄";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            default:
                failViewController.buy_title = @"投资结果";
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_ButtonTitle = @"重新投资";
        }
        [failViewController clickButtonWithBlock:^{
            [self.navigationController popToRootViewControllerAnimated:true];  //跳回理财页面
        }];
        [weakSelf.navigationController pushViewController:failViewController animated:true];
    }];
    //            }
    //        } andFailure:^(NSError *error) {
    //            [HxbHUDProgress showMessageCenter:@"加入失败" inView:self.view];
    //        }];

}

/// --------------------------- 数据的传递 ----------------------



///点击了 服务协议
- (void)registerClickNegotiateButton {
    [self.joinimmediateView_Loan clickNegotiateButtonFunc:^{
        
    }];
}

- (void)setViewValue {
    [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        kWeakSelf
        [self.joinimmediateView_Loan setUPValueWithModelBlock:^HXBFin_JoinimmediateView_Loan_ViewModel *(HXBFin_JoinimmediateView_Loan_ViewModel *model) {
            ///预计收益ConstprofitLabel_consttStr
            model.JoinImmediateView_Model.profitLabel_consttStr = @"预期收益";
            ///服务协议
            model.JoinImmediateView_Model.negotiateLabelStr = @"我已阅读并同意";
            ///余额 title
            model.remainAmountLabel_ConstStr = @"散标剩余金额：";
            ///充值的button str
            model.JoinImmediateView_Model.rechargeButtonStr = @"充值";
            model.JoinImmediateView_Model.balanceLabel_constStr = @"可用余额";
            model.remainAmountLabelStr = weakSelf.loanTruansferViewModel.leftTransAmount;
            ///一键购买的str
            model.JoinImmediateView_Model.buyButtonStr = @"一键购买";
            
            /// ￥1000起投，1000递增 placeholder
            model.profitLabelStr = weakSelf.loanTruansferViewModel.startIncrease_Amount;
            model.amount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.loanVo.amount;//可用余额
            NSString *str = weakSelf.loanTruansferViewModel.startIncrease_Amount;
            model.JoinImmediateView_Model.rechargeViewTextField_placeholderStr = str;
            ///可用余额展示
            model.JoinImmediateView_Model.balanceLabelStr = viewModel.availablePoint;
            
            ///如果散标金额小于最低可投金额的时候 购买的textfield直接显示散标剩余金额
            ///债转剩余金额
            CGFloat truansferRemainAmount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.transferDetail.leftTransAmount.floatValue;
            ///最小投资金额
            CGFloat minRegisterAmount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.minInverst.floatValue;
            ///投资金额的增长基数
            NSInteger instertAmount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.loanVo.finishedRatio.integerValue;
            if (truansferRemainAmount <= minRegisterAmount + instertAmount) {
                model.buyTextFieldText = [NSString stringWithFormat:@"%.2lf",truansferRemainAmount];
            }
            
            ///服务协议 button str
            model.JoinImmediateView_Model.negotiateButtonStr = weakSelf.loanTruansferViewModel.agreementTitle;
            model.JoinImmediateView_Model.totalInterest = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.loanVo.interest;
            ///加入上线
//            model.JoinImmediateView_Model.upperLimitLabelStr = weakSelf.loanViewModel.unRepaid;
            ///确认加入的Buttonstr
            model.JoinImmediateView_Model.addButtonStr = @"确认加入";
            ///预期收益
            model.profitLabelStr = [NSString hxb_getPerMilWithDouble:0.0];
            model.addButtonEndEditing = weakSelf.loanTruansferViewModel.isAddButtonEditing;
            return model;
        }];
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

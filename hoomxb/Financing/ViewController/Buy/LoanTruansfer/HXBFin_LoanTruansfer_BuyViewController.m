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
    
    [super viewDidLoad];
    
    
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

///点击了充值
- (void)registerClickRecharge {
    [self.joinimmediateView_Loan clickRechargeFunc:^{
        [HxbHUDProgress showTextWithMessage:@"余额不足，请先到官网充值后再进行投资"];
    }];
}
///点击了一键购买
- (void)registerClickBuyButton {
    [self.joinimmediateView_Loan clickBuyButtonFunc:^(NSString *capitall, UITextField *textField) {
    }];
}

///点击了加入
- (void)registerClickAddButton {
    kWeakSelf
    [self.joinimmediateView_Loan clickAddButtonFunc:^(NSString *capital) {
        // 先判断是否>=1000，再判断是否为1000的整数倍（追加时只需判断是否为1000的整数倍），错误，toast提示“起投金额1000元”或“投资金额应为1000的整数倍
        CGFloat minRegisterAmount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.transferDetail.creatTransAmount.floatValue;
        if ((capital.floatValue < minRegisterAmount)) {
            NSLog(@"请输入大于等于1000");
            [HxbHUDProgress showMessageCenter:[NSString stringWithFormat:@"起投金额%.2lf元",minRegisterAmount] inView:self.view];
            return;
        }
        
        NSInteger minRegisterAmountInteger = minRegisterAmount;
        if ((capital.integerValue % minRegisterAmountInteger) != 0) {
            NSLog(@"1000的整数倍");
            NSString *message = [NSString stringWithFormat:@"投资金额应为%ld的整数倍",(long)minRegisterAmountInteger];
            [HxbHUDProgress showMessageCenter:message inView:self.view];
            return;
        }
        
        //是否大于剩余金额
        if (capital.integerValue > self.assetsTotal.floatValue) {
            [HxbHUDProgress showMessageCenter:@"输入金额大于了剩余可投金额" inView:self.view];
            return;
        }
        //是否大于标的剩余金额
        if (capital.integerValue > weakSelf.loanTruansferViewModel.loanTruansferDetailModel.transferDetail.leftTransAmount.floatValue) {
            [HxbHUDProgress showMessageCenter:@"输入金额大于了标的剩余金额" inView:self.view];
            return;
        }
        

        //判断是否安全认证
        [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
            if (!viewModel.userInfoModel.userInfo.isAllPassed.integerValue) {
                [HxbHUDProgress showMessageCenter:@"去安全认证"inView:self.view];
            }else {
                [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansfer_confirmBuyReslutWithLoanID:weakSelf.loanTruansferViewModel.loanTruansferDetailModel.loanId andSuccessBlock:^(HXBFin_LoanTruansfer_BuyResoutViewModel *model) {
                    ///加入成功
                    HXBFin_Plan_BuySuccessViewController *planBuySuccessVC = [[HXBFin_Plan_BuySuccessViewController alloc]init];
                    [planBuySuccessVC massage:@"放款前系统将会冻结您的投资资金，放款成功后开始计息" andSuccessStr:@"投标成功" andButtonStr:@"查看我的投资"];
                    [planBuySuccessVC clickLookMYInfo:^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
                        [self.navigationController popToRootViewControllerAnimated:true];
                    }];
                    [self.navigationController pushViewController:planBuySuccessVC animated:true];
                } andFailureBlock:^(NSError *error, NSDictionary *response) {
                    NSInteger status = [response[kResponseStatus] integerValue];
                    HXBFin_Plan_BugFailViewController *failViewController = [[HXBFin_Plan_BugFailViewController alloc]init];
                    switch (status) {
                        case 3408:
                            failViewController.failLabelStr = @"余额不足";
                            failViewController.massage = @"请充值后在投资";
                            break;
                        case 3100:
                            failViewController.failLabelStr = @"已售罄";
                            break;
                    }
                    [failViewController clickButtonWithBlcok:^(UIButton *button) {
                        //跳回理财页面
                        [self.navigationController popToRootViewControllerAnimated:true];
                    }];
                }];
            }
        } andFailure:^(NSError *error) {
            [HxbHUDProgress showMessageCenter:@"加入失败" inView:self.view];
        }];
    }];
}


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
            model.remainAmountLabelStr = viewModel.availablePoint;
            ///一键购买的str
            model.JoinImmediateView_Model.buyButtonStr = @"一键购买";
            
            /// ￥1000起投，1000递增 placeholder
            model.profitLabelStr = weakSelf.loanTruansferViewModel.startIncrease_Amount;
            model.amount = weakSelf.loanTruansferViewModel.loanTruansferDetailModel.loanVo.amount;//可用余额
            NSString *str = weakSelf.loanTruansferViewModel.startIncrease_Amount;
            model.JoinImmediateView_Model.rechargeViewTextField_placeholderStr = str;
            ///余额展示
            model.JoinImmediateView_Model.balanceLabelStr = viewModel.availablePoint;
            
            
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

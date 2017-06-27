//
//  HXBLoan_JoinImmediatelyViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

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
@interface HXBFin_Loan_BuyViewController ()
@property (nonatomic,strong) HXBFin_JoinimmediateView_Loan *joinimmediateView_Loan;
///个人总资产
@property (nonatomic,copy) NSString *assetsTotal;
@property (nonatomic,copy) NSString *availablePoint;
//可用余额

@end

@implementation HXBFin_Loan_BuyViewController

- (void) setLoanViewModel:(HXBFinDetailViewModel_LoanDetail *)loanViewModel {
    _loanViewModel = loanViewModel;
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
    [[KeyChainManage sharedInstance] assetsTotalWithBlock:^(NSString *assetsTotal) {
        _assetsTotal = assetsTotal;
    }];
    [[KeyChainManage sharedInstance] availablePointWithBlock:^(NSString *availablePoint) {
        _availablePoint = availablePoint;
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
    self.joinimmediateView_Loan = [[HXBFin_JoinimmediateView_Loan alloc] init];
    [self.hxbBaseVCScrollView addSubview:self.joinimmediateView_Loan];
    
    [self trackingScrollViewBlock:^(UIScrollView *scrollView) {
        weakSelf.joinimmediateView_Loan.isEndEditing = true;
    }];
    
    self.joinimmediateView_Loan.frame = self.view.frame;
    }

- (void) registerEvent {
    ///点击了充值
    [self registerClickRecharge];
    ///点击了一键购买
    [self registerClickAddButton];
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
        CGFloat minRegisterAmount = weakSelf.loanViewModel.loanDetailModel.minInverst.floatValue;
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
        
        //是否大于剩余金额
        if (capital.integerValue >= self.assetsTotal.floatValue) {
            [HxbHUDProgress showTextWithMessage:@"输入金额大于了剩余金额"];
            return;
        }
        //判断是否安全认证
        [HXBRequestUserInfo downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
            if (!viewModel.userInfoModel.userInfo.isAllPassed.integerValue) {
                [HxbHUDProgress showTextWithMessage:@"去安全认证"];
            }else {
                [[HXBFinanctingRequest sharedFinanctingRequest]loan_confirmBuyReslutWithLoanID:weakSelf.loanViewModel.loanDetailModel.loanVo.loanId andAmount:capital andSuccessBlock:^(HXBFinModel_BuyResoult_LoanModel *model) {
                    ///加入成功
                    [HxbHUDProgress showTextWithMessage:@"加入成功"];
                    [self.navigationController popToRootViewControllerAnimated:true];
                } andFailureBlock:^(NSError *error) {
                    NSLog(@"加入失败 %@ error =%@",self,error);
                }];
            }
        } andFailure:^(NSError *error) {
            [HxbHUDProgress showTextWithMessage:@"加入失败"];
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
            model.loanAcountLable_ConstStr = @"标的剩余可投金额";
            ///充值的button str
            model.JoinImmediateView_Model.rechargeButtonStr = @"充值";
            model.JoinImmediateView_Model.balanceLabel_constStr = @"可用余额";
            model.loanAcountLabelStr = weakSelf.loanViewModel.loanDetailModel.loanVo.surplusAmount;
            ///一键购买的str
            model.JoinImmediateView_Model.buyButtonStr = @"一键购买";
            ///收益方式
            //    model.profitTypeLable_ConstStr = @"收益处理方式";
            ///加入上限
            //    model.upperLimitLabel_constStr = @"本期计划加入上限";
            /// ￥1000起投，1000递增 placeholder
            model.profitLabelStr = weakSelf.loanViewModel.addCondition;
            model.amount = weakSelf.loanViewModel.loanDetailModel.loanVo.amount;//可用余额
            model.JoinImmediateView_Model.rechargeViewTextField_placeholderStr = weakSelf.loanViewModel.addCondition;
            ///余额展示
            model.JoinImmediateView_Model.balanceLabelStr = viewModel.availablePoint;
            
            
            ///服务协议 button str
            model.JoinImmediateView_Model.negotiateButtonStr = weakSelf.loanViewModel.agreementTitle;
            model.JoinImmediateView_Model.totalInterest = weakSelf.loanViewModel.totalInterestPer100;
            ///加入上线
            model.JoinImmediateView_Model.upperLimitLabelStr = weakSelf.loanViewModel.unRepaid;
            ///确认加入的Buttonstr
            model.JoinImmediateView_Model.addButtonStr = @"确认加入";
            ///预期收益
            model.profitLabelStr = [NSString hxb_getPerMilWithDouble:0.0];
            model.addButtonEndEditing = weakSelf.loanViewModel.isAddButtonEditing;
            return model;
        }];

    } andFailure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

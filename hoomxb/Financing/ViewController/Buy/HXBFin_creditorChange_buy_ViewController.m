//
//  HXBFin_creditorChange_buy_ViewController.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_creditorChange_buy_ViewController.h"
#import "HXBCreditorChangeTopView.h"
#import "HXBCreditorChangeBottomView.h"
#import "HXBFin_creditorChange_TableViewCell.h"
#import "HXBFinanctingRequest.h"
#import "HXBFBase_BuyResult_VC.h"
#import "HXBFin_Plan_BuyViewModel.h"
#import "HxbMyTopUpViewController.h"
#import "HXBFinAddTruastWebViewVC.h"
#import "HXBFin_Buy_ViewModel.h"
#import "HXBAlertVC.h"
#import "HXBOpenDepositAccountRequest.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HxbWithdrawCardViewController.h"

@interface HXBFin_creditorChange_buy_ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** topView */
@property (nonatomic, strong) HXBCreditorChangeTopView *topView;
/** bottomView*/
@property (nonatomic, strong) HXBCreditorChangeBottomView *bottomView;
// 我的信息
@property (nonatomic, strong) HXBRequestUserInfoViewModel *viewModel;
/** 短验弹框 */
@property (nonatomic, strong) HXBAlertVC *alertVC;
// 银行卡信息
@property (nonatomic, strong) HXBBankCardModel *cardModel;
/** titleArray */
@property (nonatomic, strong) NSArray *titleArray;
/** titleArray */
@property (nonatomic, strong) NSArray *detailArray;
/** 充值金额 */
@property (nonatomic, copy) NSString *topupMoneyStr;
/** 可用余额 */
@property (nonatomic, copy) NSString *balanceMoneyStr;
/** 预期收益 */
@property (nonatomic, copy) NSString *profitMoneyStr;
/** 还需金额 */
@property (nonatomic, copy) NSString *needMoneyStr;
/** 交易密码 */
@property (nonatomic, copy) NSString *exchangePasswordStr;
/** 短信验证码 */
@property (nonatomic, copy) NSString *smsCodeStr;
/** 点击按钮的文案 */
@property (nonatomic, copy) NSString * btnLabelText;
/** 购买类型 */
@property (nonatomic, copy) NSString *buyType; // balance recharge

@end

@implementation HXBFin_creditorChange_buy_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = true;
//    [self getNewUserInfo];
    [self buildUI];
    [self getBankCardLimit];
    [self setUpDate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self getNewUserInfo];
}


- (void)buildUI {
    self.hxbBaseVCScrollView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:(UITableViewStylePlain)];
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    self.hxbBaseVCScrollView.tableFooterView = [self footTableView];
    self.hxbBaseVCScrollView.hidden = NO;
    self.hxbBaseVCScrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.hxbBaseVCScrollView.tableHeaderView = [self headTableView];
    [self.hxbBaseVCScrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    self.hxbBaseVCScrollView.delegate = self;
    self.hxbBaseVCScrollView.dataSource = self;
    self.hxbBaseVCScrollView.rowHeight = kScrAdaptationH750(110.5);
    [self.view addSubview:self.hxbBaseVCScrollView];
}


- (UIView *)headTableView {
    kWeakSelf
    _topView = [[HXBCreditorChangeTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH750(295))];
    if (_type == HXB_Plan) {
        self.topView.isHiddenBtn = YES;
        self.topView.profitStr = @"预期收益：0.00元";
        self.topView.hiddenProfitLabel = NO;
        self.topView.height = kScrAdaptationH750(295);
    } else {
        self.topView.isHiddenBtn = NO;
        self.topView.hiddenProfitLabel = YES;
        self.topView.height = kScrAdaptationH750(225);
    }
    if (_type == HXB_Creditor) {
        self.topView.keyboardType = UIKeyboardTypeDecimalPad;
        if (self.availablePoint.doubleValue < 2 * self.minRegisterAmount.doubleValue) {
            _topView.totalMoney = self.availablePoint;
            _topView.disableKeyBorad = YES;
            _topView.disableBtn = YES;
        } else {
            _topView.disableKeyBorad = NO;
            _topView.disableBtn = NO;
        }
    } else {
        self.topView.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    _topView.changeBlock = ^(NSString *text) {
        weakSelf.topView.cardStr = [NSString stringWithFormat:@"%@：%@", weakSelf.cardModel.bankType, weakSelf.cardModel.quota];
        weakSelf.topView.hiddenMoneyLabel = !weakSelf.cardModel.bankType;
        _topupMoneyStr = text;
        if (text.floatValue > _balanceMoneyStr.floatValue) {
            if ([weakSelf.viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
                weakSelf.bottomView.clickBtnStr = @"余额不足，需充值投资";
            } else {
                weakSelf.bottomView.clickBtnStr = @"绑定银行卡";
            }
        } else {
            weakSelf.bottomView.clickBtnStr = @"立即加入";
        }
        if (_type == HXB_Plan) {
            weakSelf.topView.profitStr = [NSString stringWithFormat:@"预期收益：%@", [NSString hxb_getPerMilWithDouble:text.floatValue*self.totalInterest.floatValue/100.0]];
        }
        [weakSelf setUpArray];
    };
    _topView.block = ^{ // 点击一键购买执行的方法
        NSString *topupStr = weakSelf.availablePoint;
        weakSelf.topView.totalMoney = [NSString stringWithFormat:@"%ld", topupStr.integerValue];
        if (_type == HXB_Creditor) {
            weakSelf.topView.totalMoney = [NSString stringWithFormat:@"%.2f", topupStr.doubleValue];
        }
        _topupMoneyStr = topupStr;
        [weakSelf setUpArray];
    };
    return _topView;
}


- (UIView *)footTableView {
    kWeakSelf
    _bottomView = [[HXBCreditorChangeBottomView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(200))];
    if (_type == HXB_Plan) {
        _bottomView.delegateLabel = @"红利计划服务协议》,《风险提示";
    } else if (_type == HXB_Loan) {
        _bottomView.delegateLabel = @"借款合同》,《风险提示";
    } else {
        _bottomView.delegateLabel = @"债权转让及受让协议》,《风险提示";
    }
    _bottomView.delegateBlock = ^(int index) {
        if (index == 1) {
            if (_type == HXB_Plan) {
                HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
                vc.URL = kHXB_Negotiate_ServePlanURL;
                [weakSelf.navigationController pushViewController:vc animated:true];
            } else if (_type == HXB_Loan) {
                HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
                vc.URL = kHXB_Negotiate_ServeLoanURL;
                [weakSelf.navigationController pushViewController:vc animated:true];
            } else {
                HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
                vc.URL = kHXB_Negotiate_LoanTruansferURL;
                [weakSelf.navigationController pushViewController:vc animated:true];
            }
        } else {
            NSLog(@"暂不开放");
        }
    };
    _bottomView.addBlock = ^(NSString *investMoney) {
        _btnLabelText = investMoney;
        [weakSelf clickAddBtn];
    };
    return _bottomView;
}

- (void)clickAddBtn {
    [_topView endEditing:YES];
    if (_topupMoneyStr.floatValue > _balanceMoneyStr.floatValue) {
        _buyType = @"recharge";
    } else {
        _buyType = @"balance";
    }
//    if (_viewModel.userInfoModel.userInfo.hasBindCard.intValue == 0 && _topupMoneyStr.doubleValue > _balanceMoneyStr.doubleValue) {
//        HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
//        withdrawCardViewController.title = @"绑卡";
//        withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
//        [self.navigationController pushViewController:withdrawCardViewController animated:YES];
//    } else {
        if (_type == HXB_Plan) {
            [self requestForPlan];
        } else if (_type == HXB_Loan) {
            [self requestForLoan];
        } else {
            [self requestForCreditor];
        }
        
//    }
}




// 购买红利计划
- (void)requestForPlan {
    if (_topupMoneyStr.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    } else if (_topupMoneyStr.floatValue > _availablePoint.floatValue) {
        self.topView.totalMoney = [NSString stringWithFormat:@"%ld", _availablePoint.integerValue];
        _topupMoneyStr = _availablePoint;
        _profitMoneyStr = [NSString stringWithFormat:@"%.2f", _availablePoint.floatValue*self.totalInterest.floatValue/100.0];
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"已超过加入金额"];
    }  else if (_topupMoneyStr.floatValue < _minRegisterAmount.floatValue) {
        _topView.totalMoney = [NSString stringWithFormat:@"%ld", _minRegisterAmount.integerValue];
        _topupMoneyStr = _minRegisterAmount;
        _profitMoneyStr = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.floatValue*self.totalInterest.floatValue/100.0];
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
    } else {
        BOOL isMultipleOfMin = ((_topupMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue);
        if (isMultipleOfMin) {
            [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
        } else {
            if (_viewModel.userInfoModel.userInfo.hasBindCard.intValue == 0 && _topupMoneyStr.doubleValue > _balanceMoneyStr.doubleValue) {
                HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                withdrawCardViewController.title = @"绑卡";
                withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [self.navigationController pushViewController:withdrawCardViewController animated:YES];
            }else{
                if ([_btnLabelText containsString:@"充值"]) {
                    [self fullAddtionFunc];
                } else {
                    [self alertPassWord];
                }
            }
        }
       
    }
}

// 购买散标
- (void)requestForLoan {
    if (_topupMoneyStr.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    } else if (_topupMoneyStr.floatValue > _availablePoint.floatValue) {
        self.topView.totalMoney = [NSString stringWithFormat:@"%ld", _availablePoint.integerValue];
        _topupMoneyStr = [NSString stringWithFormat:@"%ld", _availablePoint.integerValue];
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
    } else if (_topupMoneyStr.floatValue < _minRegisterAmount.floatValue) {
        _topView.totalMoney = [NSString stringWithFormat:@"%ld", _minRegisterAmount.integerValue];
        _topupMoneyStr = _minRegisterAmount;
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
    } else {
        BOOL isMultipleOfMin = ((_topupMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue);
        if (isMultipleOfMin) {
            [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
        } else {
            if (_viewModel.userInfoModel.userInfo.hasBindCard.intValue == 0 && _topupMoneyStr.doubleValue > _balanceMoneyStr.doubleValue) {
                HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                withdrawCardViewController.title = @"绑卡";
                withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [self.navigationController pushViewController:withdrawCardViewController animated:YES];
            }else{
                if ([_btnLabelText containsString:@"充值"]) {
                    [self fullAddtionFunc];
                } else {
                    [self alertPassWord];
                }
            }
        }
    }
}

// 购买债权
- (void)requestForCreditor {
    if (_topupMoneyStr.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    } else if (_topupMoneyStr.floatValue > _availablePoint.floatValue) {
        self.topView.totalMoney = [NSString stringWithFormat:@"%.2f", _availablePoint.doubleValue];
        _topupMoneyStr = _availablePoint;
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
    } else if (_topupMoneyStr.floatValue < _minRegisterAmount.floatValue) {
        _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.doubleValue];
        _topupMoneyStr = _minRegisterAmount;
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
    } else if (_availablePoint.floatValue - _topupMoneyStr.floatValue < _minRegisterAmount.floatValue && _topupMoneyStr.doubleValue != _availablePoint.doubleValue) {
        [HxbHUDProgress showTextWithMessage:@"剩余的带转让金额不能低于起投金额"];
    } else {
        BOOL isMultipleOfMin = ((_topupMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue);
        if (isMultipleOfMin) {
            if (_topupMoneyStr.doubleValue != _availablePoint.doubleValue) {
                [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
            } else {
                if ([_btnLabelText containsString:@"充值"]) {
                    [self fullAddtionFunc];
                } else {
                    [self alertPassWord];
                }
            }
        } else {
            if (_viewModel.userInfoModel.userInfo.hasBindCard.intValue == 0 && _topupMoneyStr.doubleValue > _balanceMoneyStr.doubleValue) {
                HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                withdrawCardViewController.title = @"绑卡";
                withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [self.navigationController pushViewController:withdrawCardViewController animated:YES];
            }else{
                if ([_btnLabelText containsString:@"充值"]) {
                    [self fullAddtionFunc];
                } else {
                    [self alertPassWord];
                }
            }
        }
        
    }
}

- (void)fullAddtionFunc {
    kWeakSelf
    HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [accountRequest accountRechargeRequestWithRechargeAmount:_topupMoneyStr andWithAction:@"quickpay" andSuccessBlock:^(id responseObject) {
        [weakSelf alertSmsCode];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)alertSmsCode {
    self.alertVC = [[HXBAlertVC alloc] init];
    self.alertVC.isCode = YES;
    self.alertVC.isCleanPassword = YES;
    self.alertVC.messageTitle = @"充值验证短信";
    self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [_viewModel.userInfoModel.userInfo.mobile replaceStringWithStartLocation:3 lenght:4]];
    kWeakSelf
    self.alertVC.sureBtnClick = ^(NSString *pwd) {
        [weakSelf.alertVC.view endEditing:YES];
        NSDictionary *dic = nil;
        if (weakSelf.type == HXB_Plan) {
            dic = @{@"amount": _topupMoneyStr,
                    @"cashType": _cashType,
                    @"buyType": _buyType,
                    @"balanceAmount": _balanceMoneyStr,
                    @"smsCode": pwd};
            [weakSelf buyPlanWithDic:dic];
        } else if (weakSelf.type == HXB_Loan) {
            dic = @{@"amount": _topupMoneyStr,
                    @"buyType": _buyType,
                    @"balanceAmount": _balanceMoneyStr,
                    @"smsCode": pwd};
            [weakSelf buyLoanWithDic:dic];
        } else {
            dic = @{@"amount": _topupMoneyStr,
                    @"buyType": _buyType,
                    @"balanceAmount": _balanceMoneyStr,
                    @"smsCode": pwd};
            [weakSelf buyCreditorWithDic:dic];
        }
    };
    [self presentViewController:_alertVC animated:NO completion:nil];
}

-(void)alertPassWord {
    self.alertVC = [[HXBAlertVC alloc] init];
    self.alertVC.isCode = NO;
    self.alertVC.messageTitle = @"交易密码";
    self.alertVC.isCleanPassword = YES;
    kWeakSelf
    self.alertVC.sureBtnClick = ^(NSString *pwd) {
        NSDictionary *dic = nil;
        if (weakSelf.type == HXB_Plan) {
            dic = @{@"amount": _topupMoneyStr,
                    @"cashType": _cashType,
                    @"buyType": _buyType,
                    @"tradPassword": pwd};
            [weakSelf buyPlanWithDic:dic];
        } else if (weakSelf.type == HXB_Loan) {
            dic = @{@"amount": _topupMoneyStr,
                    @"buyType": _buyType,
                    @"tradPassword": pwd,
                    };
            [weakSelf buyLoanWithDic:dic];
        } else {
            dic = @{@"amount": _topupMoneyStr,
                    @"buyType": _buyType,
                    @"tradPassword": pwd,
                    };
            [weakSelf buyCreditorWithDic:dic];
        }
    };
    self.alertVC.forgetBtnClick = ^{
        [weakSelf.alertVC.view endEditing:YES];
        HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
        modifyTransactionPasswordVC.title = @"修改交易密码";
        modifyTransactionPasswordVC.userInfoModel = weakSelf.viewModel.userInfoModel;
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [weakSelf.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
    };
    [self presentViewController:_alertVC animated:NO completion:nil];
    

}

- (void)buyPlanWithDic:(NSDictionary *)dic {
    kWeakSelf
    [[HXBFinanctingRequest sharedFinanctingRequest] plan_buyReslutWithPlanID:self.loanId parameter:dic andSuccessBlock:^(HXBFin_Plan_BuyViewModel *model) {
        HXBFBase_BuyResult_VC *planBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
        planBuySuccessVC.imageName = @"successful";
        planBuySuccessVC.buy_title = @"加入成功";
        planBuySuccessVC.buy_description =model.lockStart;
        planBuySuccessVC.buy_ButtonTitle = @"查看我的投资";
        planBuySuccessVC.title = @"投资成功";
        [planBuySuccessVC clickButtonWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_PlanList object:nil];
            [self.navigationController popToRootViewControllerAnimated:true];
        }];
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController pushViewController:planBuySuccessVC animated:true];
    } andFailureBlock:^(NSError *error, NSInteger status) {
        HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc]init];
        failViewController.title = @"投资结果";
        switch (status) {
            case 3408:
                failViewController.imageName = @"yuebuzu";
                failViewController.buy_title = @"可用余额不足，请重新购买";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 999:
                failViewController.imageName = @"shouqin";
                failViewController.buy_title = @"手慢了，已售罄";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case -999:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 3016:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"购买的充值结果正在恒丰银行处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 3014:
                return ;
            case 3015:
                return ;
            case 104:
                return ;
            default:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_ButtonTitle = @"重新投资";
        }
        [failViewController clickButtonWithBlock:^{
            [self.navigationController popToRootViewControllerAnimated:true];  //跳回理财页面
        }];
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [weakSelf.navigationController pushViewController:failViewController animated:true];
    }];
}

- (void)buyLoanWithDic:(NSDictionary *)dic {
    kWeakSelf
    [[HXBFinanctingRequest sharedFinanctingRequest] loan_confirmBuyReslutWithLoanID:self.loanId parameter:dic andSuccessBlock:^(HXBFinModel_BuyResoult_LoanModel *model) {
        ///加入成功
        HXBFBase_BuyResult_VC *loanBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
        loanBuySuccessVC.imageName = @"successful";
        loanBuySuccessVC.buy_title = @"投标成功";
        loanBuySuccessVC.buy_description = @"放款前系统将会冻结您的投资金额，放款成功后开始计息";
        loanBuySuccessVC.buy_ButtonTitle = @"查看我的投资";
        loanBuySuccessVC.title = @"投资成功";
        [loanBuySuccessVC clickButtonWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
            [self.navigationController popToRootViewControllerAnimated:true];
        }];
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController pushViewController:loanBuySuccessVC animated:true];
    } andFailureBlock:^(NSError *error, NSInteger status) {
        HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc]init];
        failViewController.title = @"投资结果";
        switch (status) {
            case 3408:
                failViewController.imageName = @"yuebuzu";
                failViewController.buy_title = @"可用余额不足，请重新购买";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 999:
                failViewController.imageName = @"shouqin";
                failViewController.buy_title = @"手慢了，已售罄";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case -999:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 3016:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"购买的充值结果正在恒丰银行处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 3014:
                return ;
            case 3015:
                return ;
            case 104:
                return ;
            default:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_ButtonTitle = @"重新投资";
        }
        [failViewController clickButtonWithBlock:^{
            [self.navigationController popToRootViewControllerAnimated:true];  //跳回理财页面
        }];
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController pushViewController:failViewController animated:true];
    }];
}

- (void)buyCreditorWithDic:(NSDictionary *)dic {
    kWeakSelf
    [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansfer_confirmBuyReslutWithLoanID:_loanId parameter:dic andSuccessBlock:^(HXBFin_LoanTruansfer_BuyResoutViewModel *model) {
        ///加入成功
        HXBFBase_BuyResult_VC *loanBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
        loanBuySuccessVC.imageName = @"successful";
        loanBuySuccessVC.buy_title = @"投标成功";
        loanBuySuccessVC.buy_description = @"放款前系统将会冻结您的投资金额，放款成功后开始计息";
        loanBuySuccessVC.buy_ButtonTitle = @"查看我的投资";
        loanBuySuccessVC.title = @"投资成功";
        [loanBuySuccessVC clickButtonWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
            [self.navigationController popToRootViewControllerAnimated:true];
        }];
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController pushViewController:loanBuySuccessVC animated:true];
    } andFailureBlock:^(NSError *error, NSDictionary *response) {
        NSInteger status = [response[@"status"] integerValue];
        HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc]init];
        failViewController.title = @"投资结果";
        switch (status) {
            case 3408:
                failViewController.imageName = @"yuebuzu";
                failViewController.buy_title = @"可用余额不足，请重新购买";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 999:
                failViewController.imageName = @"shouqin";
                failViewController.buy_title = @"手慢了，已售罄";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case -999:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 3016:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"购买的充值结果正在恒丰银行处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 3014:
                return ;
            case 3015:
                return ;
            case 104:
                return ;
            default:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_ButtonTitle = @"重新投资";
        }
        [failViewController clickButtonWithBlock:^{
            [self.navigationController popToRootViewControllerAnimated:true];  //跳回理财页面
        }];
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [weakSelf.navigationController pushViewController:failViewController animated:true];
    }];
}

- (void)changeBtnLabel {
    NSLog(@"%@, %@", _topupMoneyStr, _balanceMoneyStr);
    if (_topupMoneyStr.floatValue > _balanceMoneyStr.floatValue) {
        self.bottomView.clickBtnStr = @"余额不足，需充值投资";
    } else {
        self.bottomView.clickBtnStr = @"立即加入";
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifier = @"identifer";
    HXBFin_creditorChange_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBFin_creditorChange_TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleStr = _titleArray[indexPath.row];
    cell.detailStr = _detailArray[indexPath.row];
    if ([_titleArray[indexPath.row] isEqualToString:@"预期收益："] || [_titleArray[indexPath.row] isEqualToString:@"还需支付："]) {
        cell.isAttributeShow = YES;
    } else {
        cell.isAttributeShow = NO;
    }
    return cell;
}

- (void)setUpDate {
    if (_type == HXB_Plan) {
        _topView.creditorMoney = [NSString stringWithFormat:@"本期计划加入上限：%@", [NSString hxb_getPerMilWithIntegetNumber:_availablePoint.doubleValue]];
    } else if (_type == HXB_Loan) {
        _topView.creditorMoney = [NSString stringWithFormat:@"标的剩余金额：%@", [NSString hxb_getPerMilWithIntegetNumber:_availablePoint.doubleValue]];
    } else {
        _topView.creditorMoney = [NSString stringWithFormat:@"待转让金额：%@", [NSString hxb_getPerMilWithDouble:_availablePoint.doubleValue]];
    }
    _topView.placeholderStr = _placeholderStr;
    
}


// 获取用户信息
- (void)getNewUserInfo {
    [KeyChain downLoadUserInfoNoHUDWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.hxbBaseVCScrollView.hidden = NO;
        _viewModel = viewModel;
        _balanceMoneyStr = _viewModel.userInfoModel.userAssets.availablePoint;
        [self setUpArray];
        NSLog(@"%@, %@, %@, %@, %@, %lu", self.placeholderStr, self.availablePoint, self.loanId, _balanceMoneyStr, _viewModel.availablePoint, self.type);
        [self.hxbBaseVCScrollView reloadData];
    } andFailure:^(NSError *error) {
        
    }];
}

// 获取银行限额
- (void)getBankCardLimit {
    [HXBFin_Buy_ViewModel requestForBankCardSuccessBlock:^(HXBBankCardModel *model) {
        self.cardModel = model;
        _topView.cardStr = [NSString stringWithFormat:@"%@：%@", self.cardModel.bankType, self.cardModel.quota];
        self.topView.hiddenMoneyLabel = !self.cardModel.bankType;

    }];
}

- (void)setUpArray {
    if (!_profitMoneyStr) {
        _profitMoneyStr = @"";
    }
//    if (_type == HXB_Plan) {
//        if (_topupMoneyStr.floatValue > _balanceMoneyStr.floatValue) {
//            self.titleArray = @[@"可用金额：", @"还需支付："];
//            self.detailArray = @[[NSString hxb_getPerMilWithDouble:_profitMoneyStr.doubleValue], _viewModel.availablePoint, [NSString hxb_getPerMilWithDouble:(_topupMoneyStr.doubleValue - _balanceMoneyStr.doubleValue)]];
//            [self.hxbBaseVCScrollView reloadData];
//        } else {
//            self.titleArray = @[@"可用金额："];
//            self.detailArray = @[[NSString hxb_getPerMilWithDouble:_profitMoneyStr.doubleValue], _viewModel.availablePoint];
//            [self.hxbBaseVCScrollView reloadData];
//        }
//    } else if (_type == HXB_Loan) {
//        if (_topupMoneyStr.doubleValue > _balanceMoneyStr.doubleValue) {
//            self.titleArray = @[@"可用金额：", @"还需支付："];
//            self.detailArray = @[_viewModel.availablePoint, [NSString hxb_getPerMilWithDouble:(_topupMoneyStr.doubleValue - _balanceMoneyStr.doubleValue)]];
//            [self.hxbBaseVCScrollView reloadData];
//        } else {
//            self.titleArray = @[@"可用金额："];
//            self.detailArray = @[_viewModel.availablePoint];
//            [self.hxbBaseVCScrollView reloadData];
//        }
//    } else {
        if (_topupMoneyStr.doubleValue > _balanceMoneyStr.doubleValue) {
            self.titleArray = @[@"可用金额：", @"还需支付："];
            self.detailArray = @[_viewModel.availablePoint, [NSString hxb_getPerMilWithDouble:(_topupMoneyStr.doubleValue - _balanceMoneyStr.doubleValue)]];
            [self.hxbBaseVCScrollView reloadData];
        } else {
            self.titleArray = @[@"可用金额："];
            self.detailArray = @[_viewModel.availablePoint];
            [self.hxbBaseVCScrollView reloadData];
        }
//    }
    [self changeBtnLabel];
}



- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (NSArray *)detailArray {
    if (!_detailArray) {
        _detailArray = [NSArray array];
    }
    return _detailArray;
}

//- (HXBAlertVC *)alertVC {
//    if (!_alertVC) {
//        _alertVC = [[HXBAlertVC alloc] init];
//    }
//    return _alertVC;
//}


- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

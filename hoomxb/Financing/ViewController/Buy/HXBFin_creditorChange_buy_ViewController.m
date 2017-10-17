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
#import "HXBFin_LoanTruansfer_BuyResoutViewModel.h"

static NSString *const topupString = @"余额不足，需充值投资";
static NSString *const bankString = @"绑定银行卡";
static NSString *const investString = @"立即投资";


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
@property (nonatomic, copy) NSString *inputMoneyStr;
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
    
    [self setUpDate];
    [self getBankCardLimit];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self getBankCardLimit];
    [self getNewUserInfo];
}


- (void)buildUI {
    self.hxbBaseVCScrollView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:(UITableViewStylePlain)];
    if (LL_iPhoneX) {
        self.hxbBaseVCScrollView.frame = CGRectMake(0, 88, kScreenWidth, kScreenHeight - 88);
    }
    self.hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
    self.hxbBaseVCScrollView.tableFooterView = [self footTableView];
    self.hxbBaseVCScrollView.tableHeaderView = self.topView;
    self.hxbBaseVCScrollView.hidden = NO;
    self.hxbBaseVCScrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.hxbBaseVCScrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    self.hxbBaseVCScrollView.delegate = self;
    self.hxbBaseVCScrollView.dataSource = self;
    self.hxbBaseVCScrollView.rowHeight = kScrAdaptationH750(110.5);
    [self.view addSubview:self.hxbBaseVCScrollView];
    [self.hxbBaseVCScrollView reloadData];
}


- (UIView *)topView {
    kWeakSelf
    if (!_topView) {
        _topView = [[HXBCreditorChangeTopView alloc] initWithFrame:CGRectZero];
        if (_type == HXB_Plan) {
            _topView.isHiddenBtn = YES;
            _topView.profitStr = @"预期收益：0.00元";
            _topView.hiddenProfitLabel = NO;
        } else {
            _topView.isHiddenBtn = NO;
            _topView.hiddenProfitLabel = YES;
        }
        if (_type == HXB_Creditor) {
            _topView.keyboardType = UIKeyboardTypeDecimalPad; // 债转带小数点键盘
            if (self.availablePoint.doubleValue < 2 * self.minRegisterAmount.doubleValue) {
                _topView.totalMoney = self.availablePoint;
                _inputMoneyStr = self.availablePoint;
                _topView.disableKeyBorad = YES;
                _topView.disableBtn = YES;
            } else {
                _topView.disableKeyBorad = NO;
                _topView.disableBtn = NO;
            }
        } else {
            _topView.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        _topView.changeBlock = ^(NSString *text) {
            weakSelf.topView.hiddenMoneyLabel = !weakSelf.cardModel.bankType;
            _inputMoneyStr = text;
            if (text.floatValue > _balanceMoneyStr.floatValue) {
                if ([weakSelf.viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
                    weakSelf.bottomView.clickBtnStr = topupString;
                } else {
                    weakSelf.bottomView.clickBtnStr = bankString;
                }
            } else {
                weakSelf.bottomView.clickBtnStr = investString;
                if (_type == HXB_Plan) {
                    weakSelf.bottomView.clickBtnStr = @"立即加入";
                }
            }
            if (_type == HXB_Plan) {
                weakSelf.topView.profitStr = [NSString stringWithFormat:@"预期收益：%@", [NSString hxb_getPerMilWithDouble:text.floatValue*self.totalInterest.floatValue/100.0]];
            }
            [weakSelf setUpArray];
        };
        _topView.block = ^{ // 点击一键购买执行的方法
            NSString *topupStr = weakSelf.availablePoint;
            weakSelf.topView.totalMoney = [NSString stringWithFormat:@"%.lf", topupStr.floatValue];
            if (_type == HXB_Creditor) {
                weakSelf.topView.totalMoney = [NSString stringWithFormat:@"%.2f", topupStr.doubleValue];
            }
            _inputMoneyStr = topupStr;
            [weakSelf setUpArray];
        };
    }
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
    if (_inputMoneyStr.floatValue > _balanceMoneyStr.floatValue) {
        _buyType = @"recharge";
    } else {
        _buyType = @"balance";
    }
    if (_type == HXB_Plan) {
        [self requestForPlan];
    } else if (_type == HXB_Loan) {
        [self requestForLoan];
    } else {
        [self requestForCreditor];
    }
}




// 购买红利计划
- (void)requestForPlan {
    if (_availablePoint.integerValue == 0) {
        self.topView.totalMoney = @"";
        self.topView.profitStr = @"预期收益：0.00元";
        _inputMoneyStr = @"";
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"已超可加入金额"];
        return;
    }
    if (_inputMoneyStr.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    } else if (_inputMoneyStr.floatValue > _availablePoint.floatValue) {
        self.topView.totalMoney = [NSString stringWithFormat:@"%.lf", _availablePoint.doubleValue];
        _inputMoneyStr = [NSString stringWithFormat:@"%.lf", _availablePoint.doubleValue];
        _profitMoneyStr = [NSString stringWithFormat:@"%.2f", _availablePoint.floatValue*self.totalInterest.floatValue/100.0];
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"已超可加入金额"];
    }  else if (_inputMoneyStr.floatValue < _minRegisterAmount.floatValue) {
        _topView.totalMoney = [NSString stringWithFormat:@"%ld", _minRegisterAmount.integerValue];
        _inputMoneyStr = _minRegisterAmount;
        _profitMoneyStr = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.floatValue*self.totalInterest.floatValue/100.0];
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
    } else {
        BOOL isMultipleOfMin = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue);
        if (isMultipleOfMin) {
            [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
        } else {
            [self chooseBuyTypeWithSting:_btnLabelText];
        }
       
    }
}

// 购买散标
- (void)requestForLoan {
    if (_inputMoneyStr.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    } else if (_inputMoneyStr.floatValue > _availablePoint.floatValue) {
        self.topView.totalMoney = [NSString stringWithFormat:@"%.lf", _availablePoint.doubleValue];
        _inputMoneyStr = [NSString stringWithFormat:@"%.lf", _availablePoint.doubleValue];
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
    } else if (_inputMoneyStr.floatValue < _minRegisterAmount.floatValue) {
        _topView.totalMoney = [NSString stringWithFormat:@"%ld", _minRegisterAmount.integerValue];
        _inputMoneyStr = _minRegisterAmount;
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
    } else {
        BOOL isMultipleOfMin = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue);
        if (isMultipleOfMin) {
            [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
        } else {
            [self chooseBuyTypeWithSting:_btnLabelText];
        }
        
    }
}

// 购买债权
- (void)requestForCreditor {
    /*
     _availablePoint             待转让金额
     _minRegisterAmount          最低起投金额
     _registerMultipleAmount     最低起投此金额多少倍
     _inputMoneyStr              输入的金额
     */
    BOOL isHasContainsNonzeroDecimals = (long long)([_inputMoneyStr doubleValue] * 100) % 100 != 0 ? true:false;//true:含非零小数
    BOOL isMultipleOfMin = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue);//true表示非（最低倍数）的整数倍
    if (_inputMoneyStr.length <= 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    }else{
        if (isHasContainsNonzeroDecimals) {
            if ((long long)([_inputMoneyStr doubleValue] * 100) == (long long)([_availablePoint doubleValue] * 100)) {
                [self chooseBuyTypeWithSting:_btnLabelText];
                return;
            }else{
                [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
                return;
            }
        }else{
            if (_inputMoneyStr.floatValue > _availablePoint.floatValue) {
                self.topView.totalMoney = [NSString stringWithFormat:@"%.2f", _availablePoint.doubleValue];
                _inputMoneyStr = _availablePoint;
                [self setUpArray];
                [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
            } else if (_inputMoneyStr.floatValue < _minRegisterAmount.floatValue) {
                _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.doubleValue];
                _inputMoneyStr = _minRegisterAmount;
                [self setUpArray];
                [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
            } else if (isMultipleOfMin) {
                [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
            } else if (_availablePoint.floatValue - _inputMoneyStr.floatValue < _minRegisterAmount.floatValue && _inputMoneyStr.doubleValue != _availablePoint.doubleValue) {
                [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"购买后剩余金额不能小于%@元", _minRegisterAmount]];
            } else {
                [self chooseBuyTypeWithSting:_btnLabelText];
            }
        }
    }
    
    /*
    BOOL isMultipleOfMin = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue);//
    if (_inputMoneyStr.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    } else if (_inputMoneyStr.floatValue > _availablePoint.floatValue) {
        self.topView.totalMoney = [NSString stringWithFormat:@"%.2f", _availablePoint.doubleValue];
        _inputMoneyStr = _availablePoint;
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
    } else if (_inputMoneyStr.floatValue < _minRegisterAmount.floatValue) {
        _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.doubleValue];
        _inputMoneyStr = _minRegisterAmount;
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
    } else if (isMultipleOfMin) {
        [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
    } else if (_availablePoint.floatValue - _inputMoneyStr.floatValue < _minRegisterAmount.floatValue && _inputMoneyStr.doubleValue != _availablePoint.doubleValue) {
        [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"购买后剩余金额不能小于%@元", _minRegisterAmount]];
    } else {
        if ([_btnLabelText containsString:@"充值"]) {
            [self fullAddtionFunc];
        } else if ([_btnLabelText containsString:@"绑定"]){
            HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
            withdrawCardViewController.title = @"绑卡";
            withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
            [self.navigationController pushViewController:withdrawCardViewController animated:YES];
        } else {
            [self alertPassWord];
        }
    }
     */
}

// 判断是什么投资类型（充值购买，余额购买、未绑卡）
- (void)chooseBuyTypeWithSting:(NSString *)buyType {
    if ([buyType isEqualToString:topupString]) {
        [self fullAddtionFunc];
    } else if ([buyType isEqualToString:bankString]) {
        HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
        withdrawCardViewController.title = @"绑卡";
        withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
        [self.navigationController pushViewController:withdrawCardViewController animated:YES];
    } else {
        [self alertPassWord];
    }
}

- (void)fullAddtionFunc {
    kWeakSelf
    if ((_inputMoneyStr.doubleValue - _balanceMoneyStr.doubleValue) < 1.00) {
        [HxbHUDProgress showTextWithMessage:@"充值金额必须大于1元"];
        return;
    }
    HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [accountRequest accountRechargeRequestWithRechargeAmount:_inputMoneyStr andWithAction:@"quickpay" andSuccessBlock:^(id responseObject) {
        [weakSelf alertSmsCode];
    } andFailureBlock:^(NSError *error) {
        NSDictionary *errDic = (NSDictionary *)error;
        @try {
            if ([errDic[@"message"] isEqualToString:@"存管账户信息不完善"]) {
                HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                withdrawCardViewController.title = @"绑卡";
                withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                [self.navigationController pushViewController:withdrawCardViewController animated:YES];
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }];
}

- (void)alertSmsCode {
    self.alertVC = [[HXBAlertVC alloc] init];
    self.alertVC.isCode = YES;
    self.alertVC.isCleanPassword = YES;
    self.alertVC.messageTitle = @"充值验证短信";
    self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [self.cardModel.securyMobile replaceStringWithStartLocation:3 lenght:4]];
    kWeakSelf
    self.alertVC.sureBtnClick = ^(NSString *pwd) {
        [weakSelf.alertVC.view endEditing:YES];
        NSDictionary *dic = nil;
        if (weakSelf.type == HXB_Plan) {
            dic = @{@"amount": _inputMoneyStr,
                    @"cashType": _cashType,
                    @"buyType": _buyType,
                    @"balanceAmount": _balanceMoneyStr,
                    @"smsCode": pwd};
            [weakSelf buyPlanWithDic:dic];
        } else if (weakSelf.type == HXB_Loan) {
            dic = @{@"amount": [NSString stringWithFormat:@"%.lf", _inputMoneyStr.doubleValue], // 强转成整数类型
                    @"buyType": _buyType,
                    @"balanceAmount": _balanceMoneyStr,
                    @"smsCode": pwd};
            [weakSelf buyLoanWithDic:dic];
        } else {
            dic = @{@"amount": [NSString stringWithFormat:@"%.2f", _inputMoneyStr.doubleValue],
                    @"buyType": _buyType,
                    @"balanceAmount": _balanceMoneyStr,
                    @"smsCode": pwd};
            [weakSelf buyCreditorWithDic:dic];
        }
    };
    self.alertVC.getVerificationCodeBlock = ^{
        HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
        [accountRequest accountRechargeRequestWithRechargeAmount:weakSelf.inputMoneyStr andWithAction:@"quickpay" andSuccessBlock:^(id responseObject) {
        } andFailureBlock:^(NSError *error) {
            NSDictionary *errDic = (NSDictionary *)error;
            @try {
                if ([errDic[@"message"] isEqualToString:@"存管账户信息不完善"]) {
                    HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc]init];
                    withdrawCardViewController.title = @"绑卡";
                    withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
                    [weakSelf.navigationController pushViewController:withdrawCardViewController animated:YES];
                }
            } @catch (NSException *exception) {
            } @finally {
            }
            
        }];
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
            dic = @{@"amount": _inputMoneyStr,
                    @"cashType": _cashType,
                    @"buyType": _buyType,
                    @"tradPassword": pwd};
            [weakSelf buyPlanWithDic:dic];
        } else if (weakSelf.type == HXB_Loan) {
            dic = @{@"amount": _inputMoneyStr,
                    @"buyType": _buyType,
                    @"tradPassword": pwd,
                    };
            [weakSelf buyLoanWithDic:dic];
        } else {
            dic = @{@"amount": _inputMoneyStr,
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

// 购买计划
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
            case kHXBNot_Sufficient_Funds:
                failViewController.imageName = @"yuebuzu";
                failViewController.buy_title = @"可用余额不足，请重新购买";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBSold_Out:
                failViewController.imageName = @"shouqin";
                failViewController.buy_title = @"手慢了，已售罄";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBPurchase_Processing:
                failViewController.imageName = @"outOffTime";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBHengfeng_treatment:
                failViewController.imageName = @"outOffTime";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"购买的充值结果正在恒丰银行处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBTransaction_Password_Error:
                self.alertVC.isCleanPassword = YES;
                return ;
            case kHXBSMS_Code_Error:
                return ;
            case 104:
                return ;
            case 412:
                return ;
            case kHXBBuying_Too_Frequently:
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

// 购买散标
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
            case kHXBNot_Sufficient_Funds:
                failViewController.imageName = @"yuebuzu";
                failViewController.buy_title = @"可用余额不足，请重新购买";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBSold_Out:
                failViewController.imageName = @"shouqin";
                failViewController.buy_title = @"手慢了，已售罄";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBPurchase_Processing:
                failViewController.imageName = @"outOffTime";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBHengfeng_treatment:
                failViewController.imageName = @"outOffTime";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"购买的充值结果正在恒丰银行处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBTransaction_Password_Error:
                self.alertVC.isCleanPassword = YES;
                return ;
            case kHXBSMS_Code_Error:
                return ;
            case 104:
                return ;
            case 412:
                return ;
            case kHXBBuying_Too_Frequently:
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

// 购买债权
- (void)buyCreditorWithDic:(NSDictionary *)dic {
    kWeakSelf
    [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansfer_confirmBuyReslutWithLoanID:_loanId parameter:dic andSuccessBlock:^(HXBFin_LoanTruansfer_BuyResoutViewModel *model) {
        ///加入成功
        HXBFBase_BuyResult_VC *loanBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
        loanBuySuccessVC.title = @"购买成功";
        loanBuySuccessVC.buy_title = @"购买成功";
        loanBuySuccessVC.imageName = @"successful";
        loanBuySuccessVC.massage_Left_StrArray = @[@"下一还款日", @"投资金额", @"实际买入本金", @"公允利息"];
        loanBuySuccessVC.massage_Right_StrArray = @[model.nextRepayDate, model.buyAmount, model.principal, model.interest];
        if (model.isRepayed) {
            loanBuySuccessVC.buy_description = @"公允利息为您垫付的转让人持有天利息，还款人将会在下个还款日予以返回";
        } else {
            loanBuySuccessVC.buy_description = @"公允利息：当期已还时，债权人将多收利息进行补偿，均放入投资本金";
        }
        loanBuySuccessVC.buy_ButtonTitle = @"查看我的投资";
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
            case kHXBNot_Sufficient_Funds:
                failViewController.imageName = @"yuebuzu";
                failViewController.buy_title = @"可用余额不足，请重新购买";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBSold_Out:
                failViewController.imageName = @"shouqin";
                failViewController.buy_title = @"手慢了，已售罄";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBPurchase_Processing:
                failViewController.imageName = @"outOffTime";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBHengfeng_treatment:
                failViewController.imageName = @"outOffTime";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = @"购买的充值结果正在恒丰银行处理中";
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case 1:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = response[@"message"];
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
            case kHXBTransaction_Password_Error:
                self.alertVC.isCleanPassword = YES;
                return ;
            case kHXBSMS_Code_Error:
                return ;
            case 104:
                return ;
            case 412:
                return ;
            case kHXBBuying_Too_Frequently:
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
    NSLog(@"%@, %@", _inputMoneyStr, _balanceMoneyStr);
    if (_inputMoneyStr.floatValue > _balanceMoneyStr.floatValue) {
        if ([self.viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
            self.bottomView.clickBtnStr = @"余额不足，需充值投资";
        } else {
            self.bottomView.clickBtnStr = @"绑定银行卡";
        }
    } else {
        self.bottomView.clickBtnStr = @"立即投资";
        if (_type == HXB_Plan) {
             self.bottomView.clickBtnStr = @"立即加入";
        }
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
    if ([_titleArray[indexPath.row] isEqualToString:@"还需支付："]) {
        cell.isAttributeShow = YES;
        cell.isHeddenHine = YES;
    } else {
        cell.isHeddenHine = NO;
        cell.isAttributeShow = NO;
        if (_titleArray.count == 1) {
            cell.isHeddenHine  = YES;
        }
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
        self.hxbBaseVCScrollView.tableHeaderView = nil;
        self.cardModel = model;
        if (_type == HXB_Plan) {
            if (self.cardModel.bankType) {
                self.topView.height = kScrAdaptationH750(360);
            } else {
                self.topView.height = kScrAdaptationH750(290);
            }
        } else {
            if (self.cardModel.bankType) {
                self.topView.height = kScrAdaptationH750(290);
            } else {
                self.topView.height = kScrAdaptationH750(220);
            }
        }
        _topView.cardStr = [NSString stringWithFormat:@"%@%@", self.cardModel.bankType, self.cardModel.quota];
        _topView.hasBank = self.cardModel.bankType ? YES : NO;
        self.hxbBaseVCScrollView.tableHeaderView = self.topView;
    }];
}

- (void)setUpArray {
    if (!_profitMoneyStr) {
        _profitMoneyStr = @"";
    }
    if (_inputMoneyStr.doubleValue > _balanceMoneyStr.doubleValue) {
        self.titleArray = @[@"可用金额：", @"还需支付："];
        self.detailArray = @[_viewModel.availablePoint, [NSString hxb_getPerMilWithDouble:(_inputMoneyStr.doubleValue - _balanceMoneyStr.doubleValue)]];
        [self.hxbBaseVCScrollView reloadData];
    } else {
        self.titleArray = @[@"可用金额："];
        self.detailArray = @[_viewModel.availablePoint];
        [self.hxbBaseVCScrollView reloadData];
    }
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

//
//  HXBFin_creditorChange_buy_ViewController.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
#import "HXBChooseDiscountCouponViewController.h"
#import "HXBChooseCouponViewModel.h"
#import "HXBCouponModel.h"

static NSString *const topupString = @"余额不足，需充值投资";
static NSString *const bankString = @"绑定银行卡";
static NSString *const investString = @"立即投资";


@interface HXBFin_creditorChange_buy_ViewController ()<UITableViewDelegate, UITableViewDataSource, HXBChooseDiscountCouponViewControllerDelegate>
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
/** 优惠券Title */
@property (nonatomic, copy) NSString *couponTitle;
/** 优惠券金额 */
@property (nonatomic, copy) NSString *discountTitle;
/** 应付金额detailLabel */
@property (nonatomic, copy) NSString *handleDetailTitle;
/** 可用余额TextLabel */
@property (nonatomic, copy) NSString *balanceTitle;
/** 可用余额detailLabel */
@property (nonatomic, copy) NSString *balanceDetailTitle;
/** 最优优惠券model */
@property (nonatomic, strong) HXBBestCouponModel *model;
/** 选择的优惠券model */
@property (nonatomic, strong) HXBCouponModel *chooseCoupon;
/** 是否有优惠券 */
@property (nonatomic, assign) BOOL hasCoupon;
/** 是否匹配优惠券 */
@property (nonatomic, assign) BOOL hasBestCoupon;
/** 优惠的金额 */
@property (nonatomic, assign) double discountMoney;
/** 优惠券id */
@property (nonatomic, copy) NSString *couponid;
/** 是否获取到优惠券 */
@property (nonatomic, assign) BOOL hasGetCoupon;
@end

@implementation HXBFin_creditorChange_buy_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = true;
//    [self getNewUserInfo];
    _couponTitle = @"优惠券";
    _discountTitle = @"";
    _balanceTitle = @"可用余额";
    [self buildUI];
    [self setUpDate];
    [self getBankCardLimit];
    [self hasBestCouponRequest];
    [self changeItemWithInvestMoney:_inputMoneyStr];
    self.bottomView.addBtnIsUseable = _inputMoneyStr.length;
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
    self.hxbBaseVCScrollView.hidden = YES;
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
            _topView.profitStr = @"预期收益0.00元";
            _topView.hiddenProfitLabel = NO;
        } else {
            _topView.isHiddenBtn = NO;
            _topView.hiddenProfitLabel = YES;
        }
        if (_type == HXB_Creditor) {
            _topView.keyboardType = UIKeyboardTypeDecimalPad; // 债转带小数点键盘
            if (self.availablePoint.doubleValue < 2 * self.minRegisterAmount.doubleValue) {
                _topView.totalMoney = [NSString stringWithFormat:@"%.2f", self.availablePoint.doubleValue];
                _inputMoneyStr = [NSString stringWithFormat:@"%.2f", self.availablePoint.doubleValue];
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
            weakSelf.bottomView.addBtnIsUseable = text.length;
            BOOL isFitToBuy = ((text.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue) ? NO : YES;
            if (text.doubleValue >= _minRegisterAmount.doubleValue && text.doubleValue <= _availablePoint.doubleValue && isFitToBuy) {
                if (_type == HXB_Plan) {
                    _couponTitle = @"优惠券";
                    [weakSelf getBESTCouponWithMoney:text];
                } else {
                    [weakSelf setUpArray];
                    [weakSelf changeItemWithInvestMoney:text];
                }
            } else {
                if ([text isEqualToString:@""]) {
                    _discountTitle = @"请选择优惠券";
                } else {
                    _discountTitle = @"未使用";
                }
                _couponid = @" ";
                _hasBestCoupon = NO;
                _couponTitle = @"优惠券";
                _handleDetailTitle = text;
                [weakSelf setUpArray];
                [weakSelf changeItemWithInvestMoney:text];
            }
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

- (void)changeItemWithInvestMoney:(NSString *)investMoney {
    self.topView.hiddenMoneyLabel = !self.cardModel.bankType;
    _inputMoneyStr = investMoney;
    double rechargeMoney = investMoney.doubleValue - _balanceMoneyStr.doubleValue - _discountMoney;
    if (rechargeMoney > 0.00) { // 余额不足的情况
        if ([self.viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
            if (rechargeMoney > self.viewModel.userInfoModel.userInfo.minChargeAmount) {
                self.bottomView.clickBtnStr = [NSString stringWithFormat:@"充值%.2f元并投资", rechargeMoney];
            } else {
                self.bottomView.clickBtnStr = [NSString stringWithFormat:@"充值%d.00元并投资", self.viewModel.userInfoModel.userInfo.minChargeAmount];
            }
            
        } else {
            self.bottomView.clickBtnStr = bankString;
        }
        _balanceTitle = @"可用余额（余额不足）";
    } else {
        self.bottomView.clickBtnStr = investString;
        _balanceTitle = @"可用余额";
        if (_type == HXB_Plan) {
            self.bottomView.clickBtnStr = investString;
        }
    }
    if (_type == HXB_Plan) {
        self.topView.profitStr = [NSString stringWithFormat:@"预期收益%@", [NSString hxb_getPerMilWithDouble:investMoney.floatValue*self.totalInterest.floatValue/100.0]];
    }
    [self setUpArray];
}

- (UIView *)footTableView {
    kWeakSelf
    _bottomView = [[HXBCreditorChangeBottomView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(200))];
    if (_type == HXB_Plan) {
        _bottomView.delegateLabelText = @"红利计划服务协议》,《网络借贷协议书";
    } else if (_type == HXB_Loan) {
        _bottomView.delegateLabelText = @"借款合同》,《网络借贷协议书";
    } else {
        _bottomView.delegateLabelText = @"债权转让及受让协议》,《网络借贷协议书";
    }
    _bottomView.delegateBlock = ^(NSInteger index) {
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
//            [HxbHUDProgress showTextWithMessage:@"暂无URL"];
            HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
            vc.URL = kHXB_Agreement_Hint;
            [weakSelf.navigationController pushViewController:vc animated:true];
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
        self.topView.profitStr = @"预期收益0.00元";
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
        [self getBESTCouponWithMoney:_inputMoneyStr];
        _topView.profitStr = [NSString stringWithFormat:@"预期收益%@元", _profitMoneyStr];
        [HxbHUDProgress showTextWithMessage:@"已超可加入金额"];
    }  else if (_inputMoneyStr.floatValue < _minRegisterAmount.floatValue) {
        _topView.totalMoney = [NSString stringWithFormat:@"%ld", (long)_minRegisterAmount.integerValue];
        _inputMoneyStr = _minRegisterAmount;
        _profitMoneyStr = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.floatValue*self.totalInterest.floatValue/100.0];
        [self getBESTCouponWithMoney:_inputMoneyStr];
        _topView.profitStr = [NSString stringWithFormat:@"预期收益%@元", _profitMoneyStr];
        [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
    } else {
        BOOL isFitToBuy = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue) ? NO : YES;
        if (isFitToBuy) {
            [self chooseBuyTypeWithSting:_btnLabelText];
        } else {
            [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
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
        _topView.totalMoney = [NSString stringWithFormat:@"%ld", (long)_minRegisterAmount.integerValue];
        _inputMoneyStr = _minRegisterAmount;
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"投资金额不足起投金额"];
    } else {
        BOOL isFitToBuy = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue) ? NO : YES;
        if (isFitToBuy) {
            [self chooseBuyTypeWithSting:_btnLabelText];
        } else {
            [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
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
    BOOL isFitToBuy = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue) ? NO : YES;
    if (_inputMoneyStr.length <= 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    }else{
        if ([_availablePoint doubleValue] == 0.00) { // 如果待转是0元的话，直接请求接口
            [self chooseBuyTypeWithSting:_btnLabelText];
            return;
        }
        if (isHasContainsNonzeroDecimals) {
            if ((long long)([_inputMoneyStr doubleValue] * 100) == (long long)([_availablePoint doubleValue] * 100)) {
                [self chooseBuyTypeWithSting:_btnLabelText];
                return;
            } else {
                if ([_inputMoneyStr doubleValue] < [_minRegisterAmount doubleValue]) {
                    _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.doubleValue];
                    _inputMoneyStr = _minRegisterAmount;
                    [self setUpArray];
                } else if ([_inputMoneyStr doubleValue] > _availablePoint.floatValue) {
                    _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _availablePoint.doubleValue];
                    _inputMoneyStr = _availablePoint;
                    [self setUpArray];
                    [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
                } else {
                    [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
                }
                return;
            }
        } else {
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
            } else if (!isFitToBuy) {
                [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
            } else if (_availablePoint.floatValue - _inputMoneyStr.floatValue < _minRegisterAmount.floatValue && _inputMoneyStr.doubleValue != _availablePoint.doubleValue) {
                [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"购买后剩余金额不能小于%@元", _minRegisterAmount]];
            } else {
                [self chooseBuyTypeWithSting:_btnLabelText];
            }
        }
    }
}

// 判断是什么投资类型（充值购买，余额购买、未绑卡）
- (void)chooseBuyTypeWithSting:(NSString *)buyType {
    if ([buyType containsString:@"充值"]) {
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
    double topupMoney = [_inputMoneyStr doubleValue] - [_balanceMoneyStr doubleValue] - _discountMoney;
    if (topupMoney < _viewModel.userInfoModel.userInfo.minChargeAmount) {
        [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"充值金额必须大于%d元", _viewModel.userInfoModel.userInfo.minChargeAmount]];
        topupMoney = _viewModel.userInfoModel.userInfo.minChargeAmount;
    }
    HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    NSLog(@"___%.2f", topupMoney);
    [accountRequest accountRechargeRequestWithRechargeAmount:[NSString stringWithFormat:@"%.2f", topupMoney] andWithAction:@"quickpay" andSuccessBlock:^(id responseObject) {
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
                    @"smsCode": pwd,
                    @"platform": @"IOS",
                    @"couponId": _couponid
                    };
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
                    @"tradPassword": pwd,
                    @"couponId": _couponid
                    };
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
            case kHXBCode_Enum_ProcessingField:
                return ;
            case 50000:
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
            case kHXBCode_Enum_ProcessingField:
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
            case kHXBCode_Enum_ProcessingField:
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
    cell.hasBestCoupon = _hasBestCoupon;
    if (indexPath.row == 0) {
        if (_type == HXB_Creditor) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.isDiscountRow = NO;
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.isDiscountRow = YES;
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.isDiscountRow = NO;
    }
    cell.titleStr = _titleArray[indexPath.row];
    cell.detailStr = _detailArray[indexPath.row];
    if ([_titleArray[indexPath.row] containsString:@"可用余额"]) {
        cell.isHeddenHine = YES;
    } else {
        cell.isHeddenHine = NO;
        if (_titleArray.count == 1) {
            cell.isHeddenHine  = YES;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        HXBChooseDiscountCouponViewController *chooseDiscountVC = [[HXBChooseDiscountCouponViewController alloc] init];
        chooseDiscountVC.delegate = self;
        chooseDiscountVC.planid = _loanId;
        chooseDiscountVC.investMoney = _inputMoneyStr ? _inputMoneyStr : @"";
        chooseDiscountVC.type = @"plan";
        chooseDiscountVC.couponid = _couponid;
        if (!_hasGetCoupon) {
            [self.navigationController pushViewController:chooseDiscountVC animated:YES];
        }
    }
}

- (void)chooseDiscountCouponViewController:(HXBChooseDiscountCouponViewController *)chooseDiscountCouponViewController didSendModel:(HXBCouponModel *)model {
    if (model) {
        _discountMoney = model.valueActual.doubleValue;
        double handleMoney = _inputMoneyStr.doubleValue - model.valueActual.doubleValue;
        _discountTitle = [NSString stringWithFormat:@"-%@", [NSString hxb_getPerMilWithDouble:model.valueActual.doubleValue]];
        _handleDetailTitle = [NSString stringWithFormat:@"%.2f", handleMoney];
        _couponTitle = [NSString stringWithFormat:@"优惠券（使用%@）", model.summaryTitle];
        _hasBestCoupon = YES;
        _chooseCoupon = model;
        _couponid = model.ID;
    } else {
        _discountMoney = 0.0;
        _hasBestCoupon = NO;
        _handleDetailTitle = [NSString stringWithFormat:@"%.2f", _inputMoneyStr.doubleValue];
        _couponTitle = @"优惠券";
        _discountTitle = @"请选择优惠券";
        _couponid = @"不使用优惠券";
    }
    [self changeItemWithInvestMoney:_inputMoneyStr];
    [self setUpArray];
}


- (void)setUpDate {
    if (_type == HXB_Plan) {
        _topView.creditorMoney = [NSString stringWithFormat:@"本期剩余加入上限%@", [NSString hxb_getPerMilWithIntegetNumber:_availablePoint.doubleValue]];
    } else if (_type == HXB_Loan) {
        _topView.creditorMoney = [NSString stringWithFormat:@"标的剩余金额%@", [NSString hxb_getPerMilWithIntegetNumber:_availablePoint.doubleValue]];
    } else {
        _topView.creditorMoney = [NSString stringWithFormat:@"待转让金额%@", [NSString hxb_getPerMilWithDouble:_availablePoint.doubleValue]];
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
        [self.hxbBaseVCScrollView reloadData];
    } andFailure:^(NSError *error) {
        
    }];
}

// 匹配最优优惠券
- (void)getBESTCouponWithMoney:(NSString *)money {
    NSDictionary *dic_post = @{
                               @"id": _loanId,
                               @"amount": money,
                               @"type": @"plan"
                               };
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    HXBFin_creditorChange_TableViewCell *cell = [self.hxbBaseVCScrollView cellForRowAtIndexPath:indexpath];
    cell.isStartAnimation = YES;
    _hasGetCoupon = YES;
    self.bottomView.addBtnIsUseable = NO;
    [HXBChooseCouponViewModel requestBestCouponWithParams:dic_post andSuccessBlock:^(HXBBestCouponModel *model) {
        cell.isStartAnimation = NO;
        _hasGetCoupon = NO;
        self.bottomView.addBtnIsUseable = YES;
        _discountTitle = nil;
        self.model = model;
        if (model.hasCoupon && model.bestCoupon) { // 只有有优惠券hasCoupon都返回1，没有匹配到bestCoupon为空，所有有优惠券，且匹配到了，就抵扣或者满减
            _discountMoney = model.bestCoupon.valueActual.doubleValue;
            double handleMoney = money.doubleValue - model.bestCoupon.valueActual.doubleValue;
            _discountTitle = [NSString stringWithFormat:@"-%@", [NSString hxb_getPerMilWithDouble:model.bestCoupon.valueActual.doubleValue]];
            _handleDetailTitle = [NSString stringWithFormat:@"%.2f", handleMoney];
            _couponTitle = [NSString stringWithFormat:@"优惠券（使用%@）", model.bestCoupon.summaryTitle];
            _hasBestCoupon = YES;
            _couponid = model.bestCoupon.ID;
        } else {
            _hasBestCoupon = NO;
            _handleDetailTitle = money;
            _discountTitle = @"请选择优惠券";
            _couponTitle = @"优惠券";
            _couponid = @" ";
        }
        [self setUpArray];
        [self changeItemWithInvestMoney:money];
    } andFailureBlock:^(NSError *error) {
        _hasBestCoupon = NO;
        cell.isStartAnimation = NO;
        _discountTitle = @"请选择优惠券";
        [self setUpArray];
        [self changeItemWithInvestMoney:money];
    }];
    
}

- (void)hasBestCouponRequest {
    NSDictionary *dic_post = @{
                               @"id": _loanId,
                               @"amount": @"0",
                               @"type": @"plan"
                               };
    [HXBChooseCouponViewModel requestBestCouponWithParams:dic_post andSuccessBlock:^(HXBBestCouponModel *model) {
        self.hxbBaseVCScrollView.hidden = NO;
        _discountTitle = nil;
        self.model = model;
        _hasCoupon = model.hasCoupon;
        if (model.hasCoupon) {
            _discountTitle = @"请选择优惠券";
        } else {
            _discountTitle = @"暂无可用优惠券";
        }
        [self setUpArray];
    } andFailureBlock:^(NSError *error) {
        _discountTitle = @"暂无可用优惠券";
    }];
    
}

// 获取银行限额
- (void)getBankCardLimit {
    [HXBFin_Buy_ViewModel requestForBankCardSuccessBlock:^(HXBBankCardModel *model) {
        self.hxbBaseVCScrollView.tableHeaderView = nil;
        self.cardModel = model;
        if (_type == HXB_Plan) {
            if (self.cardModel.bankType) {
                self.topView.height = kScrAdaptationH750(370);
            } else {
                self.topView.height = kScrAdaptationH750(300);
            }
        } else {
            if (self.cardModel.bankType) {
                self.topView.height = kScrAdaptationH750(300);
            } else {
                self.topView.height = kScrAdaptationH750(230);
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
    if (_type == HXB_Plan || _type == HXB_Loan) {
        self.titleArray = @[_couponTitle, @"支付金额", _balanceTitle];
        self.detailArray = @[_discountTitle,  [NSString hxb_getPerMilWithDouble: _handleDetailTitle.doubleValue],  [NSString hxb_getPerMilWithDouble: _balanceMoneyStr.doubleValue]];
    } else {
        self.titleArray = @[@"应付金额", _balanceTitle];
        self.detailArray = @[[NSString hxb_getPerMilWithDouble: _handleDetailTitle.doubleValue],  [NSString hxb_getPerMilWithDouble: _balanceMoneyStr.doubleValue]];
    }
    [self.hxbBaseVCScrollView reloadData];
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

- (HXBBestCouponModel *)model {
    if (!_model) {
        _model = [[HXBBestCouponModel alloc] init];
    }
    return _model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

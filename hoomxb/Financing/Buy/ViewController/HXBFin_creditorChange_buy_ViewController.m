//
//  HXBFin_creditorChange_buy_ViewController.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//债转

#import "HXBFin_creditorChange_buy_ViewController.h"
#import "HXBCreditorChangeTopView.h"
#import "HXBCreditorChangeBottomView.h"
#import "HXBFin_creditorChange_TableViewCell.h"
#import "HXBFinanctingRequest.h"
#import "HXBFBase_BuyResult_VC.h"
#import "HxbMyTopUpViewController.h"
#import "HXBVerificationCodeAlertVC.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HXBChooseDiscountCouponViewController.h"
#import "HXBTransactionPasswordView.h"
#import "HXBRootVCManager.h"
#import "HXBFincreditorChangebuyViewModel.h"

static NSString *const bankString = @"绑定银行卡";

@interface HXBFin_creditorChange_buy_ViewController ()<UITableViewDelegate, UITableViewDataSource, HXBChooseDiscountCouponViewControllerDelegate>
/** topView */
@property (nonatomic, strong) HXBCreditorChangeTopView *topView;
/** bottomView*/
@property (nonatomic, strong) HXBCreditorChangeBottomView *bottomView;
/** 短验弹框 */
@property (nonatomic, strong) HXBVerificationCodeAlertVC *alertVC;
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
/** 优惠券金额 */
@property (nonatomic, copy) NSString *discountTitle;
/** 应付金额detailLabel */
@property (nonatomic, copy) NSString *handleDetailTitle;
/** 可用余额TextLabel */
@property (nonatomic, copy) NSString *balanceTitle;
// 是否符合标的等级购买规则
@property (nonatomic, assign) BOOL isMatchBuy;
// 是否选中同意选项
@property (nonatomic, assign) BOOL isSelectLimit;
/** 可用余额detailLabel */
@property (nonatomic, copy) NSString *balanceDetailTitle;
@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);
/** 发送请求的任务 */
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
// 是否超出投资限制// 是否超出投资限制
@property (nonatomic, assign) BOOL isExceedLimitInvest;
@property (nonatomic, strong) HXBTransactionPasswordView *passwordView;
@property (nonatomic, strong) HXBFincreditorChangebuyViewModel *viewModel;


@end

@implementation HXBFin_creditorChange_buy_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    _discountTitle = @"暂无可用优惠券";
    _balanceTitle = @"可用余额";
    kWeakSelf
    _viewModel = [[HXBFincreditorChangebuyViewModel alloc] initWithBlock:^UIView *{
        if (weakSelf.presentedViewController) {
            return weakSelf.presentedViewController.view;
        } else {
            return weakSelf.view;
        }
    }];
    _isMatchBuy = [self.userInfoViewModel.userInfoModel.userAssets.userRisk containsObject:self.riskType];
    _balanceMoneyStr = self.userInfoViewModel.userInfoModel.userAssets.availablePoint;
    
    [self buildUI];
    [self isMatchToBuyWithMoney:_inputMoneyStr];
    self.bottomView.addBtnIsUseable = _inputMoneyStr.length;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.isSelectLimit = NO;
    [self getBankCardLimit];
}

- (void)dealloc {
    [self.hxbBaseVCScrollView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
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

- (void)buildUI {
    self.hxbBaseVCScrollView = [[UITableView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight) style:(UITableViewStylePlain)];

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

- (void)changeItemWithInvestMoney:(NSString *)investMoney {
    [self isMatchToBuyWithMoney:investMoney];
    _handleDetailTitle = [NSString stringWithFormat:@"%.2f", investMoney.doubleValue];
    self.topView.hiddenMoneyLabel = !self.cardModel.bankType;
    _inputMoneyStr = investMoney;
    double rechargeMoney = investMoney.doubleValue - _balanceMoneyStr.doubleValue;
    if (rechargeMoney > 0.00) { // 余额不足的情况
        if ([self.userInfoViewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
            self.bottomView.clickBtnStr = [NSString stringWithFormat:@"充值%.2f元并出借", rechargeMoney];
        } else {
            self.bottomView.clickBtnStr = bankString;
        }
        _balanceTitle = @"可用余额（余额不足）";
    } else {
        self.bottomView.clickBtnStr = @"立即出借";
        _balanceTitle = @"可用余额";
    }
    [self setUpArray];
}

// 购买债权
- (void)requestForCreditor {
    /*
     _availablePoint             待转让金额
     _minRegisterAmount          最低起投金额
     _registerMultipleAmount     最低起投此金额多少倍
     _inputMoneyStr              输入的金额
     */
    BOOL isHasContainsNonzeroDecimals = (long long)([_inputMoneyStr doubleValue] * 100) % 100 != 0 ? YES:NO;//YES:含非零小数
    BOOL isFitToBuy = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue) ? NO : YES;
    if (_inputMoneyStr.length <= 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入出借金额"];
    }else{
        if ([_availablePoint doubleValue] == 0.00) { // 如果待转是0元的话，直接请求接口
            if (self.isExceedLimitInvest && !_isSelectLimit) {
                [HxbHUDProgress showTextWithMessage:@"请勾选同意风险提示"];
                return;
            }
            [self chooseBuyTypeWithSting:_btnLabelText];
            return;
        }
        if (isHasContainsNonzeroDecimals) {
            if ((long long)([_inputMoneyStr doubleValue] * 100) == (long long)([_availablePoint doubleValue] * 100)) {
                if (self.isExceedLimitInvest && !_isSelectLimit) {
                    [HxbHUDProgress showTextWithMessage:@"请勾选同意风险提示"];
                    return;
                }
                [self chooseBuyTypeWithSting:_btnLabelText];
                return;
            } else {
                if ([_inputMoneyStr doubleValue] < [_minRegisterAmount doubleValue]) {
                    _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.doubleValue];
                    _inputMoneyStr = _minRegisterAmount;
                    [self setUpArray];
                    [self changeItemWithInvestMoney:_inputMoneyStr];
                    [HxbHUDProgress showTextWithMessage:@"出借金额不足起投金额"];
                } else if ([_inputMoneyStr doubleValue] > _availablePoint.floatValue) {
                    _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _availablePoint.doubleValue];
                    _inputMoneyStr = _availablePoint;
                    [self setUpArray];
                    [self changeItemWithInvestMoney:_inputMoneyStr];
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
                [self changeItemWithInvestMoney:_inputMoneyStr];
                [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
            } else if (_inputMoneyStr.floatValue < _minRegisterAmount.floatValue) {
                _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.doubleValue];
                _inputMoneyStr = _minRegisterAmount;
                [self setUpArray];
                [self changeItemWithInvestMoney:_inputMoneyStr];
                [HxbHUDProgress showTextWithMessage:@"出借金额不足起投金额"];
            } else if (!isFitToBuy) {
                [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
            } else if (_availablePoint.floatValue - _inputMoneyStr.floatValue < _minRegisterAmount.floatValue && _inputMoneyStr.doubleValue != _availablePoint.doubleValue) {
                [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"购买后剩余金额不能小于%@元", _minRegisterAmount]];
            } else {
                if (self.isExceedLimitInvest && !_isSelectLimit) {
                    [HxbHUDProgress showTextWithMessage:@"请勾选同意风险提示"];
                    return;
                }
                [self chooseBuyTypeWithSting:_btnLabelText];
            }
        }
    }
}

// 判断是什么投资类型（充值购买，余额购买、未绑卡）
- (void)chooseBuyTypeWithSting:(NSString *)buyType {
    kWeakSelf
    if ([buyType containsString:@"充值"]) {
        [self fullAddtionFunc];
    } else if ([buyType isEqualToString:bankString]) {
        HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc] init];
        withdrawCardViewController.block = ^(BOOL isBlindSuccess) {
            if (isBlindSuccess) {
                weakSelf.hasBindCard = @"1";
                [weakSelf getNewUserInfo];
            } else {
                weakSelf.hasBindCard = @"0";
            }
        };
        withdrawCardViewController.title = @"绑卡";
        withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
        [self.navigationController pushViewController:withdrawCardViewController animated:YES];
    } else {
        [self alertPassWord];
    }
}

- (void)fullAddtionFunc {
    kWeakSelf
    double topupMoney = [_inputMoneyStr doubleValue] - [_balanceMoneyStr doubleValue];
    NSString *rechargeMoney =_userInfoViewModel.userInfoModel.userInfo.minChargeAmount_new;
    if (topupMoney < _userInfoViewModel.userInfoModel.userInfo.minChargeAmount) {
        HXBGeneralAlertVC *alertVC = [[HXBGeneralAlertVC alloc] initWithMessageTitle:@"" andSubTitle:[NSString stringWithFormat:@"单笔充值最低金额%@元，\n是否确认充值？", rechargeMoney] andLeftBtnName:@"取消" andRightBtnName:@"确认充值" isHideCancelBtn:YES isClickedBackgroundDiss:NO];
        alertVC.isCenterShow = YES;
        [alertVC setRightBtnBlock:^{
            [weakSelf sendSmsCodeWithMoney:weakSelf.userInfoViewModel.userInfoModel.userInfo.minChargeAmount];
        }];
        [self presentViewController:alertVC animated:NO completion:nil];
    } else {
        [self sendSmsCodeWithMoney:topupMoney];
    }
}

- (void)alertPassWord {
    kWeakSelf
    _buyType = @"balance";
    self.passwordView = [[HXBTransactionPasswordView alloc] init];
    [self.passwordView showInView:self.view];
    self.passwordView.getTransactionPasswordBlock = ^(NSString *password) {
        NSDictionary *dic = nil;
        dic = @{@"amount": weakSelf.inputMoneyStr,
                @"buyType": weakSelf.buyType,
                @"willingToBuy": [NSString stringWithFormat:@"%d", _isSelectLimit],
                @"tradPassword": password,
                };
        [weakSelf buyCreditorWithDic:dic];
    };
}

- (void)sendSmsCodeWithMoney:(double)topupMoney {
    kWeakSelf
    if (self.cardModel.securyMobile.length) {
        [self alertSmsCodeWithMoney:topupMoney];
    } else {
        [_viewModel getBankCardWithHud:YES resultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                weakSelf.hxbBaseVCScrollView.tableHeaderView = nil;
                weakSelf.cardModel = weakSelf.viewModel.bankCardModel;
                if ([weakSelf.hasBindCard isEqualToString:@"1"]) {
                    weakSelf.topView.height = kScrAdaptationH750(topView_bank_high);
                    if (!weakSelf.cardModel) {
                        weakSelf.topView.cardStr = @"--限额：单笔-- 单日--";
                    } else {
                        weakSelf.topView.cardStr = [NSString stringWithFormat:@"%@%@", weakSelf.cardModel.bankType, weakSelf.cardModel.quota];
                        [weakSelf alertSmsCodeWithMoney:topupMoney];
                    }
                    weakSelf.topView.hasBank = YES;
                } else {
                    weakSelf.topView.height = kScrAdaptationH750(topView_high);
                    weakSelf.topView.hasBank = NO;
                }
                weakSelf.hxbBaseVCScrollView.tableHeaderView = weakSelf.topView;
                [weakSelf.hxbBaseVCScrollView reloadData];
            }
        }];
    }
}

- (void)alertSmsCodeWithMoney:(double)topupMoney {
    kWeakSelf
    
    [_viewModel getVerifyCodeRequesWithRechargeAmount:[NSString stringWithFormat:@"%.2f", topupMoney] andWithType:@"sms" andWithAction:@"buy" andCallbackBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            weakSelf.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [weakSelf.cardModel.securyMobile replaceStringWithStartLocation:3 lenght:4]];
            [weakSelf alertSmsCode];
            [weakSelf.alertVC.verificationCodeAlertView disEnabledBtns];
        }
        else {
            [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
        }
    }];
}

- (void)alertSmsCode {
    if (!self.presentedViewController) {
        self.alertVC = [[HXBVerificationCodeAlertVC alloc] init];
        self.alertVC.isCleanPassword = YES;
        double rechargeMoney = [_inputMoneyStr doubleValue] - [_balanceMoneyStr doubleValue];
        self.alertVC.messageTitle = @"请输入短信验证码";
        _buyType = @"recharge"; // 弹出短验，都是充值购买
        self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [self.cardModel.securyMobile replaceStringWithStartLocation:3 lenght:4]];
        kWeakSelf
        self.alertVC.sureBtnClick = ^(NSString *pwd) {
            [weakSelf.alertVC.view endEditing:YES];
            NSDictionary *dic = nil;
            dic = @{@"amount": [NSString stringWithFormat:@"%.2f", weakSelf.inputMoneyStr.doubleValue],
                    @"buyType": weakSelf.buyType,
                    @"balanceAmount": weakSelf.balanceMoneyStr,
                    @"willingToBuy": [NSString stringWithFormat:@"%d", _isSelectLimit],
                    @"smsCode": pwd};
            [weakSelf buyCreditorWithDic:dic];
        };
        self.alertVC.getVerificationCodeBlock = ^{
            [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
            [weakSelf sendSmsCodeWithMoney:rechargeMoney];
        };
        self.alertVC.getSpeechVerificationCodeBlock = ^{
            //获取语音验证码 注意参数
            [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
            [weakSelf sendSmsCodeWithMoney:rechargeMoney];
        };
        self.alertVC.cancelBtnClickBlock = ^{
        };
        [self presentViewController:_alertVC animated:NO completion:nil];
    }
}

// 购买债权
- (void)buyCreditorWithDic:(NSDictionary *)dic {
    kWeakSelf
    [_viewModel loanTransformBuyReslutWithLoanID:_loanId parameter:dic resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            HXBFBase_BuyResult_VC *loanBuySuccessVC = [[HXBFBase_BuyResult_VC alloc] init];
            loanBuySuccessVC.inviteButtonTitle = weakSelf.viewModel.resultModel.inviteActivityDesc;
            loanBuySuccessVC.isShowInviteBtn = weakSelf.viewModel.resultModel.isInviteActivityShow;
            loanBuySuccessVC.title = @"购买成功";
            loanBuySuccessVC.buy_title = @"购买成功";
            loanBuySuccessVC.imageName = @"successful";
            loanBuySuccessVC.buy_ButtonTitle = @"查看我的出借";
            loanBuySuccessVC.buy_description = weakSelf.viewModel.resultModel.isRepayed ? @"公允利息为您垫付的转让人持有天利息，还款人将会在下个还款日予以返回" : @"公允利息：当期已还时，债权人将多收利息进行补偿，均放入出借本金";
            loanBuySuccessVC.massage_Left_StrArray = @[@"下一还款日", @"出借金额", @"实际买入本金", @"公允利息"];
            loanBuySuccessVC.massage_Right_StrArray = @[weakSelf.viewModel.resultModel.nextRepayDate_new, weakSelf.viewModel.resultModel.buyAmount_new, weakSelf.viewModel.resultModel.principal_new, weakSelf.viewModel.resultModel.interest_new];
            [loanBuySuccessVC clickButtonWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
            [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
            [weakSelf.navigationController pushViewController:loanBuySuccessVC animated:YES];
        } else {
            HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc] init];
            failViewController.title = @"出借失败";
            switch (weakSelf.viewModel.errorCode) {
                case kBuy_Result:
                    failViewController.imageName = @"failure";
                    failViewController.buy_title = @"出借失败";
                    failViewController.buy_description = weakSelf.viewModel.errorMessage;
                    failViewController.buy_ButtonTitle = @"重新出借";
                    break;
                
                case kBuy_Processing:
                    failViewController.imageName = @"outOffTime";
                    failViewController.buy_title = @"处理中";
                    failViewController.buy_description = weakSelf.viewModel.errorMessage;
                    failViewController.buy_ButtonTitle = @"重新出借";
                    break;
                    
                default:    
                    [weakSelf.passwordView clearUpPassword];
                    return;
            }
            [failViewController clickButtonWithBlock:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];  //跳回理财页面
            }];
            [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
            [weakSelf.navigationController pushViewController:failViewController animated:YES];
        }
    }];
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
    cell.hasBestCoupon = NO;
    cell.isStartAnimation = NO;
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.isDiscountRow = YES;
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
        chooseDiscountVC.planid = @"";
        chooseDiscountVC.investMoney = _inputMoneyStr ? _inputMoneyStr : @"";
        chooseDiscountVC.type = @"plan";
        chooseDiscountVC.couponid = @"";
        [self.navigationController pushViewController:chooseDiscountVC animated:YES];
    }
}

- (void)chooseDiscountCouponViewController:(HXBChooseDiscountCouponViewController *)chooseDiscountCouponViewController didSendModel:(HXBCouponModel *)model {
}

// 获取银行限额
static const NSInteger topView_bank_high = 300;
static const NSInteger topView_high = 230;
- (void)getBankCardLimit {
    if ([self.hasBindCard isEqualToString:@"1"]) {
        self.topView.height = kScrAdaptationH750(topView_bank_high);
        kWeakSelf
        [_viewModel getBankCardWithHud:YES resultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                weakSelf.cardModel = weakSelf.viewModel.bankCardModel;
                if (!weakSelf.cardModel) {
                    weakSelf.topView.cardStr = @"--限额：单笔-- 单日--";
                } else {
                    weakSelf.topView.cardStr = [NSString stringWithFormat:@"%@%@", weakSelf.cardModel.bankType, weakSelf.cardModel.quota];
                }
                [weakSelf setUpArray];
                [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
                weakSelf.topView.hasBank = YES;
                weakSelf.hxbBaseVCScrollView.tableHeaderView = weakSelf.topView;
                [weakSelf.hxbBaseVCScrollView reloadData];
                weakSelf.hxbBaseVCScrollView.hidden = NO;
            }
        }];
    } else {
        self.topView.height = kScrAdaptationH750(topView_high);
        self.topView.hasBank = NO;
        [self setUpArray];
        [self changeItemWithInvestMoney:_inputMoneyStr];
        self.hxbBaseVCScrollView.tableHeaderView = self.topView;
        [self.hxbBaseVCScrollView reloadData];
        self.hxbBaseVCScrollView.hidden = NO;
    }
}

// 获取用户信息
- (void)getNewUserInfo {
    kWeakSelf
    [_viewModel downLoadUserInfo:NO resultBlock:^(BOOL isSuccess) {
        if(isSuccess) {
            weakSelf.userInfoViewModel = weakSelf.viewModel.userInfoModel;
            weakSelf.balanceMoneyStr = weakSelf.userInfoViewModel.userInfoModel.userAssets.availablePoint;
            [weakSelf.hxbBaseVCScrollView reloadData];
            [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
        }
        else {
            [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
        }
    }];
}


- (void)setUpArray {
    if (!_profitMoneyStr) {
        _profitMoneyStr = @"";
    }
    self.titleArray = @[@"优惠券", @"应付金额", _balanceTitle];
    self.detailArray = @[_discountTitle,[NSString hxb_getPerMilWithDouble: _handleDetailTitle.doubleValue],  [NSString hxb_getPerMilWithDouble: _balanceMoneyStr.doubleValue]];
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

- (UIView *)topView {
    kWeakSelf
    if (!_topView) {
        _topView = [[HXBCreditorChangeTopView alloc] initWithFrame:CGRectZero];
        _topView.isHiddenBtn = NO;
        _topView.hiddenProfitLabel = YES;
        _topView.keyboardType = UIKeyboardTypeDecimalPad; // 债转带小数点键盘
        if (self.availablePoint.doubleValue < 2 * self.minRegisterAmount.doubleValue) {
            _topView.totalMoney = [NSString stringWithFormat:@"%.2f", self.availablePoint.doubleValue];
            _inputMoneyStr = [NSString stringWithFormat:@"%.2f", self.availablePoint.doubleValue];
            _topView.disableKeyBorad = YES;
            _topView.disableBtn = YES;
            [self isMatchToBuyWithMoney:_inputMoneyStr];
        } else {
            _topView.disableKeyBorad = NO;
            _topView.disableBtn = NO;
        }
        _topView.creditorMoney = [NSString stringWithFormat:@"待转让金额%@", [NSString hxb_getPerMilWithDouble:_availablePoint.doubleValue]];
        _topView.placeholderStr = _placeholderStr;
        // 输入框值变化
        _topView.changeBlock = ^(NSString *text) {
            [weakSelf investMoneyWithText:text];
        };
        // 点击一键购买执行的方法
        _topView.block = ^{
            NSString *topupStr = weakSelf.availablePoint;
            weakSelf.topView.totalMoney = [NSString stringWithFormat:@"%.2f", topupStr.doubleValue];
            weakSelf.inputMoneyStr = topupStr;
            weakSelf.handleDetailTitle = topupStr;
            weakSelf.bottomView.addBtnIsUseable = topupStr.length;
            [weakSelf changeItemWithInvestMoney:topupStr];
            [weakSelf setUpArray];
        };
    }
    return _topView;
}

- (void)investMoneyWithText:(NSString *)text {
    self.bottomView.addBtnIsUseable = text.length;
    BOOL isFitToBuy = ((text.integerValue - self.minRegisterAmount.integerValue) % self.registerMultipleAmount.integerValue) ? NO : YES;
    if (text.doubleValue >= self.minRegisterAmount.doubleValue && text.doubleValue <= self.availablePoint.doubleValue && isFitToBuy) {
        [self changeItemWithInvestMoney:text];
        [self setUpArray];
    } else {
        self.discountTitle = @"未使用";
        self.handleDetailTitle = text;
        [self changeItemWithInvestMoney:text];
        [self setUpArray];
    }
}

// 根据金额匹配是否展示风险协议
- (void)isMatchToBuyWithMoney:(NSString *)money {
    self.isSelectLimit = NO;
    if (_isMatchBuy) {
        self.bottomView.isShowRiskView = (money.doubleValue > self.userInfoViewModel.userInfoModel.userAssets.userRiskAmount.doubleValue - self.userInfoViewModel.userInfoModel.userAssets.holdingAmount);
        self.isExceedLimitInvest = (money.doubleValue > self.userInfoViewModel.userInfoModel.userAssets.userRiskAmount.doubleValue - self.userInfoViewModel.userInfoModel.userAssets.holdingAmount);
    } else {
        self.bottomView.isShowRiskView = YES;
        self.isExceedLimitInvest = YES;
    }
}

- (UIView *)footTableView {
    kWeakSelf
    _bottomView = [[HXBCreditorChangeBottomView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(200))];
    _bottomView.delegateLabelText = @"债权转让及受让协议》,《网络借贷协议书";
    _bottomView.delegateBlock = ^(NSInteger index) {
        if (index == 1) {
            [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_LoanTruansferURL] fromController:weakSelf];
        } else {
            [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Agreement_Hint] fromController:weakSelf];
        }
    };
    _bottomView.riskBlock = ^(BOOL selectStatus) {
        weakSelf.isSelectLimit = selectStatus;
    };
    _bottomView.addBlock = ^(NSString *investMoney) {
        weakSelf.btnLabelText = investMoney;
        [weakSelf.topView endEditing:YES];
        [weakSelf requestForCreditor];
    };
    return _bottomView;
}
@end

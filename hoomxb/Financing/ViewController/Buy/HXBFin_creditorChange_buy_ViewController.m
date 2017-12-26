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
#import "HXBFin_Plan_BuyViewModel.h"
#import "HxbMyTopUpViewController.h"
#import "HXBFin_Buy_ViewModel.h"
#import "HXBVerificationCodeAlertVC.h"
#import "HXBOpenDepositAccountRequest.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HXBFin_LoanTruansfer_BuyResoutViewModel.h"
#import "HXBChooseDiscountCouponViewController.h"
#import "HXBTransactionPasswordView.h"

static NSString *const bankString = @"绑定银行卡";

@interface HXBFin_creditorChange_buy_ViewController ()<UITableViewDelegate, UITableViewDataSource, HXBChooseDiscountCouponViewControllerDelegate>
/** topView */
@property (nonatomic, strong) HXBCreditorChangeTopView *topView;
/** bottomView*/
@property (nonatomic, strong) HXBCreditorChangeBottomView *bottomView;
// 我的信息
@property (nonatomic, strong) HXBRequestUserInfoViewModel *viewModel;
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
/** 可用余额detailLabel */
@property (nonatomic, copy) NSString *balanceDetailTitle;
@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);
/** 发送请求的任务 */
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) HXBTransactionPasswordView *passwordView;

@end

@implementation HXBFin_creditorChange_buy_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    _discountTitle = @"暂无可用优惠券";
    _balanceTitle = @"可用余额";
    [self buildUI];
    [self getBankCardLimit];
    
    self.bottomView.addBtnIsUseable = _inputMoneyStr.length;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self getBankCardLimit];
    [self getNewUserInfo];
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
    _handleDetailTitle = [NSString stringWithFormat:@"%.2f", investMoney.doubleValue];
    self.topView.hiddenMoneyLabel = !self.cardModel.bankType;
    _inputMoneyStr = investMoney;
    double rechargeMoney = investMoney.doubleValue - _balanceMoneyStr.doubleValue;
    if (rechargeMoney > 0.00) { // 余额不足的情况
        if ([self.viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"]) {
            self.bottomView.clickBtnStr = [NSString stringWithFormat:@"充值%.2f元并投资", rechargeMoney];
        } else {
            self.bottomView.clickBtnStr = bankString;
        }
        _balanceTitle = @"可用余额（余额不足）";
    } else {
        self.bottomView.clickBtnStr = @"立即投资";
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
                    [self changeItemWithInvestMoney:_inputMoneyStr];
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
                [self changeItemWithInvestMoney:_inputMoneyStr];
                [self setUpArray];
                [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
            } else if (_inputMoneyStr.floatValue < _minRegisterAmount.floatValue) {
                _topView.totalMoney = [NSString stringWithFormat:@"%.2f", _minRegisterAmount.doubleValue];
                _inputMoneyStr = _minRegisterAmount;
                [self changeItemWithInvestMoney:_inputMoneyStr];
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
    double topupMoney = [_inputMoneyStr doubleValue] - [_balanceMoneyStr doubleValue];
    NSString *rechargeMoney =_viewModel.userInfoModel.userInfo.minChargeAmount_new;
    if (topupMoney < _viewModel.userInfoModel.userInfo.minChargeAmount) {
        HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:nil Massage:[NSString stringWithFormat:@"单笔充值最低金额%@元，\n是否确认充值？", rechargeMoney] force:2 andLeftButtonMassage:@"取消" andRightButtonMassage:@"确认充值"];
        alertVC.isCenterShow = YES;
        [alertVC setClickXYRightButtonBlock:^{
            [weakSelf sendSmsCodeWithMoney:weakSelf.viewModel.userInfoModel.userInfo.minChargeAmount];
        }];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        [self sendSmsCodeWithMoney:topupMoney];
    }
}

- (void)alertSmsCode {
    if (!self.presentedViewController) {
        self.alertVC = [[HXBVerificationCodeAlertVC alloc] init];
        self.alertVC.isCleanPassword = YES;
        double rechargeMoney = [_inputMoneyStr doubleValue] - [_balanceMoneyStr doubleValue];
        self.alertVC.messageTitle = @"请输入验证码";
        _buyType = @"recharge"; // 弹出短验，都是充值购买
        self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [self.cardModel.securyMobile replaceStringWithStartLocation:3 lenght:4]];
        kWeakSelf
        self.alertVC.sureBtnClick = ^(NSString *pwd) {
            [weakSelf.alertVC.view endEditing:YES];
            NSDictionary *dic = nil;
            dic = @{@"amount": [NSString stringWithFormat:@"%.2f", _inputMoneyStr.doubleValue],
                    @"buyType": _buyType,
                    @"balanceAmount": _balanceMoneyStr,
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

- (void)alertPassWord {
    kWeakSelf
    _buyType = @"balance";
    self.passwordView = [[HXBTransactionPasswordView alloc] init];
    [self.passwordView showInView:self.view];
    self.passwordView.getTransactionPasswordBlock = ^(NSString *password) {
        NSDictionary *dic = nil;
        dic = @{@"amount": weakSelf.inputMoneyStr,
                @"buyType": weakSelf.buyType,
                @"tradPassword": password,
                };
        [weakSelf buyCreditorWithDic:dic];
    };
}

- (void)sendSmsCodeWithMoney:(double)topupMoney {
    kWeakSelf
    HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [accountRequest accountRechargeRequestWithRechargeAmount:[NSString stringWithFormat:@"%.2f", topupMoney] andWithType:@"sms" andWithAction:@"buy" andSuccessBlock:^(id responseObject) {
        weakSelf.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [weakSelf.cardModel.securyMobile replaceStringWithStartLocation:3 lenght:4]];
        [weakSelf alertSmsCode];
        [weakSelf.alertVC.verificationCodeAlertView disEnabledBtns];
    } andFailureBlock:^(NSError *error) {
        NSInteger errorCode = 0;
        if ([error isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)error;
            errorCode = [dic[@"status"] integerValue];
        }else{
            errorCode = error.code;
        }
        if (errorCode != kHXBCode_Success) {
            [weakSelf.alertVC.verificationCodeAlertView enabledBtns];
        }
    }];
}

// 购买债权
- (void)buyCreditorWithDic:(NSDictionary *)dic {
    kWeakSelf
    [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansfer_confirmBuyReslutWithLoanID:_loanId parameter:dic andSuccessBlock:^(HXBFin_LoanTruansfer_BuyResoutViewModel *model) {
        ///加入成功
        HXBFBase_BuyResult_VC *loanBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
        loanBuySuccessVC.inviteButtonTitle = model.inviteActivityDesc;
        loanBuySuccessVC.isShowInviteBtn = model.isInviteActivityShow;
        loanBuySuccessVC.title = @"购买成功";
        loanBuySuccessVC.buy_title = @"购买成功";
        loanBuySuccessVC.imageName = @"successful";
        loanBuySuccessVC.massage_Left_StrArray = @[@"下一还款日", @"投资金额", @"实际买入本金", @"公允利息"];
        loanBuySuccessVC.massage_Right_StrArray = @[model.nextRepayDate_new, model.buyAmount_new, model.principal_new, model.interest_new];
        if (model.isRepayed) {
            loanBuySuccessVC.buy_description = @"公允利息为您垫付的转让人持有天利息，还款人将会在下个还款日予以返回";
        } else {
            loanBuySuccessVC.buy_description = @"公允利息：当期已还时，债权人将多收利息进行补偿，均放入投资本金";
        }
        loanBuySuccessVC.buy_ButtonTitle = @"查看我的投资";
        [loanBuySuccessVC clickButtonWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }];
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [weakSelf.navigationController pushViewController:loanBuySuccessVC animated:YES];
        
    } andFailureBlock:^(NSString *errorMessage, NSInteger status) {
        
        HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc]init];
        failViewController.title = @"投资结果";
        switch (status) {
                // 加入失败跳转到失败页（3408:余额不足， 999:已售罄， 1:普通错误状态码）
            case kBuy_Result:
                failViewController.imageName = @"failure";
                failViewController.buy_title = @"加入失败";
                failViewController.buy_description = errorMessage;
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
                
                // 处理中(3016:恒丰银行处理中 -999:处理中)
            case kBuy_Processing:
                failViewController.imageName = @"outOffTime";
                failViewController.buy_title = @"处理中";
                failViewController.buy_description = errorMessage;
                failViewController.buy_ButtonTitle = @"重新投资";
                break;
                
                // 弹toast（3014：交易密码错误， 3015：短验错误， 3413：产品购买过于频繁）
            default:
                [weakSelf.passwordView clearUpPassword];
                return;
        }
        [failViewController clickButtonWithBlock:^{
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];  //跳回理财页面
        }];
        [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
        [weakSelf.navigationController pushViewController:failViewController animated:YES];
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


// 获取用户信息
- (void)getNewUserInfo {
    kWeakSelf
    [KeyChain downLoadUserInfoNoHUDWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.hxbBaseVCScrollView.hidden = NO;
        weakSelf.viewModel = viewModel;
        weakSelf.balanceMoneyStr = weakSelf.viewModel.userInfoModel.userAssets.availablePoint;
        [weakSelf setUpArray];
        [weakSelf.hxbBaseVCScrollView reloadData];
        [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
    } andFailure:^(NSError *error) {
        [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
    }];
}

static const NSInteger topView_bank_high = 300;
static const NSInteger topView_high = 230;

// 获取银行限额
- (void)getBankCardLimit {
    kWeakSelf
    [HXBFin_Buy_ViewModel requestForBankCardSuccessBlock:^(HXBBankCardModel *model) {
        weakSelf.hxbBaseVCScrollView.tableHeaderView = nil;
        weakSelf.cardModel = model;
        weakSelf.topView.height = weakSelf.cardModel.bankType ? kScrAdaptationH750(topView_bank_high) : kScrAdaptationH750(topView_high);
        weakSelf.topView.cardStr = [NSString stringWithFormat:@"%@%@", weakSelf.cardModel.bankType, weakSelf.cardModel.quota];
        weakSelf.topView.hasBank = weakSelf.cardModel.bankType ? YES : NO;
        weakSelf.hxbBaseVCScrollView.tableHeaderView = weakSelf.topView;
        
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
        } else {
            _topView.disableKeyBorad = NO;
            _topView.disableBtn = NO;
        }
        _topView.changeBlock = ^(NSString *text) {
            weakSelf.bottomView.addBtnIsUseable = text.length;
            BOOL isFitToBuy = ((text.integerValue - weakSelf.minRegisterAmount.integerValue) % weakSelf.registerMultipleAmount.integerValue) ? NO : YES;
            if (text.doubleValue >= weakSelf.minRegisterAmount.doubleValue && text.doubleValue <= weakSelf.availablePoint.doubleValue && isFitToBuy) {
                [weakSelf changeItemWithInvestMoney:text];
                [weakSelf setUpArray];
            } else {
                weakSelf.discountTitle = @"未使用";
                weakSelf.handleDetailTitle = text;
                [weakSelf changeItemWithInvestMoney:text];
                [weakSelf setUpArray];
            }
        };
        _topView.creditorMoney = [NSString stringWithFormat:@"待转让金额%@", [NSString hxb_getPerMilWithDouble:_availablePoint.doubleValue]];
        _topView.placeholderStr = _placeholderStr;
        _topView.block = ^{ // 点击一键购买执行的方法
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
    _bottomView.addBlock = ^(NSString *investMoney) {
        weakSelf.btnLabelText = investMoney;
        [weakSelf.topView endEditing:YES];
        [weakSelf requestForCreditor];
    };
    return _bottomView;
}
@end

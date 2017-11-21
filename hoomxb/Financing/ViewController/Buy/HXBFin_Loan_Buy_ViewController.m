//
//  HXBFin_Loan_Buy_ViewController.m
//  hoomxb
//
//  Created by 肖扬 on 2017/11/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Loan_Buy_ViewController.h"
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

static NSString *const bankString = @"绑定银行卡";

@interface HXBFin_Loan_Buy_ViewController ()<UITableViewDelegate, UITableViewDataSource, HXBChooseDiscountCouponViewControllerDelegate>
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

@end

@implementation HXBFin_Loan_Buy_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = true;
    _discountTitle = @"暂无可用优惠券";
    _balanceTitle = @"可用余额";
    [self buildUI];
    [self getBankCardLimit];
    [self changeItemWithInvestMoney:_inputMoneyStr];
    self.bottomView.addBtnIsUseable = _inputMoneyStr.length;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self getBankCardLimit];
    [self getNewUserInfo];
    
}

- (void)dealloc {
    [self.hxbBaseVCScrollView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
    NSLog(@"✅被销毁 %@",self);
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
    self.hxbBaseVCScrollView = [[UITableView alloc] initWithFrame:CGRectMake(0, HxbNavigationBarY, kScreenWidth, kScreenHeight - HxbNavigationBarY) style:(UITableViewStylePlain)];
    if (LL_iPhoneX) {
        self.hxbBaseVCScrollView.frame = CGRectMake(0, HxbNavigationBarMaxY, kScreenWidth, kScreenHeight - HxbNavigationBarMaxY);
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

- (void)changeItemWithInvestMoney:(NSString *)investMoney {
    self.topView.hiddenMoneyLabel = !self.cardModel.bankType;
    _handleDetailTitle = [NSString stringWithFormat:@"%.2f", investMoney.doubleValue];
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

// 购买散标
- (void)requestForLoan {
    if (_inputMoneyStr.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入投资金额"];
    } else if (_inputMoneyStr.floatValue > _availablePoint.floatValue) {
        self.topView.totalMoney = [NSString stringWithFormat:@"%.lf", _availablePoint.doubleValue];
        _inputMoneyStr = [NSString stringWithFormat:@"%.lf", _availablePoint.doubleValue];
        [self changeItemWithInvestMoney:_inputMoneyStr];
        [self setUpArray];
        [HxbHUDProgress showTextWithMessage:@"已超过剩余金额"];
    } else if (_inputMoneyStr.floatValue < _minRegisterAmount.floatValue) {
        _topView.totalMoney = [NSString stringWithFormat:@"%ld", (long)_minRegisterAmount.integerValue];
        _inputMoneyStr = _minRegisterAmount;
        [self changeItemWithInvestMoney:_inputMoneyStr];
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
            [weakSelf sendSmsCodeWithMoney:_viewModel.userInfoModel.userInfo.minChargeAmount];
        }];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        [self sendSmsCodeWithMoney:topupMoney];
    }
}

- (void)alertSmsCode {
    self.alertVC = [[HXBAlertVC alloc] init];
    self.alertVC.isCode = YES;
    self.alertVC.isCleanPassword = YES;
    self.alertVC.messageTitle = @"充值验证短信";
    _buyType = @"recharge"; // 弹出短验，都是充值购买
    self.alertVC.subTitle = [NSString stringWithFormat:@"已发送到%@上，请查收", [self.cardModel.securyMobile replaceStringWithStartLocation:3 lenght:4]];
    kWeakSelf
    self.alertVC.sureBtnClick = ^(NSString *pwd) {
        [weakSelf.alertVC.view endEditing:YES];
        NSDictionary *dic = nil;
        dic = @{@"amount": [NSString stringWithFormat:@"%.lf", _inputMoneyStr.doubleValue], // 强转成整数类型
                @"buyType": _buyType,
                @"balanceAmount": _balanceMoneyStr,
                @"smsCode": pwd};
        [weakSelf buyLoanWithDic:dic];
    };
    self.alertVC.getVerificationCodeBlock = ^{
        [weakSelf sendSmsCodeWithMoney:weakSelf.inputMoneyStr.doubleValue];
    };
    [self presentViewController:_alertVC animated:NO completion:nil];
}

- (void)sendSmsCodeWithMoney:(double)topupMoney {
    HXBOpenDepositAccountRequest *accountRequest = [[HXBOpenDepositAccountRequest alloc] init];
    [accountRequest accountRechargeRequestWithRechargeAmount:[NSString stringWithFormat:@"%.2f", topupMoney] andWithAction:@"quickpay" andSuccessBlock:^(id responseObject) {
        [self alertSmsCode];
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

-(void)alertPassWord {
    self.alertVC = [[HXBAlertVC alloc] init];
    self.alertVC.isCode = NO;
    self.alertVC.messageTitle = @"交易密码";
    self.alertVC.isCleanPassword = YES;
    _buyType = @"balance"; // 弹出密码，都是余额购买
    kWeakSelf
    self.alertVC.sureBtnClick = ^(NSString *pwd) {
        NSDictionary *dic = nil;
        dic = @{@"amount": _inputMoneyStr,
                @"buyType": _buyType,
                @"tradPassword": pwd,
                };
        [weakSelf buyLoanWithDic:dic];
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

- (void)buyLoanWithDic:(NSDictionary *)dic {
    kWeakSelf
    [[HXBFinanctingRequest sharedFinanctingRequest] loan_confirmBuyReslutWithLoanID:self.loanId parameter:dic andSuccessBlock:^(HXBFinModel_BuyResoult_LoanModel *model) {
        ///加入成功
        HXBFBase_BuyResult_VC *loanBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
        loanBuySuccessVC.inviteButtonTitle = model.inviteActivityDesc;
        loanBuySuccessVC.isShowInviteBtn = model.isInviteActivityShow;
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
    if (indexPath.row == _titleArray.count - 1) {
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
    [KeyChain downLoadUserInfoNoHUDWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.hxbBaseVCScrollView.hidden = NO;
        _viewModel = viewModel;
        _balanceMoneyStr = _viewModel.userInfoModel.userAssets.availablePoint;
        [self changeItemWithInvestMoney:_inputMoneyStr];
        [self setUpArray];
        [self.hxbBaseVCScrollView reloadData];
    } andFailure:^(NSError *error) {
        [self changeItemWithInvestMoney:_inputMoneyStr];
    }];
}

static const NSInteger topView_bank_high = 300;
static const NSInteger topView_high = 230;
// 获取银行限额
- (void)getBankCardLimit {
    [HXBFin_Buy_ViewModel requestForBankCardSuccessBlock:^(HXBBankCardModel *model) {
        self.hxbBaseVCScrollView.tableHeaderView = nil;
        self.cardModel = model;
        if (self.cardModel.bankType) {
            self.topView.height = kScrAdaptationH750(topView_bank_high);
        } else {
            self.topView.height = kScrAdaptationH750(topView_high);
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
    self.titleArray = @[@"优惠券", @"支付金额", _balanceTitle];
    self.detailArray = @[_discountTitle,  [NSString hxb_getPerMilWithDouble: _handleDetailTitle.doubleValue],  [NSString hxb_getPerMilWithDouble: _balanceMoneyStr.doubleValue]];
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
        _topView.keyboardType = UIKeyboardTypeNumberPad;
        _topView.changeBlock = ^(NSString *text) {
            weakSelf.bottomView.addBtnIsUseable = text.length;
            BOOL isFitToBuy = ((text.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue) ? NO : YES;
            if (text.doubleValue >= _minRegisterAmount.doubleValue && text.doubleValue <= _availablePoint.doubleValue && isFitToBuy) {
                [weakSelf changeItemWithInvestMoney:text];
                [weakSelf setUpArray];
            } else {
                _discountTitle = @"未使用";
                _handleDetailTitle = text;
                [weakSelf changeItemWithInvestMoney:text];
                [weakSelf setUpArray];
            }
        };
        _topView.creditorMoney = [NSString stringWithFormat:@"标的剩余金额%@", [NSString hxb_getPerMilWithIntegetNumber:_availablePoint.doubleValue]];
        _topView.placeholderStr = _placeholderStr;
        _topView.block = ^{ // 点击一键购买执行的方法
            NSString *topupStr = weakSelf.availablePoint;
            weakSelf.topView.totalMoney = [NSString stringWithFormat:@"%.lf", topupStr.floatValue];
            _inputMoneyStr = topupStr;
            _handleDetailTitle = topupStr;
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
    _bottomView.delegateLabelText = @"借款合同》,《网络借贷协议书";
    _bottomView.delegateBlock = ^(NSInteger index) {
        if (index == 1) {
            HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
            vc.URL = kHXB_Negotiate_ServeLoanURL;
            [weakSelf.navigationController pushViewController:vc animated:true];
        } else {
            HXBFinAddTruastWebViewVC *vc = [[HXBFinAddTruastWebViewVC alloc] init];
            vc.URL = kHXB_Agreement_Hint;
            [weakSelf.navigationController pushViewController:vc animated:true];
        }
    };
    _bottomView.addBlock = ^(NSString *investMoney) {
        _btnLabelText = investMoney;
        [weakSelf.topView endEditing:YES];
        [weakSelf requestForLoan];
    };
    return _bottomView;
}

@end

//
//  HXBFin_Loan_Buy_ViewController.m
//  hoomxb
//
//  Created by 肖扬 on 2017/11/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
// 散标

#import "HXBFin_Loan_Buy_ViewController.h"
#import "HXBCreditorChangeTopView.h"
#import "HXBCreditorChangeBottomView.h"
#import "HXBFin_creditorChange_TableViewCell.h"
#import "HXBFBase_BuyResult_VC.h"
#import "HxbMyTopUpViewController.h"
#import "HXBVerificationCodeAlertVC.h"
#import "HXBModifyTransactionPasswordViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HXBChooseDiscountCouponViewController.h"
#import "HXBTransactionPasswordView.h"
#import "HXBRootVCManager.h"
#import "HXBFinLoanBuyViewModel.h"
#import "HXBLazyCatAccountWebViewController.h"

static NSString *const bankString = @"绑定银行卡";

@interface HXBFin_Loan_Buy_ViewController ()<UITableViewDelegate, UITableViewDataSource, HXBChooseDiscountCouponViewControllerDelegate, HXBRemoteUpdateInterface>
/** topView */
@property (nonatomic, strong) HXBCreditorChangeTopView *topView;
/** bottomView*/
@property (nonatomic, strong) HXBCreditorChangeBottomView *bottomView;
/** 短验弹框 */
@property (nonatomic, strong) HXBVerificationCodeAlertVC *alertVC;
// 银行卡信息
@property (nonatomic, strong) HXBBankCardModel *cardModel;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** titleArray */
@property (nonatomic, strong) NSArray *titleArray;
/** detailArray */
@property (nonatomic, strong) NSArray *detailArray;
/** 购买金额 */
@property (nonatomic, copy) NSString *inputMoneyStr;
/** 可用余额 */
@property (nonatomic, copy) NSString *balanceMoneyStr;
/** 点击按钮的文案 */
@property (nonatomic, copy) NSString *btnLabelText;
/** 购买类型 */
@property (nonatomic, copy) NSString *buyType; // balance recharge
/** 优惠券金额 */
@property (nonatomic, copy) NSString *discountTitle;
/** 可用余额TextLabel */
@property (nonatomic, copy) NSString *balanceTitle;
/** 可用余额detailLabel */
@property (nonatomic, copy) NSString *balanceDetailTitle;
// 是否符合标的等级购买规则
@property (nonatomic, assign) BOOL isMatchBuy;
// 是否选中同意选项
@property (nonatomic, assign) BOOL isSelectLimit;
// 是否超出投资限制
@property (nonatomic, assign) BOOL isExceedLimitInvest;

@property (nonatomic, strong) HXBTransactionPasswordView *passwordView;

@property (nonatomic, strong) HXBFinLoanBuyViewModel *viewModel;
/// 判断购买类型
@property (nonatomic, assign) HXBBuyType hxbBuyType;
/// 银行卡名称
@property (nonatomic, copy) NSString *bankImageName;
// 当前输入框的金额
@property (nonatomic, assign) double curruntInvestMoney;

@end

@implementation HXBFin_Loan_Buy_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = YES;
    _discountTitle = @"暂无可用优惠券";
    _balanceTitle = @"可用余额";
    kWeakSelf
    _viewModel = [[HXBFinLoanBuyViewModel alloc] initWithBlock:^UIView *{
        if (weakSelf.presentedViewController) {
            return weakSelf.presentedViewController.view;
        } else {
            return weakSelf.view;
        }
    }];
    _isMatchBuy = [self.userInfoViewModel.userInfoModel.userAssets.userRisk containsObject:self.riskType];
    _balanceMoneyStr = self.userInfoViewModel.userInfoModel.userAssets.availablePoint;
    
    [self buildUI];
    [self changeItemWithInvestMoney:_inputMoneyStr];
    self.bottomView.addBtnIsUseable = _inputMoneyStr.length;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.isSelectLimit = NO;
    [self getBankCardLimit];
    [self hasBuyType];
    
}

- (void)buildUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HXBStatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - HXBStatusBarAndNavigationBarHeight) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = kHXBColor_BackGround;
    self.tableView.tableFooterView = [self footTableView];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = kScrAdaptationH750(110.5);
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
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
        cell.bankImageName = @"";
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.isDiscountRow = NO;
        cell.bankImageName = _bankImageName;
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

/// 判断购买类型
- (void)hasBuyType {
    /// 进入界面判断是否绑卡及账户余额是否比起投金额高
    if ((_balanceMoneyStr.floatValue > self.minRegisterAmount.floatValue ?: self.registerMultipleAmount.floatValue) && _balanceMoneyStr.floatValue >= self.curruntInvestMoney) { // 余额够
        [self changeCellWithBuyType:HXBBuyTypeBalance];
        _hxbBuyType = HXBBuyTypeBalance;
    } else {
        if ([self.hasBindCard isEqualToString:@"1"]) {
            [self changeCellWithBuyType:HXBBuyTypeBankBuy];
            _hxbBuyType = HXBBuyTypeBankBuy;
        } else {
            [self changeCellWithBuyType:HXBBuyTypeNoBankCard];
            _hxbBuyType = HXBBuyTypeNoBankCard;
        }
    }
}

/// 根据购买类型判断cell展示
- (void)changeCellWithBuyType:(HXBBuyType)buyType {
    if (buyType == HXBBuyTypeBalance) {
        _balanceTitle = [NSString stringWithFormat:@"账户余额（%@）", [NSString hxb_getPerMilWithDouble: self.balanceMoneyStr.doubleValue]];
        _bankImageName = @"";
        _bottomView.clickBtnStr = @"立即出借";
    } else if (buyType == HXBBuyTypeNoBankCard) {
        _balanceTitle = @"需绑定银行卡";
        _bankImageName = @"";
        _bottomView.clickBtnStr = @"立即绑卡";
    } else if (buyType == HXBBuyTypeBankBuy) {
        _balanceTitle = [NSString stringWithFormat:@"%@（%@）", self.cardModel.bankType, [NSString getHiddenBankNum:self.cardModel.cardId]];
        _bankImageName = self.cardModel.bankCode;
        _bottomView.clickBtnStr = @"立即出借";
    }
    [self setUpArray];
}

- (void)changeItemWithInvestMoney:(NSString *)investMoney {
    [self isMatchToBuyWithMoney:investMoney];
    self.topView.hiddenMoneyLabel = !self.cardModel.bankType;
    _inputMoneyStr = investMoney;
    [self setUpArray];
}

// 购买散标
- (void)requestForLoan {
    if (_availablePoint.integerValue == 0) {
        self.topView.totalMoney = @"";
        _inputMoneyStr = @"";
        [self setUpArray];
        if (self.isExceedLimitInvest && !_isSelectLimit) {
            [HxbHUDProgress showTextWithMessage:@"请勾选同意风险提示"];
            return;
        }
        [HxbHUDProgress showTextWithMessage:@"已超可加入金额"];
        return;
    }
    if (_inputMoneyStr.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入出借金额"];
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
        [HxbHUDProgress showTextWithMessage:@"出借金额不足起投金额"];
    } else {
        BOOL isFitToBuy = ((_inputMoneyStr.integerValue - _minRegisterAmount.integerValue) % _registerMultipleAmount.integerValue) ? NO : YES;
        if (isFitToBuy) {
            if (self.isExceedLimitInvest && !_isSelectLimit) {
                [HxbHUDProgress showTextWithMessage:@"请勾选同意风险提示"];
                return;
            }
            [self chooseBuyTypeWithbuyType:_hxbBuyType];
        } else {
            [HxbHUDProgress showTextWithMessage:[NSString stringWithFormat:@"金额需为%@的整数倍", self.registerMultipleAmount]];
        }
    }
}

// 判断是什么投资类型（充值购买，余额购买、未绑卡）
- (void)chooseBuyTypeWithbuyType:(HXBBuyType)buyType {
    NSDictionary *dic = nil;
    if (buyType == HXBBuyTypeNoBankCard) {  /// 去绑卡
        HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc] init];
        withdrawCardViewController.title = @"绑卡";
        withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
        [self.navigationController pushViewController:withdrawCardViewController animated:YES];
    } else if (buyType == HXBBuyTypeBankBuy) {
        dic = @{@"loanId": self.loanId,
                @"amount": self.inputMoneyStr,
                @"buyType": @"recharge",
                @"willingToBuy": [NSString stringWithFormat:@"%d", _isSelectLimit]
                };
        [self buyLoanWithDic:dic];
    } else if (buyType == HXBBuyTypeBalance) {
        dic = @{@"loanId": self.loanId,
                @"amount": self.inputMoneyStr,
                @"buyType": @"balance",
                @"willingToBuy": [NSString stringWithFormat:@"%d", _isSelectLimit] ?: @""
                };
        [self buyLoanWithDic:dic];
    }
}

- (void)buyLoanWithDic:(NSDictionary *)dic {
    [_viewModel showHFBankWithContent:hfContentText];
    kWeakSelf
    [_viewModel loanBuyReslutWithParameter:dic resultBlock:^(BOOL isSuccess) {
        [weakSelf.viewModel hiddenHFBank];
        if (isSuccess) {
            HXBLazyCatAccountWebViewController *HFVC = [[HXBLazyCatAccountWebViewController alloc] init];
            HFVC.requestModel = weakSelf.viewModel.resultModel;
            [weakSelf.navigationController pushViewController:HFVC animated:YES];
        }
    }];
    //        if (isSuccess) {
    //            HXBFBase_BuyResult_VC *loanBuySuccessVC = [[HXBFBase_BuyResult_VC alloc]init];
    //            loanBuySuccessVC.title = @"购买成功";
    //            loanBuySuccessVC.inviteButtonTitle = weakSelf.viewModel.resultModel.inviteActivityDesc;
    //            loanBuySuccessVC.isShowInviteBtn = weakSelf.viewModel.resultModel.isInviteActivityShow;
    //            loanBuySuccessVC.imageName = @"successful";
    //            loanBuySuccessVC.buy_title = @"投标成功";
    //            loanBuySuccessVC.buy_description = @"放款前系统将会冻结您的出借金额，放款成功后开始计息";
    //            loanBuySuccessVC.buy_ButtonTitle = @"查看我的出借";
    //            [loanBuySuccessVC clickButtonWithBlock:^{
    //                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
    //                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    //            }];
    //            [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
    //            [weakSelf.navigationController pushViewController:loanBuySuccessVC animated:YES];
    //        } else {
    //            HXBFBase_BuyResult_VC *failViewController = [[HXBFBase_BuyResult_VC alloc] init];
    //            failViewController.title = @"出借失败";
    //            switch (weakSelf.viewModel.errorCode) {
    //                case kBuy_Result:
    //                    failViewController.imageName = @"failure";
    //                    failViewController.buy_title = @"出借失败";
    //                    failViewController.buy_description = weakSelf.viewModel.errorMessage;
    //                    failViewController.buy_ButtonTitle = @"重新出借";
    //                    break;
    //
    //                case kBuy_Processing:
    //                    failViewController.imageName = @"outOffTime";
    //                    failViewController.buy_title = @"处理中";
    //                    failViewController.buy_description = weakSelf.viewModel.errorMessage;
    //                    failViewController.buy_ButtonTitle = @"重新出借";
    //                    break;
    //
    //                default:
    //                    [weakSelf.passwordView clearUpPassword];
    //                    return;
    //            }
    //            [failViewController clickButtonWithBlock:^{
    //                [weakSelf.navigationController popToRootViewControllerAnimated:YES];  //跳回理财页面
    //            }];
    //            [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
    //            [weakSelf.navigationController pushViewController:failViewController animated:YES];
    //        }
}

// 获取用户信息
- (void)getNewUserInfo {
    kWeakSelf
    [self.viewModel downLoadUserInfo:NO resultBlock:^(BOOL isSuccess) {
        if(isSuccess) {
            weakSelf.userInfoViewModel = weakSelf.viewModel.userInfoModel;
            weakSelf.hasBindCard = weakSelf.userInfoViewModel.userInfoModel.userInfo.hasBindCard;
            weakSelf.balanceMoneyStr = weakSelf.userInfoViewModel.userInfoModel.userAssets.availablePoint;
            [weakSelf.tableView reloadData];
            [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
        }
        else {
            [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
        }
    }];
}

// 获取银行限额
- (void)getBankCardLimit {
    if ([self.hasBindCard isEqualToString:@"1"]) {
        self.topView.height = kScrAdaptationH750(300);
        kWeakSelf
        [_viewModel getBankCardWithHud:YES resultBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                weakSelf.cardModel = weakSelf.viewModel.bankCardModel;
                if (!weakSelf.cardModel) {
                    weakSelf.topView.cardStr = @"--限额：单笔-- 单日--";
                } else {
                    weakSelf.topView.cardStr = [NSString stringWithFormat:@"%@%@", weakSelf.cardModel.bankType, weakSelf.cardModel.quota];
                }
                [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
                [weakSelf setUpArray];
                weakSelf.topView.hasBank = YES;
                weakSelf.tableView.tableHeaderView = weakSelf.topView;
                [weakSelf.tableView reloadData];
                weakSelf.tableView.hidden = NO;
            }
        }];
    } else {
        self.topView.height = kScrAdaptationH750(230);
        self.topView.hasBank = NO;
        self.tableView.tableHeaderView = self.topView;
        [self changeItemWithInvestMoney:_inputMoneyStr];
        [self setUpArray];
        [self.tableView reloadData];
        self.tableView.hidden = NO;
    }
}

- (void)setUpArray {
    self.titleArray = @[@"优惠券", _balanceTitle];
    self.detailArray = @[_discountTitle, [NSString stringWithFormat:@"支付%@", [NSString hxb_getPerMilWithDouble: _curruntInvestMoney]]];
    [self.tableView reloadData];
}

- (void)investMoneyTextFieldText:(NSString *)text {
    self.bottomView.addBtnIsUseable = text.length;
    _curruntInvestMoney = text.doubleValue;
    [self hasBuyType];
    BOOL isFitToBuy = ((text.integerValue - self.minRegisterAmount.integerValue) % self.registerMultipleAmount.integerValue) ? NO : YES;
    if (text.doubleValue >= self.minRegisterAmount.doubleValue && text.doubleValue <= self.availablePoint.doubleValue && isFitToBuy) {
        [self changeItemWithInvestMoney:text];
        [self setUpArray];
    } else {
        self.discountTitle = @"未使用";
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

#pragma mark --- setter/getter
- (UIView *)topView {
    kWeakSelf
    if (!_topView) {
        _topView = [[HXBCreditorChangeTopView alloc] initWithFrame:CGRectZero];
        _topView.isHiddenBtn = NO;
        _topView.hiddenProfitLabel = YES;
        _topView.keyboardType = UIKeyboardTypeNumberPad;
        _topView.creditorMoney = [NSString stringWithFormat:@"散标剩余金额%@", [NSString hxb_getPerMilWithIntegetNumber:_availablePoint.doubleValue]];
        _topView.placeholderStr = _placeholderStr;
        
        // 输入框值变化
        _topView.changeBlock = ^(NSString *text) {
            [weakSelf investMoneyTextFieldText:text];
        };
        // 点击一键购买执行的方法
        _topView.block = ^{
            if (weakSelf.availablePoint.doubleValue == 0) {
                [HxbHUDProgress showTextWithMessage:@"投标金额已达上限"];
                weakSelf.topView.disableKeyBorad = YES;
            } else {
                NSString *topupStr = weakSelf.availablePoint;
                weakSelf.topView.totalMoney = [NSString stringWithFormat:@"%.lf", topupStr.floatValue];
                weakSelf.inputMoneyStr = topupStr;
                weakSelf.bottomView.addBtnIsUseable = topupStr.length;
                weakSelf.curruntInvestMoney = topupStr.doubleValue;
                [weakSelf hasBuyType];
                [weakSelf changeItemWithInvestMoney:topupStr];
                [weakSelf setUpArray];
            }
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
            [HXBBaseWKWebViewController pushWithPageUrl:[NSString splicingH5hostWithURL:kHXB_Negotiate_ServeLoanURL] fromController:weakSelf];
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
        [weakSelf requestForLoan];
    };
    return _bottomView;
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

- (void)updateNetWorkData {
    [self getNewUserInfo];
    [self.tableView reloadData];
}

- (void)chooseDiscountCouponViewController:(HXBChooseDiscountCouponViewController *)chooseDiscountCouponViewController didSendModel:(HXBCouponModel *)model {
}

@end

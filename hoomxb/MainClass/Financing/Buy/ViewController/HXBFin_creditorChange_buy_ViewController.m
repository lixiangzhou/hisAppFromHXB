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

@interface HXBFin_creditorChange_buy_ViewController ()<UITableViewDelegate, UITableViewDataSource, HXBChooseDiscountCouponViewControllerDelegate, HXBRemoteUpdateInterface>
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
/** titleArray */
@property (nonatomic, strong) NSArray *detailArray;
/** 输入框金额 */
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
/** 购买类型 balance recharge*/
@property (nonatomic, copy) NSString *buyType;
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
/** 发送请求的任务 */
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
// 是否超出投资限制// 是否超出投资限制
@property (nonatomic, assign) BOOL isExceedLimitInvest;

@property (nonatomic, strong) HXBFincreditorChangebuyViewModel *viewModel;
/// 判断购买类型
@property (nonatomic, assign) HXBBuyType hxbBuyType;
/// 银行卡名称
@property (nonatomic, copy) NSString *bankImageName;

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

/// 判断购买类型
- (void)hasBuyType {
    /// 进入界面判断是否绑卡及账户余额是否比起投金额高
    if ((_balanceMoneyStr.floatValue > self.minRegisterAmount.floatValue ?: self.registerMultipleAmount.floatValue) && _balanceMoneyStr.floatValue >= _inputMoneyStr.doubleValue) { // 余额够
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
    _handleDetailTitle = [NSString stringWithFormat:@"%.2f", investMoney.doubleValue];
    self.topView.hiddenMoneyLabel = !self.cardModel.bankType;
    _inputMoneyStr = investMoney;
    [self setUpArray];
}

// 购买债权
/*
 _availablePoint             待转让金额
 _minRegisterAmount          最低起投金额
 _registerMultipleAmount     最低起投此金额多少倍
 _inputMoneyStr              输入的金额
 */
- (void)requestForCreditor {
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
            [self chooseBuyTypeWithbuyType:_hxbBuyType];
            return;
        }
        if (isHasContainsNonzeroDecimals) {
            if ((long long)([_inputMoneyStr doubleValue] * 100) == (long long)([_availablePoint doubleValue] * 100)) {
                if (self.isExceedLimitInvest && !_isSelectLimit) {
                    [HxbHUDProgress showTextWithMessage:@"请勾选同意风险提示"];
                    return;
                }
                [self chooseBuyTypeWithbuyType:_hxbBuyType];
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
                [self chooseBuyTypeWithbuyType:_hxbBuyType];
            }
        }
    }
}

// 判断是什么投资类型（充值购买，余额购买、未绑卡）
- (void)chooseBuyTypeWithbuyType:(HXBBuyType)buyType {
    kWeakSelf
    NSDictionary *dic = nil;
    if (buyType == HXBBuyTypeNoBankCard) {  /// 去绑卡
        
    } else if (buyType == HXBBuyTypeBankBuy) {  /// 充值
        dic = @{@"amount": [NSString stringWithFormat:@"%.2f", weakSelf.inputMoneyStr.doubleValue]};
        /// fixme
    } else if (buyType == HXBBuyTypeBalance) {  /// 余额购买
        dic = @{@"transferId": self.loanId,
                @"buyAmount": [NSString stringWithFormat:@"%.2f", weakSelf.inputMoneyStr.doubleValue],
                @"willingToBuy": [NSString stringWithFormat:@"%d", _isSelectLimit]
                };
        [weakSelf buyCreditorWithDic:dic];
    }
}

// 购买债权
- (void)buyCreditorWithDic:(NSDictionary *)dic {
    kWeakSelf
    [_viewModel showHFBankWithContent:hfContentText];
    [_viewModel loanTransformBuyReslutWithParameter:dic resultBlock:^(BOOL isSuccess) {
        [weakSelf.viewModel hiddenHFBank];
        if (isSuccess) {
            
        }
    }];
    //        if (isSuccess) {
    //            HXBFBase_BuyResult_VC *loanBuySuccessVC = [[HXBFBase_BuyResult_VC alloc] init];
    //            loanBuySuccessVC.inviteButtonTitle = weakSelf.viewModel.resultModel.inviteActivityDesc;
    //            loanBuySuccessVC.isShowInviteBtn = weakSelf.viewModel.resultModel.isInviteActivityShow;
    //            loanBuySuccessVC.title = @"购买成功";
    //            loanBuySuccessVC.buy_title = @"购买成功";
    //            loanBuySuccessVC.imageName = @"successful";
    //            loanBuySuccessVC.buy_ButtonTitle = @"查看我的出借";
    //            loanBuySuccessVC.buy_description = weakSelf.viewModel.resultModel.isRepayed ? @"公允利息为您垫付的转让人持有天利息，还款人将会在下个还款日予以返回" : @"公允利息：当期已还时，债权人将多收利息进行补偿，均放入出借本金";
    //            loanBuySuccessVC.massage_Left_StrArray = @[@"下一还款日", @"出借金额", @"实际买入本金", @"公允利息"];
    //            loanBuySuccessVC.massage_Right_StrArray = @[weakSelf.viewModel.resultModel.nextRepayDate_new, weakSelf.viewModel.resultModel.buyAmount_new, weakSelf.viewModel.resultModel.principal_new, weakSelf.viewModel.resultModel.interest_new];
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
    //                    return;
    //            }
    //            [failViewController clickButtonWithBlock:^{
    //                [weakSelf.navigationController popToRootViewControllerAnimated:YES];  //跳回理财页面
    //            }];
    //            [weakSelf.alertVC dismissViewControllerAnimated:NO completion:nil];
    //            [weakSelf.navigationController pushViewController:failViewController animated:YES];
    //        }
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
                [weakSelf setUpArray];
                [weakSelf changeItemWithInvestMoney:weakSelf.inputMoneyStr];
                weakSelf.topView.hasBank = YES;
                weakSelf.tableView.tableHeaderView = weakSelf.topView;
                [weakSelf.tableView reloadData];
                weakSelf.tableView.hidden = NO;
            }
        }];
    } else {
        self.topView.height = kScrAdaptationH750(230);
        self.topView.hasBank = NO;
        [self setUpArray];
        [self changeItemWithInvestMoney:_inputMoneyStr];
        self.tableView.tableHeaderView = self.topView;
        [self.tableView reloadData];
        self.tableView.hidden = NO;
    }
}

// 获取用户信息
- (void)getNewUserInfo {
    kWeakSelf
    [_viewModel downLoadUserInfo:NO resultBlock:^(BOOL isSuccess) {
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


- (void)setUpArray {
    if (!_profitMoneyStr) {
        _profitMoneyStr = @"";
    }
    self.titleArray = @[@"优惠券", _balanceTitle];
    self.detailArray = @[_discountTitle, [NSString stringWithFormat:@"支付%@", [NSString hxb_getPerMilWithDouble: _inputMoneyStr.doubleValue]]];
    [self.tableView reloadData];
}

- (void)investMoneyWithText:(NSString *)text {
    self.bottomView.addBtnIsUseable = text.length;
    _inputMoneyStr = text;
    BOOL isFitToBuy = ((text.integerValue - self.minRegisterAmount.integerValue) % self.registerMultipleAmount.integerValue) ? NO : YES;
    [self hasBuyType];
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

#pragma mark --- setter/getter
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
            [weakSelf hasBuyType];
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

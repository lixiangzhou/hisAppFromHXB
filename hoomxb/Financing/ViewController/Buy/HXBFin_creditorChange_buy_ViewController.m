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


@interface HXBFin_creditorChange_buy_ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** topView */
@property (nonatomic, strong) HXBCreditorChangeTopView *topView;
/** bottomView*/
@property (nonatomic, strong) HXBCreditorChangeBottomView *bottomView;
@property (nonatomic, strong) HXBRequestUserInfoViewModel *viewModel;
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
/** 购买类型 */
@property (nonatomic, copy) NSString *buyType; // balance recharge

@end

@implementation HXBFin_creditorChange_buy_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = true;
    [self getNewUserInfo];
    [self buildUI];
    [self setUpDate];
    
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
    [self.view addSubview:self.hxbBaseVCScrollView];
}


- (UIView *)headTableView {
    kWeakSelf
    _topView = [[HXBCreditorChangeTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH750(215))];
    _topView.changeBlock = ^(NSString *text) {
        _topupMoneyStr = text;
        [weakSelf setUpArray];
    };
    _topView.block = ^{
        NSString *topupStr = [weakSelf.availablePoint substringToIndex:weakSelf.availablePoint.length - 1];
        weakSelf.topView.totalMoney = topupStr;
        _topupMoneyStr = topupStr;
        [weakSelf setUpArray];
    };
    return _topView;
}


- (UIView *)footTableView {
    _bottomView = [[HXBCreditorChangeBottomView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH750(2000))];
    kWeakSelf
    _bottomView.addBlock = ^(NSString *investMoney) {
        [weakSelf clickAddBtn];
    };
    return _bottomView;
}

- (void)clickAddBtn {
    NSDictionary *dic = nil;
    if (_type == HXB_Plan) {
        dic = @{};
        [self requestForPlanWithDic:dic];
    } else if (_type == HXB_Loan) {
        [self requestForLoanWithDic:dic];
    } else {
        if ([_buyType isEqualToString:@"balancce"]) {
            dic = @{@"investAmount": _topupMoneyStr,
                    @"buyType": _buyType,
                    @"tradPassword": _exchangePasswordStr,
                    };
        } else {
            dic = @{@"investAmount": _topupMoneyStr,
                    @"buyType": _buyType,
                    @"balanceAmount": _balanceMoneyStr,
                    @"smsCode": _smsCodeStr};
        }
        [self requestForCreditorWithDic:dic];
    }
}

- (void)requestForPlanWithDic:(NSDictionary *)dic {
    
}

- (void)requestForLoanWithDic:(NSDictionary *)dic {
    
}

- (void)requestForCreditorWithDic:(NSDictionary *)dic {
    [[HXBFinanctingRequest sharedFinanctingRequest] loanTruansfer_confirmBuyReslutWithLoanID:_loanId parameter:dic andSuccessBlock:^(HXBFin_LoanTruansfer_BuyResoutViewModel *model) {
        NSLog(@"购买成功");
    } andFailureBlock:^(NSError *error, NSDictionary *response) {
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
    cell.titleStr = _titleArray[indexPath.row];
    cell.detailStr = _detailArray[indexPath.row];
    return cell;
}



- (void)setUpDate {
    if (_type == HXB_Plan) {
        
    } else if (_type == HXB_Loan) {
        
    } else {
        _topView.creditorMoney = [NSString stringWithFormat:@"待转让金额：%@", _availablePoint];
    }
    _topView.placeholderStr = _placeholderStr;
    
}



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

- (void)setUpArray {
    if (_type == HXB_Plan) {
        if (_topupMoneyStr.length > 0) {
            
        } else {
            
        }
    } else if (_type == HXB_Loan) {
        
    } else {
        if (_topupMoneyStr.doubleValue > _balanceMoneyStr.doubleValue) {
            self.titleArray = @[@"可用金额：", @"还需支付："];
            self.detailArray = @[_viewModel.availablePoint, [NSString hxb_getPerMilWithDouble:(_topupMoneyStr.doubleValue - _balanceMoneyStr.doubleValue)]];
            [self.hxbBaseVCScrollView reloadData];
        } else {
            self.titleArray = @[@"可用金额："];
            self.detailArray = @[_viewModel.availablePoint];
            [self.hxbBaseVCScrollView reloadData];
        }
    }
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


- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

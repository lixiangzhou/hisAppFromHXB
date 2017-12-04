//
//  HXBMyBankResultViewController.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/29.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyBankResultViewController.h"
#import "HxbWithdrawCardViewController.h"
#import "HxbMyBankCardViewController.h"

@interface HXBMyBankResultViewController ()

@property (nonatomic, strong) UIImageView *bankImageView;
@property (nonatomic, strong) UILabel *bankTileLabel;
@property (nonatomic, strong) UILabel *bankDescribeLabel;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIButton *myAccountButton;
@end

@implementation HXBMyBankResultViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"解绑银行卡";
    self.isRedColorWithNavigationBar = YES;
    [self setUI];
    [self setData];
}

#pragma mark - UI

- (void)setUI {
    [self.view addSubview:self.bankImageView];
    [self.view addSubview:self.bankTileLabel];
    [self.view addSubview:self.bankDescribeLabel];
    [self.view addSubview:self.actionButton];
    [self.view addSubview:self.myAccountButton];
    [self displayFrame];
}

// 布局
- (void)displayFrame {
    [self.bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight + kScrAdaptationH750(150)));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(kScrAdaptationW750(295)));
        make.height.equalTo(@(kScrAdaptationH750(182)));
    }];
    
    [self.bankTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankImageView.mas_bottom).offset(kScrAdaptationH(30));
        make.centerX.equalTo(self.view);
    }];
    
    [self.bankDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankTileLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.centerX.equalTo(self.view);
        make.width.offset(kScreenWidth - kScrAdaptationW(30));
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankDescribeLabel.mas_bottom).offset(kScrAdaptationH(50));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(kScrAdaptationW750(670)));
        make.height.equalTo(@(kScrAdaptationH750(82)));
    }];
    
    [self.myAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.actionButton.mas_bottom).offset(kScrAdaptationH(20));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(kScrAdaptationW750(670)));
        make.height.equalTo(@(kScrAdaptationH750(82)));
    }];
}
#pragma mark - Network
- (void)setData {
    if (_isSuccess) {
        _bankImageView.image = [UIImage imageNamed:@"successful"];
        [_actionButton setTitle:@"绑定新卡" forState:(UIControlStateNormal)];
        _bankTileLabel.text = @"解绑成功";
        _bankDescribeLabel.text = [NSString stringWithFormat:@"尾号%@的银行卡解绑成功", _mobileText];
    } else {
        _bankImageView.image = [UIImage imageNamed:@"failure"];
        [_actionButton setTitle:@"重新解绑" forState:(UIControlStateNormal)];
        _bankTileLabel.text = @"解绑失败";
        _bankDescribeLabel.text = _describeText;
    }
    [_myAccountButton setTitle:@"我的账户" forState:(UIControlStateNormal)];
    
}

#pragma mark - Action
// 点击返回
- (void)leftBackBtnClick {
    [self popToViewControllerWithClassName:@"HxbAccountInfoViewController"];
}

// 点击重新绑卡按钮
- (void)actionButtonClick:(UIButton *)sender {
    if (_isSuccess) {
        //进入绑卡界面
        HxbWithdrawCardViewController *withdrawCardViewController = [[HxbWithdrawCardViewController alloc] init];
        withdrawCardViewController.title = @"绑卡";
        withdrawCardViewController.className = @"HxbAccountInfoViewController";
        withdrawCardViewController.type = HXBRechargeAndWithdrawalsLogicalJudgment_Other;
        [self.navigationController pushViewController:withdrawCardViewController animated:YES];
    } else {
        [self popToViewControllerWithClassName:@"HxbMyBankCardViewController"];
    }

}

// 点击我的账户按钮
- (void)myAccountButtonClick:(UIButton *)sender {
    [self popToViewControllerWithClassName:@"HxbAccountInfoViewController"];
}

// pop到制定的页面
- (void)popToViewControllerWithClassName:(NSString *)class {
    __block HXBBaseViewController *vc = nil;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { // 块遍历法，遍历子控制器
        if ([obj isKindOfClass:NSClassFromString(class)]) {
            vc = obj;
            *stop = YES;
        }
    }];
    if (vc) {
        [self.navigationController popToViewController:vc animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Setter / Getter / Lazy
- (UIImageView *)bankImageView {
    if (!_bankImageView) {
        _bankImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bankImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bankImageView;
}

- (UILabel *)bankTileLabel {
    if (!_bankTileLabel) {
        _bankTileLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bankTileLabel.font = kHXBFont_PINGFANGSC_REGULAR(19);
        _bankTileLabel.textColor = COR6;
    }
    return _bankTileLabel;
}

- (UILabel *)bankDescribeLabel {
    if (!_bankDescribeLabel) {
        _bankDescribeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bankDescribeLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _bankDescribeLabel.textAlignment = NSTextAlignmentCenter;
        _bankDescribeLabel.textColor = COR10;
    }
    return _bankDescribeLabel;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [[UIButton alloc]init];
        _actionButton.layer.masksToBounds = true;
        _actionButton.layer.cornerRadius = kScrAdaptationW750(5);
        _actionButton.backgroundColor = kHXBColor_Red_090303;
        _actionButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _actionButton;
}

- (UIButton *)myAccountButton {
    if (!_myAccountButton) {
        _myAccountButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _myAccountButton.layer.masksToBounds = true;
        _myAccountButton.layer.cornerRadius = kScrAdaptationW750(5);
        _myAccountButton.backgroundColor = [UIColor whiteColor];
        _myAccountButton.layer.borderWidth = kXYBorderWidth;
        _myAccountButton.layer.borderColor = COR29.CGColor;
        _myAccountButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        [_myAccountButton setTitleColor:COR29 forState:UIControlStateNormal];
        [_myAccountButton addTarget:self action:@selector(myAccountButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _myAccountButton;
}

@end

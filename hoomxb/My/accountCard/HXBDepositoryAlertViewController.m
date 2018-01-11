//
//  HXBDepositoryAlertViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBDepositoryAlertViewController.h"
#import "HXBOpenDepositAccountViewController.h"//存管开户页面
#import "HXBRootVCManager.h"//基类的管理类
@interface HXBDepositoryAlertViewController ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UIButton *immediateOpenBtn;

@property (nonatomic, strong) UIButton *closeBtn;


@end

@implementation HXBDepositoryAlertViewController
#pragma mark - Life Cycle
- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.closeBtn];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.bottomLabel];
    [self.contentView addSubview:self.immediateOpenBtn];
    [self setupSubViewFrame];
    
}
#pragma mark - UI
- (void)setupSubViewFrame
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScrAdaptationH(138));
        make.left.equalTo(self.view).offset(kScrAdaptationW(40));
        make.right.equalTo(self.view).offset(kScrAdaptationW(-40));
        make.height.offset(kScrAdaptationH(324));
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kScrAdaptationW(14));
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(2));
        make.right.equalTo(self.contentView);
        make.height.offset(kScrAdaptationH(186));
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(kScrAdaptationH(15));
        make.centerX.equalTo(self.contentView);
        make.height.offset(kScrAdaptationH(20));
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.height.offset(kScrAdaptationH(20));
    }];
    [self.immediateOpenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLabel.mas_bottom).offset(kScrAdaptationH(25));
        make.left.equalTo(self.contentView).offset(kScrAdaptationW(31));
        make.right.equalTo(self.contentView).offset(kScrAdaptationW(-31));
        make.height.offset(kScrAdaptationH(36));
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.contentView.mas_bottom).offset(kScrAdaptationH(60));
        make.height.with.offset(kScrAdaptationW(30));
        make.width.with.offset(kScrAdaptationW(30));
    }];
}

- (void)dismiss:(UIButton *)btn
{
    if (btn == self.immediateOpenBtn) {
        if (![KeyChain isLogin]) {
            [self dismissViewControllerAnimated:NO completion:nil];
            //跳转登录注册
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            
            return;
        }
        if (self.immediateOpenBlock) {
            self.immediateOpenBlock();
        }
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


+ (void)showEscrowDialogActivityWithVCTitle:(NSString *)title andType:(HXBRechargeAndWithdrawalsLogicalJudgment)type andWithFromController:(UINavigationController *)nav{
    HXBDepositoryAlertViewController *alertVC = [[self alloc] init];
    alertVC.immediateOpenBlock = ^{
        [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_alertBtn];
        HXBOpenDepositAccountViewController *openDepositAccountVC = [[HXBOpenDepositAccountViewController alloc] init];
        openDepositAccountVC.title = title;
        openDepositAccountVC.type = type;
        [nav pushViewController:openDepositAccountVC animated:YES];
    };
    [nav presentViewController:alertVC animated:NO completion:nil];
}



#pragma - mark 懒加载
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.svgImageString = @"pic";
    }
    return _iconImageView;
}

- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.text = @"红小宝与恒丰银行完成对接";
        _topLabel.textColor = COR10;
        _topLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _topLabel;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.text = @"用户资金安全隔离";
        _bottomLabel.textColor = COR10;
        _bottomLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _bottomLabel;
}

- (UIButton *)immediateOpenBtn
{
    if (!_immediateOpenBtn) {
        _immediateOpenBtn = [UIButton btnwithTitle:@"立即开通恒丰银行存管账户" andTarget:self andAction:@selector(dismiss:) andFrameByCategory:CGRectZero];
        _immediateOpenBtn.backgroundColor = COR24;
        
    }
    return _immediateOpenBtn;
}
- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        _closeBtn.backgroundColor = [UIColor clearColor];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    }
    _closeBtn.contentMode = UIViewContentModeScaleAspectFit;
    return _closeBtn;
}

@end

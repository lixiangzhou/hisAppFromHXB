//
//  HXBCreditorBuyResultViewController.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/4/27.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBCreditorBuyResultViewController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HXBBaseView_MoreTopBottomView.h"
#import "HXBUMengShareManager.h"

@interface HXBCreditorBuyResultViewController ()<HXBLazyCatResponseDelegate>

/// 图标
@property (nonatomic, weak) UIImageView *iconView;
/// 大号文字
@property (nonatomic, weak) UILabel *titleLabel;
/// 小号描述文字容器
@property (nonatomic, weak) UIView *descView;
/// !
@property (nonatomic, weak) UIImageView *maskView;
/// 小号描述文字
@property (nonatomic, weak) UILabel *descLabel;
/// 第一个按钮
@property (nonatomic, weak) UIButton *firstBtn;
/// 第二个按钮
@property (nonatomic, weak) UIButton *secondBtn;
/// 中间的label数组
@property (nonatomic, strong) HXBBaseView_MoreTopBottomView *buy_massageLabel;

@end

@implementation HXBCreditorBuyResultViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];  
}

#pragma mark - UI

- (void)setUI {
    self.title = @"购买成功";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isRedColorWithNavigationBar = YES;
    
    // 图标
    // INPUT:
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconView];
    self.iconView = iconView;
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kHXBFountColor_333333_100;
    titleLabel.font = kHXBFont_38;
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    /// 添加中间的label
    [self.view addSubview:self.buy_massageLabel];
    
    // 描述
    UIView *descView = [UIView new];
    [self.view addSubview:descView];
    self.descView = descView;
    
    UILabel *descLabel = [UILabel new];
    descLabel.numberOfLines = 0;
    descLabel.font = kHXBFont_30;
    descLabel.textColor = kHXBFountColor_999999_100;
    [descView addSubview:descLabel];
    self.descLabel = descLabel;
    
    // ！
    UIImageView *maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tip"]];
    [descView addSubview:maskView];
    self.maskView = maskView;
    
    // 第一个按钮
    UIButton *firstBtn = [UIButton new];
    firstBtn.layer.cornerRadius = 4;
    firstBtn.layer.masksToBounds = YES;
    [firstBtn setTitleColor:kHXBFountColor_White_FFFFFF_100 forState:UIControlStateNormal];
    firstBtn.backgroundColor = kHXBColor_F55151_100;
    [firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    self.firstBtn = firstBtn;
    
    // 第二个按钮
    UIButton *secondBtn = [UIButton new];
    secondBtn.layer.cornerRadius = 4;
    secondBtn.layer.masksToBounds = YES;
    [secondBtn setTitleColor:kHXBColor_F55151_100 forState:UIControlStateNormal];
    secondBtn.backgroundColor = [UIColor whiteColor];
    secondBtn.layer.borderColor = kHXBColor_F55151_100.CGColor;
    secondBtn.layer.borderWidth = kXYBorderWidth;
    [secondBtn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    self.secondBtn = secondBtn;

}

- (void)setConstraints {
    kWeakSelf
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(HXBStatusBarAndNavigationBarHeight + kScrAdaptationH750(150)));
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(@(kScrAdaptationW750(295)));
        make.height.equalTo(@(kScrAdaptationH750(182)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(kScrAdaptationH(30));
        make.centerX.equalTo(weakSelf.view);
    }];
    
    [self.buy_massageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kScrAdaptationH750(95));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@((4 * kScrAdaptationH750(30) + 3 * kScrAdaptationH750(28))));
    }];
    
    [self.descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descView);
        make.height.equalTo(@14);
        make.width.equalTo(@14);
        make.top.equalTo(self.descView).offset(2);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.descView);
        make.left.equalTo(self.maskView.mas_right).offset(7);
    }];
    
    [self.firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descView.mas_bottom).offset(50);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@41);
    }];
    
    [self.secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstBtn.mas_bottom).offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@41);
    }];

    
}


#pragma mark - setData
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    
    HXBLazyCatResultBuyModel *resultModel = (HXBLazyCatResultBuyModel *)model.data;
    
    self.iconView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = resultModel.title;
    self.descLabel.text = resultModel.tips;
    
    [self.firstBtn setTitle:@"查看我的出借" forState:UIControlStateNormal];
    if (resultModel.isInviteActivityShow) {
        [self.secondBtn setTitle:resultModel.inviteActivityDesc forState:UIControlStateNormal];
    }
    
    [_buy_massageLabel setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[@"下一还款日", @"出借金额", @"实际买入本金", @"公允利息"];
        viewManager.rightStrArray = @[resultModel.nextRepayDate_new, resultModel.buyAmount_new, resultModel.principal_new, resultModel.interest_new];
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        viewManager.leftTextColor = kHXBColor_Grey_Font0_2;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        viewManager.leftLabelAlignment = NSTextAlignmentLeft;
        viewManager.rightLabelAlignment = NSTextAlignmentRight;
        return viewManager;
    }];

}


#pragma mark - Action
- (void)firstBtnClick:(UIButton *)btn {
    [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_LoanList object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)secondBtnClick:(UIButton *)btn {
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_inviteSucess_share];
    [HXBUMengShareManager showShareMenuViewInWindowWith:nil];
}

- (void)leftBackBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - setter
- (HXBBaseView_MoreTopBottomView *)buy_massageLabel {
    if (!_buy_massageLabel) {
        UIEdgeInsets edge = UIEdgeInsetsMake(0, kScrAdaptationW750(40), 0, kScrAdaptationW750(40));
        _buy_massageLabel = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:4 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH750(30) andTopBottomSpace:kScrAdaptationH750(28) andLeftRightLeftProportion:0 Space:edge andCashType:nil];
        [self.view addSubview:_buy_massageLabel];
    }
    return _buy_massageLabel;
}

@end

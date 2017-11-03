//
//  HxbFinancialAdvisorViewController.m
//  hoomxb
//  我的理财顾问
//  Created by hxb on 2017/10/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbFinancialAdvisorViewController.h"
#import "HXBFinancialAdvisorRequest.h"
#import "HXBFinancialAdvisorModel.h"

@interface HxbFinancialAdvisorViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *businessCardImageView;//名片
@property (nonatomic, strong) UIImageView *headBackgroundImageView;
@property (nonatomic, strong) UILabel *financialAdvisor_nameLabel;
@property (nonatomic, strong) UILabel *financialAdvisor_jobNumberTitleLabel;
@property (nonatomic, strong) UIImageView *financialAdvisor_jobNumberIconImg;
@property (nonatomic, strong) UILabel *financialAdvisor_jobNumberLabel;
@property (nonatomic, strong) UIImageView *financialAdvisor_phoneImg;
@property (nonatomic, strong) UILabel *financialAdvisor_phoneTitleLabel;
@property (nonatomic, strong) UILabel *financialAdvisor_phoneLabel;
@property (nonatomic, strong) UIView  *lineView;

@property (nonatomic, strong) HXBFinancialAdvisorModel *financialAdvisorModel;

@end

@implementation HxbFinancialAdvisorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isReadColorWithNavigationBar = YES;
    self.title = @"我的理财顾问";
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.businessCardImageView];
    [self setupSubViewFrame];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData_financialAdvisorInfo];
}

- (void)call{
    [HXBAlertManager callupWithphoneNumber:self.financialAdvisorModel.mobile andWithTitle:[NSString stringWithFormat:@"理财顾问： %@",self.financialAdvisorModel.name] Message:self.financialAdvisorModel.mobile];
}

- (void)setFinancialAdvisorModel:(HXBFinancialAdvisorModel *)financialAdvisorModel{
    _financialAdvisorModel = financialAdvisorModel;
    
    self.financialAdvisor_nameLabel.text = _financialAdvisorModel.name&&![_financialAdvisorModel.name isEqualToString:@""] ? _financialAdvisorModel.name : @"--";
    self.financialAdvisor_jobNumberLabel.text = _financialAdvisorModel.code&&![_financialAdvisorModel.code isEqualToString:@""] ? _financialAdvisorModel.code : @"--";
    
    self.financialAdvisor_phoneLabel.text = _financialAdvisorModel.mobile&&![_financialAdvisorModel.mobile isEqualToString:@""] ? _financialAdvisorModel.mobile : @"--";
    self.businessCardImageView.userInteractionEnabled = YES;
    self.financialAdvisor_phoneLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(call)];
    if (![self.financialAdvisor_phoneLabel.text isEqualToString:@"--"]) {
        _financialAdvisor_phoneLabel.textColor = RGBA(51, 51, 51, 1);
        [self.financialAdvisor_phoneLabel addGestureRecognizer:tap];
    }
}

- (void)loadData_financialAdvisorInfo{
    [HXBFinancialAdvisorRequest downLoadmyFinancialAdvisorInfoNoHUDWithSeccessBlock:^(HXBFinancialAdvisorModel *model) {
        kWeakSelf
        weakSelf.financialAdvisorModel = model;
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)setupSubViewFrame
{
    [self.headBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.headerView);
    }];
    [self.businessCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headBackgroundImageView).offset(kScrAdaptationH(72));
        make.width.equalTo(@kScrAdaptationW(361));
        make.centerX.equalTo(self.headBackgroundImageView);
        make.height.equalTo(@kScrAdaptationH(202));
    }];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(-87/2));
        make.centerX.equalTo(self.businessCardImageView);
        make.width.offset(kScrAdaptationW(98));
        make.height.offset(kScrAdaptationW(98));
    }];
    [self.financialAdvisor_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logoImageView);
        make.width.equalTo(@kScrAdaptationW(120));
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(54.5));
        make.height.equalTo(@kScrAdaptationH(31));
    }];
    [self.financialAdvisor_jobNumberIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(107.5));
        make.width.height.equalTo(@kScrAdaptationW(18));
        make.left.equalTo(self.businessCardImageView).offset(kScrAdaptationW(53));
    }];
    [self.financialAdvisor_jobNumberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(107.5));
        make.height.equalTo(@kScrAdaptationH(16));
        make.width.equalTo(@kScrAdaptationW(64));
        make.left.equalTo(self.businessCardImageView).offset(kScrAdaptationW(76));
    }];
    [self.financialAdvisor_jobNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(135.5));
        make.height.equalTo(@kScrAdaptationH(16));
        make.width.equalTo(@kScrAdaptationW(127.5));
        make.left.equalTo(self.businessCardImageView).offset(kScrAdaptationW(32.75));
    }];
    [self.financialAdvisor_phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(107.5));
        make.width.height.equalTo(@kScrAdaptationW(18));
        make.left.equalTo(self.businessCardImageView).offset(kScrAdaptationW(221));
    }];
    [self.financialAdvisor_phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(107.5));
        make.height.equalTo(@kScrAdaptationH(16));
        make.width.equalTo(@kScrAdaptationW(64));
        make.left.equalTo(self.businessCardImageView).offset(kScrAdaptationW(244));
    }];
    [self.financialAdvisor_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(135.5));
        make.height.equalTo(@kScrAdaptationH(16));
        make.width.equalTo(@kScrAdaptationW(127.5));
        make.left.equalTo(self.businessCardImageView).offset(kScrAdaptationW(208.5));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessCardImageView).offset(kScrAdaptationH(107.5));
        make.height.equalTo(@kScrAdaptationH(42));
        make.width.equalTo(@1);
        make.left.equalTo(self.businessCardImageView).offset(kScrAdaptationW(180));
    }];
}

- (UILabel *)financialAdvisor_nameLabel{
    if (!_financialAdvisor_nameLabel) {
        _financialAdvisor_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW((361-66)/2), kScrAdaptationH(54.5), kScrAdaptationW(120), kScrAdaptationH(31))];
        _financialAdvisor_nameLabel.font = kHXBFont_PINGFANGSC_REGULAR(22);
        _financialAdvisor_nameLabel.textAlignment = NSTextAlignmentCenter;
        _financialAdvisor_nameLabel.textColor = RGBA(51, 51, 51, 1);
        _financialAdvisor_nameLabel.text = @"--";
    }
    return _financialAdvisor_nameLabel;
}

- (UIImageView *)financialAdvisor_jobNumberIconImg{
    if (!_financialAdvisor_jobNumberIconImg) {
        _financialAdvisor_jobNumberIconImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW(53), kScrAdaptationH(107.5), kScrAdaptationW(18), kScrAdaptationW(18))];
        _financialAdvisor_jobNumberIconImg.image = [UIImage imageNamed:@"my_financialAdvisor_jobNumber"];
    }
      return _financialAdvisor_jobNumberIconImg;
}

- (UILabel *)financialAdvisor_jobNumberTitleLabel{
    if (!_financialAdvisor_jobNumberTitleLabel) {
        _financialAdvisor_jobNumberTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW(76), kScrAdaptationH(107.5), kScrAdaptationW(64), kScrAdaptationH(16))];
        _financialAdvisor_jobNumberTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        _financialAdvisor_jobNumberTitleLabel.text = @"员工工号";
        _financialAdvisor_jobNumberTitleLabel.textAlignment = NSTextAlignmentLeft;
        _financialAdvisor_jobNumberTitleLabel.textColor = RGBA(51, 51, 51, 1);
    }
    return _financialAdvisor_jobNumberTitleLabel;
}

-(UILabel *)financialAdvisor_jobNumberLabel{
    if (!_financialAdvisor_jobNumberLabel) {
        _financialAdvisor_jobNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW(32.75), kScrAdaptationH(135.5), kScrAdaptationW(127.5), kScrAdaptationH(16))];
        _financialAdvisor_jobNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        _financialAdvisor_jobNumberLabel.textColor = RGBA(153, 153, 153, 1);
        _financialAdvisor_jobNumberLabel.textAlignment =NSTextAlignmentCenter;
        _financialAdvisor_jobNumberLabel.text = @"--";
    }
    return _financialAdvisor_jobNumberLabel;
}

-(UIImageView *)financialAdvisor_phoneImg{
    if (!_financialAdvisor_phoneImg) {
        _financialAdvisor_phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW(221), kScrAdaptationH(107.5), kScrAdaptationW(18), kScrAdaptationW(18))];
        _financialAdvisor_phoneImg.image = [UIImage imageNamed:@"my_financialAdvisor_phone"];
    }
    return _financialAdvisor_phoneImg;
}

- (UILabel *)financialAdvisor_phoneTitleLabel{
    if (!_financialAdvisor_phoneTitleLabel) {
        _financialAdvisor_phoneTitleLabel =  [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW(244), kScrAdaptationH(109), kScrAdaptationW(64), kScrAdaptationH(16))];
        _financialAdvisor_phoneTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        _financialAdvisor_phoneTitleLabel.textColor = RGBA(51, 51, 51, 1);
        _financialAdvisor_phoneTitleLabel.textAlignment = NSTextAlignmentLeft;
        _financialAdvisor_phoneTitleLabel.text = @"联系电话";
    }
    return _financialAdvisor_phoneTitleLabel;
}

- (UILabel *)financialAdvisor_phoneLabel{
    if (!_financialAdvisor_phoneLabel) {
        _financialAdvisor_phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW(208.5), kScrAdaptationH(135.5), kScrAdaptationW(111.5), kScrAdaptationH(16))];
        _financialAdvisor_phoneLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        _financialAdvisor_phoneLabel.textColor = RGBA(153, 153, 153, 1);
        _financialAdvisor_phoneLabel.textAlignment = NSTextAlignmentCenter;
        _financialAdvisor_phoneLabel.text = @"--";
    }
    return _financialAdvisor_phoneLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(kScrAdaptationW(180), kScrAdaptationH(107.5), 1, kScrAdaptationH(42))];
        _lineView.backgroundColor = RGBA(221, 221, 221, 1);
    }
    return _lineView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64 , SCREEN_WIDTH , kScrAdaptationH(172.5))];
        [_headerView addSubview:self.headBackgroundImageView];
    }
    return _headerView;
}

- (UIImageView *)headBackgroundImageView
{
    if (!_headBackgroundImageView) {
        _headBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _headBackgroundImageView.image = [UIImage imageNamed:@"top"];
    }
    return _headBackgroundImageView;
}

- (UIImageView *)businessCardImageView{
    if (!_businessCardImageView) {
        _businessCardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW(7),kScrAdaptationH(72) , kScrAdaptationW(361), kScrAdaptationH(202))];
        _businessCardImageView.image = [UIImage imageNamed:@"my_financialAdvisor_background"];
        [_businessCardImageView addSubview:self.logoImageView];
        [_businessCardImageView addSubview:self.financialAdvisor_nameLabel];
        [_businessCardImageView addSubview:self.financialAdvisor_jobNumberTitleLabel];
        [_businessCardImageView addSubview:self.financialAdvisor_jobNumberIconImg];
        [_businessCardImageView addSubview:self.financialAdvisor_jobNumberLabel];
        [_businessCardImageView addSubview:self.financialAdvisor_phoneImg];
        [_businessCardImageView addSubview:self.financialAdvisor_phoneTitleLabel];
        [_businessCardImageView addSubview:self.financialAdvisor_phoneLabel];
        [_businessCardImageView addSubview:self.lineView];
    }
    return _businessCardImageView;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW((202-98)/2), kScrAdaptationH(-98/2), kScrAdaptationW(98), kScrAdaptationW(98))];
        _logoImageView.image = [UIImage imageNamed:@"my_financialAdvisor_headPortrait"];
    }
    return _logoImageView;
}


@end

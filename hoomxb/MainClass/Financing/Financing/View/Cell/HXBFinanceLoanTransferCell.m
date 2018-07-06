//
//  HXBFinanceLoanTransferCell.m
//  hoomxb
//
//  Created by lxz on 2018/7/5.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanceLoanTransferCell.h"

@interface HXBFinanceLoanTransferCell()
/// 名称
@property (nonatomic, strong) UILabel *nameLabel;
/// 剩余金额
@property (nonatomic, strong) UILabel *leftMoneyLabel;
/// 利率
@property (nonatomic, strong) UILabel *interestLabel;
/// 剩余期限
@property (nonatomic, strong) UILabel *leftMonthLabel;
/// 利率说明
@property (nonatomic, strong) UILabel *interestDescLabel;
/// 剩余期限说明
@property (nonatomic, strong) UILabel *leftMonthDescLabel;
/// 各种状态
@property (nonatomic, strong) UIButton *statusView;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation HXBFinanceLoanTransferCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setUI];
    [self setConstraints];
    return self;
}

// MARK: - UI
- (void)setUI {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.leftMoneyLabel];
    [self.contentView addSubview:self.interestLabel];
    [self.contentView addSubview:self.leftMonthLabel];
    [self.contentView addSubview:self.interestDescLabel];
    [self.contentView addSubview:self.leftMonthDescLabel];
    [self.contentView addSubview:self.statusView];
    [self.contentView addSubview:self.bottomLine];
}

- (void)setConstraints {
    kWeakSelf
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@kScrAdaptationW(17));
        make.left.equalTo(@kScrAdaptationW(15));
    }];
    
    [self.leftMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.nameLabel.mas_bottom);
        make.right.equalTo(@kScrAdaptationW(-15));
    }];
    
    [self.interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(kScrAdaptationW(10));
        make.left.equalTo(weakSelf.nameLabel);
    }];
    
    [self.leftMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.interestLabel.mas_bottom);
        make.left.equalTo(weakSelf.leftMonthDescLabel.mas_left);
    }];
    
    [self.interestDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@kScrAdaptationW(-17));
        make.left.equalTo(weakSelf.nameLabel);
    }];
    
    [self.leftMonthDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.interestDescLabel);
        make.right.equalTo(weakSelf.contentView.mas_centerX);
    }];
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@kScrAdaptationW(-15));
        make.bottom.equalTo(@kScrAdaptationW(-22.5));
        make.width.equalTo(@80);
        make.height.equalTo(@27);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.right.equalTo(@(kScrAdaptationW(-15)));
        make.height.equalTo(@0.5);
    }];
}

// MARK: - Setter

- (void)setLoanTruansferViewModel:(HXBFinHomePageViewModel_LoanTruansferViewModel *)loanTruansferViewModel {
    _loanTruansferViewModel = loanTruansferViewModel;
    
    self.nameLabel.text = loanTruansferViewModel.title;
    self.leftMoneyLabel.text = loanTruansferViewModel.leftTransAmount_YUAN;
    self.interestLabel.text = loanTruansferViewModel.interest;
    
    NSMutableAttributedString *leftMonths = [[NSMutableAttributedString alloc] initWithString:loanTruansferViewModel.loanTruansferListModel.leftMonths];
    [leftMonths appendAttributedString:[[NSAttributedString alloc] initWithString:@"个月" attributes:@{NSFontAttributeName: kHXBFont_24}]];
    self.leftMonthLabel.attributedText = leftMonths;
    
    [self.statusView setBackgroundImage:loanTruansferViewModel.statusBackgroundImage forState:UIControlStateNormal];
    [self.statusView setTitleColor:loanTruansferViewModel.statusTitleColor forState:UIControlStateNormal];
    [self.statusView setTitle:loanTruansferViewModel.loanTruansferListModel.statusText forState:UIControlStateNormal];
}

// MARK: - Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = kHXBFont_28;
        _nameLabel.textColor = kHXBColor_333333_100;
    }
    return _nameLabel;
}

- (UILabel *)leftMoneyLabel {
    if (!_leftMoneyLabel) {
        _leftMoneyLabel = [UILabel new];
        _leftMoneyLabel.font = kHXBFont_24;
        _leftMoneyLabel.textColor = UIColorFromRGB(0xD4AD72);
    }
    return _leftMoneyLabel;
}

- (UILabel *)interestLabel {
    if (!_interestLabel) {
        _interestLabel = [UILabel new];
        _interestLabel.font = [UIFont systemFontOfSize:kScrAdaptationW(25)];
        _interestLabel.textColor = UIColorFromRGB(0xFF3B2D);
    }
    return _interestLabel;
}

- (UILabel *)leftMonthLabel {
    if (!_leftMonthLabel) {
        _leftMonthLabel = [UILabel new];
        _leftMonthLabel.textColor = kHXBColor_333333_100;
    }
    return _leftMonthLabel;
}

- (UILabel *)interestDescLabel {
    if (!_interestDescLabel) {
        _interestDescLabel = [UILabel new];
        _interestDescLabel.text = @"年利率";
        _interestDescLabel.font = kHXBFont_24;
        _interestDescLabel.textColor = UIColorFromRGB(0x9295A2);
    }
    return _interestDescLabel;
}

- (UILabel *)leftMonthDescLabel {
    if (!_leftMonthDescLabel) {
        _leftMonthDescLabel = [UILabel new];
        _leftMonthDescLabel.font = kHXBFont_24;
        _leftMonthDescLabel.text = @"剩余期限";
        _leftMonthDescLabel.textColor = UIColorFromRGB(0x9295A2);
    }
    return _leftMonthDescLabel;
}

- (UIButton *)statusView {
    if (!_statusView) {
        _statusView = [[UIButton alloc]init];
        _statusView.titleLabel.font = kHXBFont_28;
        [_statusView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_statusView setBackgroundImage:[UIImage imageNamed:@"bt_bg_nor"] forState:UIControlStateNormal];
        _statusView.layer.cornerRadius = 2;
        _statusView.layer.masksToBounds = YES;
    }
    return _statusView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColorFromRGB(0xECECEC);
    }
    return _bottomLine;
}

@end

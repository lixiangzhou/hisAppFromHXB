//
//  HXBWithdrawRecordCell.m
//  hoomxb
//
//  Created by HXB-C on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBWithdrawRecordCell.h"
#import "HXBWithdrawRecordModel.h"
@interface HXBWithdrawRecordCell ()

/**
 提现金额
 */
@property (nonatomic, strong) UILabel *cashAmountLabel;
/**
 银行名称
 */
@property (nonatomic, strong) UILabel *bankNameLabel;
/**
 银行尾号
 */
@property (nonatomic, strong) UILabel *bankNumLabel;
/**
 提现状态描述
 */
@property (nonatomic, strong) UILabel *logDescLabel;

/**
 提现申请时间
 */
@property (nonatomic, strong) UILabel *applyTimeLabel;
/**
 提现状态对应文案描述
 */
@property (nonatomic, strong) UILabel *cashDrawStatusLabel;
/**
 分割线
 */
@property (nonatomic, strong) UIView *partingLineView;
@end


@implementation HXBWithdrawRecordCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubView];
        [self setupSubViewFrame];
    }
    return self;
}

#pragma mark - Private
- (void)setupSubView {
    [self.contentView addSubview:self.cashAmountLabel];
    [self.contentView addSubview:self.bankNameLabel];
    [self.contentView addSubview:self.bankNumLabel];
    [self.contentView addSubview:self.logDescLabel];
    [self.contentView addSubview:self.applyTimeLabel];
    [self.contentView addSubview:self.cashDrawStatusLabel];
    [self.contentView addSubview:self.partingLineView];
}

- (void)setupSubViewFrame {
    [self.cashAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kScrAdaptationH750(40));
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(30));
    }];
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cashAmountLabel.mas_left);
        make.top.equalTo(self.cashAmountLabel.mas_bottom).offset(kScrAdaptationH750(30));
    }];
    [self.bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankNameLabel.mas_right);
        make.centerY.equalTo(self.bankNameLabel);
    }];
    [self.logDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cashAmountLabel.mas_left);
        make.top.equalTo(self.bankNameLabel.mas_bottom).offset(kScrAdaptationH750(14));
    }];
    [self.cashDrawStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cashAmountLabel);
        make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-30));
    }];
    [self.applyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cashDrawStatusLabel.mas_right);
        make.centerY.equalTo(self.bankNameLabel);
    }];
    [self.partingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cashAmountLabel.mas_left);
        make.right.equalTo(self.cashDrawStatusLabel.mas_right);
        make.bottom.equalTo(self.contentView);
        make.height.offset(kHXBDivisionLineHeight);
    }];
}

#pragma mark - Getters and Setters

- (void)setWithdrawRecordModel:(HXBWithdrawRecordModel *)withdrawRecordModel {
    _withdrawRecordModel = withdrawRecordModel;
    self.cashAmountLabel.text = [NSString stringWithFormat:@"提现金额：%@元",withdrawRecordModel.cashAmount];
    self.bankNameLabel.text = withdrawRecordModel.bankName;
    self.bankNumLabel.text = withdrawRecordModel.bankLastNum;
    self.logDescLabel.text = withdrawRecordModel.logText;
    self.cashDrawStatusLabel.text = withdrawRecordModel.statusText;
    self.applyTimeLabel.text = withdrawRecordModel.applyTimeStr;
    if (withdrawRecordModel.isBlueColor) {
        self.cashDrawStatusLabel.textColor = COR30;
    } else {
        self.cashDrawStatusLabel.textColor = COR10;
    }
}
#pragma mark - Lazy
- (UILabel *)cashAmountLabel {
    if (!_cashAmountLabel) {
        _cashAmountLabel = [[UILabel alloc] init];
        _cashAmountLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _cashAmountLabel.textColor = COR6;
    }
    return _cashAmountLabel;
}
- (UILabel *)bankNameLabel {
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc] init];
        _bankNameLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _bankNameLabel.textColor = COR10;
    }
    return _bankNameLabel;
}
- (UILabel *)bankNumLabel {
    if (!_bankNumLabel) {
        _bankNumLabel = [[UILabel alloc] init];
        _bankNumLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _bankNumLabel.textColor = COR10;
    }
    return _bankNumLabel;
}
- (UILabel *)logDescLabel {
    if (!_logDescLabel) {
        _logDescLabel = [[UILabel alloc] init];
        _logDescLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _logDescLabel.textColor = COR10;
    }
    return _logDescLabel;
}
- (UILabel *)applyTimeLabel {
    if (!_applyTimeLabel) {
        _applyTimeLabel = [[UILabel alloc] init];
        _applyTimeLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _applyTimeLabel.textColor = COR10;
    }
    return _applyTimeLabel;
}
- (UILabel *)cashDrawStatusLabel {
    if (!_cashDrawStatusLabel) {
        _cashDrawStatusLabel = [[UILabel alloc] init];
        _cashDrawStatusLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
        _cashDrawStatusLabel.textColor = COR10;
    }
    return _cashDrawStatusLabel;
}
-(UIView *)partingLineView {
    if (!_partingLineView) {
        _partingLineView = [[UIView alloc] init];
        _partingLineView.backgroundColor = COR12;
    }
    return _partingLineView;
}
@end

//
//  HXBBankListCell.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankListCell.h"
#import "HXBBankList.h"
@interface HXBBankListCell ()

@property (nonatomic, strong) UIImageView *bankImageView;

@property (nonatomic, strong) UILabel *bankNameLabel;

@property (nonatomic, strong) UILabel *bankQuotaLabel;

@property (nonatomic, strong) UIView *line;

@end


@implementation HXBBankListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bankImageView];
        [self.contentView addSubview:self.bankNameLabel];
        [self.contentView addSubview:self.bankQuotaLabel];
        [self.contentView addSubview:self.line];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.offset(kScrAdaptationW(15));
        make.height.offset(kScrAdaptationW(40));
        make.width.offset(kScrAdaptationW(40));
    }];
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankImageView.mas_right).offset(kScrAdaptationW(18));
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(17));
        make.height.offset(kScrAdaptationH(14));
    }];
    [self.bankQuotaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankNameLabel.mas_left);
        make.top.equalTo(self.bankNameLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(12));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.offset(kHXBDivisionLineHeight);
    }];
}

- (void)setBankModel:(HXBBankList *)bankModel {
    _bankModel = bankModel;
    self.bankNameLabel.text = bankModel.name;
    self.bankQuotaLabel.text = bankModel.quota;
    self.bankImageView.svgImageString = [NSString stringWithFormat:@"%@.svg",bankModel.bankCode];
    NSLog(@"==name:%@ %@--",bankModel.name,bankModel.quota);
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = COR12;
    }
    return _line;
}
- (UIImageView *)bankImageView {
    if (!_bankImageView) {
        _bankImageView = [[UIImageView alloc] init];
        _bankImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bankImageView;
}

- (UILabel *)bankNameLabel {
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc] init];
        _bankNameLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _bankNameLabel.textColor = COR8;
    }
    return _bankNameLabel;
}

- (UILabel *)bankQuotaLabel {
    if (!_bankQuotaLabel) {
        _bankQuotaLabel = [[UILabel alloc] init];
        _bankQuotaLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _bankQuotaLabel.textColor = COR10;
    }
    return _bankQuotaLabel;
}

@end

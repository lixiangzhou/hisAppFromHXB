//
//  HXBChooseDiscountTableViewCell.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/10/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBChooseDiscountTableViewCell.h"

typedef enum : NSUInteger {
    MONEY_OFF,
    DISCOUNT,
} HXB_COUPON_TYPE;

@interface HXBChooseDiscountTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, assign) HXB_COUPON_TYPE type;
/** 横线 */
@property (nonatomic, strong) UIView *lineView;
@end


@implementation HXBChooseDiscountTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self buildCell];
    }
    return self;
}

- (void)buildCell {
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.selectImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.lineView];
    [self setUpFrame];
}

- (void)setUpFrame {
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.offset(kScrAdaptationW750(67.1));
        make.height.offset(kScrAdaptationH750(68.1));
    }];
    [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.width.offset(kScrAdaptationW750(32));
        make.height.offset(kScrAdaptationH750(32));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationW750(28));
        make.left.equalTo(self).offset(kScrAdaptationW750(92));
        make.height.offset(kScrAdaptationH750(30));
    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(kScrAdaptationH750(16));
        make.left.equalTo(_titleLabel.mas_left);
        make.height.offset(kScrAdaptationH750(24));
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kScrAdaptationW750(30));
        make.height.offset(kScrAdaptationH750(34));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.width.offset(kScreenWidth);
        make.height.offset(kScrAdaptationH(0.5));
    }];
}

- (void)setIsAvalible:(BOOL)isAvalible {
    _isAvalible = isAvalible;
    if (isAvalible) {
        _titleLabel.textColor = COR6;
        _detailLabel.textColor = COR8;
        _moneyLabel.textColor = COR33;
        _moneyLabel.hidden = NO;
        _selectImageView.hidden = NO;
    } else {
        _selectImageView.hidden = YES;
        _titleLabel.textColor = COR34;
        _detailLabel.textColor = COR34;
        _moneyLabel.hidden = YES;
    }
}

- (void)setIsHiddenLine:(BOOL)isHiddenLine {
    _isHiddenLine = isHiddenLine;
    _lineView.hidden = isHiddenLine;
}

- (void)setCouponModel:(HXBCouponModel *)couponModel {
    _couponModel = couponModel;
    _detailLabel.text = couponModel.summarySubtitle;
    _titleLabel.text = couponModel.summaryTitle;
    _moneyLabel.text = [NSString hxb_getPerMilWithDouble:-couponModel.valueActual.doubleValue];
    if (_hasSelect) {
        _selectImageView.image = [UIImage imageNamed:@"chooseCoupon"];
        _moneyLabel.textColor = COR33;
    } else {
        _selectImageView.image = [UIImage imageNamed:@"unselectCoupon"];
        _moneyLabel.textColor = COR6;
    }
    if (_isAvalible) {
        if ([couponModel.couponTypeText isEqualToString:@"满减券"]) {
            _iconImageView.image = [UIImage imageNamed:@"coupon_select"];
        } else {
            _iconImageView.image = [UIImage imageNamed:@"discount_select"];
        }
    } else {
        if ([couponModel.couponTypeText isEqualToString:@"满减券"]) {
            _iconImageView.image = [UIImage imageNamed:@"coupon"];
        } else {
            _iconImageView.image = [UIImage imageNamed:@"discount"];
        }
    }

}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

- (UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
        _selectImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _selectImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _titleLabel.textColor = COR6;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _detailLabel.textColor = COR8;
    }
    return _detailLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        _moneyLabel.textColor = COR6;
    }
    return _moneyLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UILabel alloc] init];
        _lineView.backgroundColor = COR12;
    }
    return _lineView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HXBFin_creditorChange_TableViewCell.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_creditorChange_TableViewCell.h"

@interface HXBFin_creditorChange_TableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
/** 预期收益 */
@property (nonatomic, strong) UILabel *detailLabel;
/** 横线 */
@property (nonatomic, strong) UIView *lineView;
/** 图片 */
@property (nonatomic, strong) UIImageView *bankImageView;
/** 小菊花 */
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation HXBFin_creditorChange_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self.contentView addSubview:self.bankImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.lineView];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.center = CGPointMake(kScreenWidth - kScrAdaptationW(60), kScrAdaptationH(25));
    [_activityView stopAnimating];
    [self.contentView addSubview:_activityView];
    
    [self setupFrame];
    
}

- (void)setupFrame {
    
    [_bankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kScrAdaptationW(15));
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.width.height.offset(kScrAdaptationW(25));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(_bankImageView.mas_right).offset(kScrAdaptationW(10));
        make.width.offset(kScrAdaptationW(200));
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(@(kScrAdaptationW(-15)));
        make.width.offset(kScreenWidth - kScrAdaptationW(200));
        make.height.offset(kScrAdaptationH(50));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.width.offset(kScreenWidth);
        make.height.offset(kHXBDivisionLineHeight);
    }];

}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    _titleLabel.text = titleStr;
    if ([_titleStr containsString:@"优惠券"]) {
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:_titleStr];
        [attributedStr addAttribute:NSFontAttributeName value:kHXBFont_PINGFANGSC_REGULAR(12) range:NSMakeRange(3, _titleStr.length - 3)];
        _titleLabel.attributedText = attributedStr;
        
    } else if ([_titleStr containsString:@"（"]) {
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:_titleStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:kHXBColor_999999_100 range:NSMakeRange(4, _titleStr.length - 4)];
        [attributedStr addAttribute:NSFontAttributeName value:kHXBFont_PINGFANGSC_REGULAR(12) range:NSMakeRange(4, _titleStr.length - 4)];
        _titleLabel.attributedText = attributedStr;
    }
}

- (void)setBankImageName:(NSString *)bankImageName {
    _bankImageName = bankImageName;
    if (!_bankImageName.length) {
        _bankImageView.width = 0;
        _bankImageView.hidden = YES;
    } else {
        _bankImageView.width = kScrAdaptationW(35);
        _bankImageView.hidden = NO;
        _bankImageView.svgImageString = [NSString stringWithFormat:@"%@.svg",_bankImageName];
    }
    kWeakSelf
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(@(kScrAdaptationW(15) + weakSelf.bankImageView.width));
        make.width.offset(kScrAdaptationW(200));
    }];
}

- (void)setIsStartAnimation:(BOOL)isStartAnimation {
    _isStartAnimation = isStartAnimation;
    if (isStartAnimation) {
        [_activityView startAnimating];
    } else {
        [_activityView stopAnimating];
    }
    _detailLabel.hidden = _isStartAnimation;
}

- (void)setDetailStr:(NSString *)detailStr {
    _detailStr = detailStr;
    _detailLabel.text = _detailStr;
}

- (void)setIsHeddenHine:(BOOL)isHeddenHine {
    _isHeddenHine = isHeddenHine;
    _lineView.hidden = isHeddenHine;
}

- (void)setIsDiscountRow:(BOOL)isDiscountRow {
    _isDiscountRow  = isDiscountRow;
    if (_isDiscountRow) {
        if (_hasBestCoupon) {
            _detailLabel.textColor = COR6;
        } else {
            _detailLabel.textColor = COR10;
        }
        
        [_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_titleLabel);
            make.right.equalTo(@(kScrAdaptationW(0)));
            make.width.offset(kScreenWidth - kScrAdaptationW(200));
            make.height.offset(kScrAdaptationH(50));
        }];
        
    } else {
        
        _detailLabel.textColor =COR6;
        [_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_titleLabel);
            make.right.equalTo(@(kScrAdaptationW(-15)));
            make.width.offset(kScreenWidth - kScrAdaptationW(200));
            make.height.offset(kScrAdaptationH(50));
        }];
    }
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = COR6;
        _titleLabel.text = @"可用余额：";
        _titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = COR6;
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    }
    return _detailLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UILabel alloc] init];
        _lineView.backgroundColor = COR12;
    }
    return _lineView;
}

- (UIImageView *)bankImageView {
    if (!_bankImageView) {
        _bankImageView = [[UIImageView alloc] init];
        _bankImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bankImageView;
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

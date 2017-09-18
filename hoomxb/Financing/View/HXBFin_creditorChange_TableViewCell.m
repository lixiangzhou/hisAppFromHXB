//
//  HXBFin_creditorChange_TableViewCell.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_creditorChange_TableViewCell.h"

@interface HXBFin_creditorChange_TableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
/** 预期收益 */
@property (nonatomic, strong) UILabel *detailLabel;
/** 横线 */
@property (nonatomic, strong) UIView *lineView;

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.lineView];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.width.offset(kScrAdaptationW(200));
        make.height.offset(kScrAdaptationH(50));
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
        make.height.offset(kScrAdaptationH(0.5));
    }];
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    _titleLabel.text = titleStr;
}

- (void)setDetailStr:(NSString *)detailStr {
    _detailStr = detailStr;
    _detailLabel.text = detailStr;
}

- (void)setIsHeddenHine:(BOOL)isHeddenHine {
    _isHeddenHine = isHeddenHine;
    _lineView.hidden = isHeddenHine;
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
        _detailLabel.text = @"100.00元";
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



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HXBFinanctingDetail_trustCell.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/9/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinanctingDetail_trustCell.h"
@interface HXBFinanctingDetail_trustCell ()

@property (nonatomic, strong) UILabel *returnTimeLabel;
@property (nonatomic, strong) UILabel *returnTypeLabel;


@end

@implementation HXBFinanctingDetail_trustCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

//MARK: - 引导视图
- (void)setupView {
    UILabel *firstLabel = [[UILabel alloc] init];
    UILabel *secondLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.returnTimeLabel];
    [self.contentView addSubview:self.returnTypeLabel];
    [self.contentView addSubview:firstLabel];
    [self.contentView addSubview:secondLabel];
    
    firstLabel.textColor = COR6;
    firstLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    firstLabel.textAlignment = NSTextAlignmentLeft;
    firstLabel.text = @"下个还款日";
    secondLabel.textColor = COR6;
    secondLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    secondLabel.textAlignment = NSTextAlignmentLeft;
    secondLabel.text = @"还款方式";
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(kScrAdaptationH(5));
        make.left.mas_equalTo(self.contentView).offset(15);
        make.height.offset(kScrAdaptationH(35));
        make.width.offset(kScrAdaptationW(120));
    }];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstLabel).offset(kScrAdaptationH(35));
        make.left.mas_equalTo(firstLabel);
        make.height.offset(kScrAdaptationH(35));
        make.width.offset(kScrAdaptationW(120));
    }];
    [_returnTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(firstLabel);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.height.offset(kScrAdaptationH(35));
        make.width.offset(kScrAdaptationW(120));
    }];
    [_returnTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(secondLabel);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.height.offset(kScrAdaptationH(35));
        make.width.offset(kScrAdaptationW(120));
    }];
    
}

- (void)setNextRepayDate:(NSString *)nextRepayDate {
    _nextRepayDate = nextRepayDate;
    _returnTimeLabel.text = nextRepayDate;
}

- (void)setRepaymentType:(NSString *)repaymentType {
    _repaymentType = repaymentType;
    _returnTypeLabel.text = repaymentType;
}

- (UILabel *)returnTimeLabel {
    if (!_returnTimeLabel) {
        _returnTimeLabel =[[UILabel alloc] init];
        _returnTimeLabel.textColor = COR9;
        _returnTimeLabel.font = kHXBFont_PINGFANGSC_REGULAR(13);
        _returnTimeLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _returnTimeLabel;
}

- (UILabel *)returnTypeLabel {
    if (!_returnTypeLabel) {
        _returnTypeLabel =[[UILabel alloc] init];
        _returnTypeLabel.textColor = COR9;
        _returnTypeLabel.font = kHXBFont_PINGFANGSC_REGULAR(13);
        _returnTypeLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _returnTypeLabel;
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

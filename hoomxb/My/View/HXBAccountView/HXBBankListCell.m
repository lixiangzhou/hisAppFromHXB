//
//  HXBBankListCell.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankListCell.h"

@interface HXBBankListCell ()

@property (nonatomic, strong) UIView *line;

@end


@implementation HXBBankListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        self.textLabel.textColor = COR8;
        self.detailTextLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        self.detailTextLabel.textColor = COR10;
        [self.contentView addSubview:self.line];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.offset(kScrAdaptationW(15));
        make.height.offset(kScrAdaptationW(40));
        make.width.offset(kScrAdaptationW(40));
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(kScrAdaptationW(18));
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(17));
        make.height.offset(kScrAdaptationH(14));
    }];
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(kScrAdaptationW(18));
        make.top.equalTo(self.textLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH(12));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.offset(kHXBDivisionLineHeight);
    }];
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = COR12;
    }
    return _line;
}

@end

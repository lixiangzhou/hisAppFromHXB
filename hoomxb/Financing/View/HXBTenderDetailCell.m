//
//  HXBTenderDetailCell.m
//  hoomxb
//
//  Created by lxz on 2018/1/19.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBTenderDetailCell.h"

NSString *const HXBTenderDetailCellIdentifier = @"HXBTenderDetailCellIdentifier";
const CGFloat HXBTenderDetailCellHeight = 81;

@interface HXBTenderDetailCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *tenderLabel;
@property (nonatomic, weak) UILabel *timeLimitLabel;
@property (nonatomic, weak) UILabel *moneyLabel;
@end

@implementation HXBTenderDetailCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUI];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    UILabel *titleLabel = [self getLabelWithText:@"" color:kHXBColor_Grey_Font0_2];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *tenderTitleLabel = [self getLabelWithText:@"标的等级  " color:UIColorFromRGB(0x999999)];
    [self.contentView addSubview:tenderTitleLabel];
    
    
    UILabel *tenderLabel = [self getLabelWithText:@"" color:kHXBColor_Grey_Font0_2];
    [self.contentView addSubview:tenderLabel];
    self.tenderLabel = tenderLabel;
    
    UILabel *timeLimitTitleLabel = [self getLabelWithText:@"借款期限  " color:UIColorFromRGB(0x999999)];
    [self.contentView addSubview:timeLimitTitleLabel];
    
    UILabel *timeLimitLabel = [self getLabelWithText:@"" color:kHXBColor_Grey_Font0_2];
    [self.contentView addSubview:timeLimitLabel];
    self.timeLimitLabel = timeLimitLabel;
    
    UILabel *moneyTitleLabel = [self getLabelWithText:@"借款金额  " color:UIColorFromRGB(0x999999)];
    [self.contentView addSubview:moneyTitleLabel];
    
    
    UILabel *moneyLabel = [self getLabelWithText:@"" color:RGB(244, 73, 73)];
    [self.contentView addSubview:moneyLabel];
    self.moneyLabel = moneyLabel;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(221, 221, 221);
    [self.contentView addSubview:lineView];
    
    CGFloat padding = 15;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(padding));
        make.right.equalTo(timeLimitTitleLabel.mas_left).offset(-padding);
    }];
    
    [tenderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.bottom.equalTo(@(-15));
    }];
    
    [tenderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tenderTitleLabel.mas_right);
        make.bottom.equalTo(tenderTitleLabel);
    }];
    
    [timeLimitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel);
        make.left.equalTo(self.mas_centerX);
    }];
    
    [timeLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLimitTitleLabel.mas_right);
        make.top.equalTo(titleLabel);
//        make.right.equalTo(@(-padding));
    }];
    
    [moneyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLimitTitleLabel);
        make.bottom.equalTo(tenderLabel);
    }];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyTitleLabel.mas_right);
        make.bottom.equalTo(moneyTitleLabel);
//        make.right.equalTo(@(-padding));
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding));
        make.right.equalTo(@(-padding));
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}

#pragma mark - Setter / Getter / Lazy
- (void)setModel:(HXBTenderDetailModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.timeLimitLabel.text = [NSString stringWithFormat:@"%@个月", model.months] ;
    self.tenderLabel.text = model.riskLevel;
    self.moneyLabel.text = [NSString hxb_getPerMilWithDouble:model.amount.doubleValue];
}

#pragma mark - Helper
- (UILabel *)getLabelWithText:(NSString *)text color:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = kHXBFont_PINGFANGSC_REGULAR(14);
    label.textColor = color;
    return label;
}


@end

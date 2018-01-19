//
//  HXBNewbieProductCell.m
//  hoomxb
//
//  Created by HXB-C on 2018/1/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBNewbieProductCell.h"
#import "HxbHomePageModel_DataList.h"
@interface HXBNewbieProductCell()

@property (nonatomic, strong) UILabel *subsidyInterestRateLabel;
@property (nonatomic, strong) UILabel *expectAnnualizedRatesLabel;

@property (nonatomic, strong) UILabel *lockLabel;
@property (nonatomic, strong) UILabel *lockTipLabel;

@property (nonatomic, strong) UIButton *purchaseButton;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) HXBColourGradientView *btnBackgroundView;

@property (nonatomic, strong) UIView *lineView;
@end


@implementation HXBNewbieProductCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.backgroundImageView];
        [self.contentView addSubview:self.subsidyInterestRateLabel];
        [self.contentView addSubview:self.expectAnnualizedRatesLabel];
        [self.contentView addSubview:self.lockLabel];
        [self.contentView addSubview:self.lockTipLabel];
        [self.contentView addSubview:self.purchaseButton];
        [self.contentView addSubview:self.lineView];
        [self setUI];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    [self.subsidyInterestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kScrAdaptationH750(60));
        make.centerX.equalTo(self.expectAnnualizedRatesLabel.mas_centerX);
    }];
    [self.expectAnnualizedRatesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(147));
        make.top.equalTo(self.subsidyInterestRateLabel.mas_bottom).offset(kScrAdaptationH750(25));
    }];
    [self.lockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.lockTipLabel.mas_centerX);
        make.centerY.equalTo(self.subsidyInterestRateLabel.mas_centerY);
    }];
    [self.lockTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kScrAdaptationW750(100));
        make.centerY.equalTo(self.expectAnnualizedRatesLabel.mas_centerY);
    }];
    [self.purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-kScrAdaptationH750(50));
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(75));
        make.right.equalTo(self.contentView).offset(-kScrAdaptationW750(75));
        make.height.offset(kScrAdaptationH750(76));
    }];
    [self.btnBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.purchaseButton);
    }];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.subsidyInterestRateLabel.mas_top);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kHXBSpacing_30);
        make.right.equalTo(self.contentView).offset(-kHXBSpacing_30);
        make.bottom.equalTo(self.contentView);
        make.height.offset(kHXBDivisionLineHeight);
    }];
}


#pragma mark - Network


#pragma mark - Delegate Internal

#pragma mark -


#pragma mark - Delegate External

#pragma mark -


#pragma mark - Setter

- (void)setHomePageModel_DataList:(HxbHomePageModel_DataList *)homePageModel_DataList {
    _homePageModel_DataList = homePageModel_DataList;
     if (![homePageModel_DataList.subsidyInterestRate isEqualToString:@"0"]) {
         NSString *messageStr = [NSString stringWithFormat:@"%.1f%%%@",[homePageModel_DataList.baseInterestRate doubleValue],homePageModel_DataList.subsidyInterestRate];
         NSRange range = [messageStr rangeOfString:homePageModel_DataList.subsidyInterestRate];
         self.subsidyInterestRateLabel.attributedText = [NSMutableAttributedString setupAttributeStringWithString:messageStr WithRange:(NSRange)range andAttributeColor:kHXBColor_FF6A0F_30 andAttributeFont:kHXBFont_PINGFANGSC_REGULAR_750(50)];
     }
     else {
         self.subsidyInterestRateLabel.text = [NSString stringWithFormat:@"%.1f%%",[homePageModel_DataList.baseInterestRate doubleValue]];
     }
    
    if (homePageModel_DataList.lockDays > 0) {
        self.lockLabel.text = [NSString stringWithFormat:@"%d",homePageModel_DataList.lockDays];
        self.lockTipLabel.text = @"期限（天）";
    }
    else if (homePageModel_DataList.lockPeriod > 0) {
        self.lockLabel.text = [NSString stringWithFormat:@"%@",homePageModel_DataList.lockPeriod];
        self.lockTipLabel.text = @"期限（月）";
    }
    [self.purchaseButton setTitle:homePageModel_DataList.cellBtnTitle forState:(UIControlStateNormal)];
    self.backgroundImageView.hidden = !homePageModel_DataList.isShowNewBieBackgroundImageView;
    self.lineView.hidden = homePageModel_DataList.isShowNewBieBackgroundImageView;
}

- (void)setCountDownString:(NSString *)countDownString {
    _countDownString = countDownString;
    
}

#pragma mark - Getter / Lazy

- (UILabel *)subsidyInterestRateLabel {
    if (!_subsidyInterestRateLabel) {
        _subsidyInterestRateLabel = [[UILabel alloc] init];
        _subsidyInterestRateLabel.textColor = kHXBColor_FF6A0F_30;
        _subsidyInterestRateLabel.text = @"--";
        _subsidyInterestRateLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(74);
    }
    return _subsidyInterestRateLabel;
}

- (UILabel *)expectAnnualizedRatesLabel
{
    if (!_expectAnnualizedRatesLabel) {
        _expectAnnualizedRatesLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 50, 120, 22)];
        _expectAnnualizedRatesLabel.textColor = kHXBColor_999999_100;
        _expectAnnualizedRatesLabel.text = @"平均历史年化收益";
        _expectAnnualizedRatesLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _expectAnnualizedRatesLabel;
}

- (UILabel *)lockLabel {
    if (!_lockLabel) {
        _lockLabel = [[UILabel alloc] init];
        _lockLabel.textColor = kHXBColor_FF6A0F_30;
        _lockLabel.text = @"--";
        _lockLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(74);
    }
    return _lockLabel;
}

- (UILabel *)lockTipLabel {
    if (!_lockTipLabel) {
        _lockTipLabel = [[UILabel alloc] init];
        _lockTipLabel.textColor = kHXBColor_999999_100;
        _lockTipLabel.text = @"期限（-）";
        _lockTipLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _lockTipLabel;
}

- (UIButton *)purchaseButton {
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _purchaseButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        [_purchaseButton setTitleColor:kHXBColor_FFFFFF_100 forState:UIControlStateNormal];
        _purchaseButton.enabled = NO;
        _purchaseButton.layer.borderWidth = kXYBorderWidth;
        _purchaseButton.layer.borderColor = RGB(255, 133, 133).CGColor;
        _purchaseButton.layer.cornerRadius = 4.0f;
        _purchaseButton.layer.masksToBounds = YES;
        _purchaseButton.backgroundColor = RGB(255, 247, 247);
        [_purchaseButton insertSubview:self.btnBackgroundView atIndex:0];
    }
    return _purchaseButton;
}

- (HXBColourGradientView *)btnBackgroundView {
    if (!_btnBackgroundView) {
        _btnBackgroundView = [[HXBColourGradientView alloc] init];
        NSArray *colorArrayTemp = @[
                                    @1.00,@0.73,@0.2,@1.00,
                                    @1.00,@0.47,@0.1,@1.00
                                    ];
        [_btnBackgroundView colorArray:colorArrayTemp andLength:2 andColorLocation:@[@0,@1]];
//        _btnBackgroundView.hidden = YES;
    }
    return _btnBackgroundView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomeNewbie"]];
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kHXBSpacingLineColor_DDDDDD_100;
    }
    return _lineView;
}

#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public


@end

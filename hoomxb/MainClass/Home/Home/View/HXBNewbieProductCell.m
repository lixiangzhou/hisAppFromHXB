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
    kWeakSelf
    [self.purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-kScrAdaptationH750(50));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW750(75));
        make.right.equalTo(weakSelf.contentView).offset(-kScrAdaptationW750(75));
        make.height.offset(kScrAdaptationH750(76));
    }];
    
    [self.subsidyInterestRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(kScrAdaptationH(40));
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH750(60));
        make.left.equalTo(weakSelf.purchaseButton.mas_left);
    }];
    [self.expectAnnualizedRatesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.subsidyInterestRateLabel.mas_bottom).offset(kScrAdaptationH750(20));
        make.centerX.equalTo(weakSelf.subsidyInterestRateLabel.mas_centerX);
    }];
    [self.lockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.lockTipLabel.mas_centerX);
        make.centerY.equalTo(weakSelf.subsidyInterestRateLabel.mas_centerY);
        
    }];
    [self.lockTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.expectAnnualizedRatesLabel.mas_centerY);
        make.right.equalTo(weakSelf.purchaseButton.mas_right);
    }];

    
    [self.btnBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakSelf.purchaseButton);
    }];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.subsidyInterestRateLabel.mas_top);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(kHXBSpacing_30);
        make.right.equalTo(weakSelf.contentView).offset(-kHXBSpacing_30);
        make.bottom.equalTo(weakSelf.contentView);
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
         NSString *subsidyInterestRate = [NSString stringWithFormat:@" +%.1f%%",[homePageModel_DataList.subsidyInterestRate doubleValue]];
         NSString *messageStr = [NSString stringWithFormat:@"%.1f%%%@",[homePageModel_DataList.expectedRate doubleValue],subsidyInterestRate];
         NSRange range = [messageStr rangeOfString:subsidyInterestRate];
         self.subsidyInterestRateLabel.attributedText = [NSMutableAttributedString setupAttributeStringWithString:messageStr WithRange:(NSRange)range andAttributeColor:kHXBColor_FF6A0F_100 andAttributeFont:kHXBFont_PINGFANGSC_REGULAR_750(50)];
     }
     else {
         self.subsidyInterestRateLabel.text = [NSString stringWithFormat:@"%.1f%%",[homePageModel_DataList.expectedRate doubleValue]];
     }
    
    if (homePageModel_DataList.lockDays > 0) {
        self.lockLabel.text = [NSString stringWithFormat:@"%d",homePageModel_DataList.lockDays];
        self.lockTipLabel.text = @"锁定期(天)";
    }
    else if (homePageModel_DataList.lockPeriod > 0) {
        self.lockLabel.text = [NSString stringWithFormat:@"%@",homePageModel_DataList.lockPeriod];
        self.lockTipLabel.text = @"锁定期(月)";
    }
    self.backgroundImageView.hidden = !homePageModel_DataList.isShowNewBieBackgroundImageView;
    self.lineView.hidden = homePageModel_DataList.isShowNewBieBackgroundImageView;
    
    [self setupBtnStyle];
}

- (void)setCountDownString:(NSString *)countDownString {
    _countDownString = countDownString;
    if (self.homePageModel_DataList.isCountDown) {
        if ([self.homePageModel_DataList.countDownLastStr doubleValue] > 0) {
            self.btnBackgroundView.hidden = YES;
            [self.purchaseButton setTitle:countDownString forState:(UIControlStateNormal)];
            [self.purchaseButton setTitleColor:kHXBColor_FF7D2F_100 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = kHXBColor_FF9535_100.CGColor;
            self.purchaseButton.backgroundColor = kHXBColor_FFFCF5_100;
        }
        else {
            self.btnBackgroundView.hidden = NO;
            [self.purchaseButton setTitleColor:kHXBColor_FFFFFF_100 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = [UIColor clearColor].CGColor;
            [self.purchaseButton setTitle:@"立即加入" forState:(UIControlStateNormal)];
        }
    }
    else {
        [self setupBtnStyle];
    }
}

/**
 根据数据返回
 */
- (void)setupBtnStyle
{
    if (!self.homePageModel_DataList.isCountDown) {
        if ([self.homePageModel_DataList.cellBtnTitle rangeOfString:@"开售"].location != NSNotFound) {
            self.btnBackgroundView.hidden = YES;
            [self.purchaseButton setTitleColor:kHXBColor_FF6A0F_100 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = kHXBColor_FF9535_100.CGColor;
            self.purchaseButton.backgroundColor = kHXBColor_FFFCF5_100;
        } else if([self.homePageModel_DataList.cellBtnTitle isEqualToString:@"立即加入"]) {
            self.btnBackgroundView.hidden = NO;
            [self.purchaseButton setTitleColor:COR15 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = [UIColor clearColor].CGColor;
        } else {
            self.btnBackgroundView.hidden = YES;
            [self.purchaseButton setTitleColor:kHXBColor_Font0_6 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = kHXBColor_Font0_5.CGColor;
            self.purchaseButton.backgroundColor = kHXBColor_Grey090909;
        }
        [self.purchaseButton setTitle:self.homePageModel_DataList.cellBtnTitle forState:(UIControlStateNormal)];

    } else {
        self.btnBackgroundView.hidden = NO;
        [self setCountDownString:self.countDownString];
    }
}

#pragma mark - Getter / Lazy

- (UILabel *)subsidyInterestRateLabel {
    if (!_subsidyInterestRateLabel) {
        _subsidyInterestRateLabel = [[UILabel alloc] init];
        _subsidyInterestRateLabel.textColor = kHXBColor_FF6A0F_100;
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
        _lockLabel.textColor = kHXBColor_FF6A0F_100;
        _lockLabel.text = @"--";
        _lockLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(74);
    }
    return _lockLabel;
}

- (UILabel *)lockTipLabel {
    if (!_lockTipLabel) {
        _lockTipLabel = [[UILabel alloc] init];
        _lockTipLabel.textColor = kHXBColor_999999_100;
        _lockTipLabel.text = @"期限(-)";
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
        _purchaseButton.layer.borderColor = kHXBColor_FF9535_100.CGColor;
        _purchaseButton.layer.cornerRadius = 4.0f;
        _purchaseButton.layer.masksToBounds = YES;
        _purchaseButton.backgroundColor = kHXBColor_FFFCF5_100;
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
        _btnBackgroundView.hidden = YES;
    }
    return _btnBackgroundView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_newbieList"]];
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

 //
//  HXBHomePageProductCell.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/12.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageProductCell.h"
#import "HxbHomeViewController.h"

#import "NSAttributedString+Util.h"
//#import "HXBMoneyManageDetailsViewController.h"
#import "UILabel+Util.h"

#import "HxbHomePageModel_DataList.h"
#import "SVGKImage.h"
#define RightItemPercent        0.436
#define BackWidth               (SCREEN_WIDTH - 16)

@interface HXBHomePageProductCell ()
@property (nonatomic, strong) UIImageView *recommendImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tagLabbel;
@property (nonatomic, strong) UILabel *expectAnnualizedRatesLabel;
@property (nonatomic, strong) UIButton *purchaseButton;
@property (nonatomic, strong) UILabel *expectAnnualizedRatesTitleLabel;
@property (nonatomic, strong) UILabel *investmentPeriodTitleLabel;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) HXBColourGradientView *colourGradientView;

/**
 抵扣券
 */
@property (nonatomic, strong) UIImageView *discountCouponImageView;

/**
 满减券
 */
@property (nonatomic, strong) UIImageView *moneyOffCouponImageView;

/**
 起投金额
 */
@property (nonatomic, strong) UILabel *minRegisterAmountLabel;
/**
 整存整取Label
 */
@property (nonatomic, strong) UILabel *planTitleLabel;
/**
 左边的竖线
 */
@property (nonatomic, strong) UIView *leftLine;
/**
 右边的竖线
 */
@property (nonatomic, strong) UIView *rightLine;
@end

@implementation HXBHomePageProductCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.recommendImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.tagLabbel];
        [self.contentView addSubview:self.expectAnnualizedRatesTitleLabel];
        [self.contentView addSubview:self.expectAnnualizedRatesLabel];
        [self.contentView addSubview:self.investmentPeriodTitleLabel];
        [self.contentView addSubview:self.minRegisterAmountLabel];
        [self.contentView addSubview:self.planTitleLabel];
        [self.contentView addSubview:self.leftLine];
        [self.contentView addSubview:self.rightLine];
        [self.contentView addSubview:self.purchaseButton];
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.discountCouponImageView];
        [self.contentView addSubview:self.moneyOffCouponImageView];
    }
    return self;
}

/**
 设置子控件的位置
 */
- (void)setupSubViewFrame
{
    if (!self.homePageModel_DataList.tag.length) {
        [self.tagLabbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-30));
            make.top.equalTo(self.contentView.mas_top).offset(kScrAdaptationH750(22));
            make.height.offset(kScrAdaptationH750(0));
        }];
    } else {
        [self.tagLabbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-30));
            make.top.equalTo(self.contentView.mas_top).offset(kScrAdaptationH750(22));
            make.height.offset(kScrAdaptationH750(25));
        }];
    }
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tagLabbel.mas_left).offset(kScrAdaptationW750(-10));
        make.centerY.equalTo(self.tagLabbel);
        make.height.with.offset(kScrAdaptationH750(25));
    }];
    
    [self.recommendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(50));
        make.top.equalTo(self.contentView);
        make.width.offset(kScrAdaptationW750(70));
        make.height.offset(kScrAdaptationH750(72));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLabbel.mas_bottom).offset(kScrAdaptationH750(50));
        make.centerX.equalTo(self.contentView);
        make.height.offset(kScrAdaptationH750(32));
    }];
    
    [self.expectAnnualizedRatesTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kScrAdaptationH750(30));
        make.height.offset(kScrAdaptationH(40));
    }];
    
    [self.expectAnnualizedRatesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.expectAnnualizedRatesTitleLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.height.offset(kScrAdaptationH750(24));
    }];
    
    [self.investmentPeriodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(75));
        make.top.equalTo(self.expectAnnualizedRatesLabel.mas_bottom).offset(kScrAdaptationH750(50));
        make.height.offset(kScrAdaptationH750(28));
    }];
    
    [self.minRegisterAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.investmentPeriodTitleLabel);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.planTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-75));
        make.centerY.equalTo(self.investmentPeriodTitleLabel);
    }];
    
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(255));
        make.centerY.equalTo(self.investmentPeriodTitleLabel);
        make.height.offset(kScrAdaptationH750(24));
        make.width.offset(kHXBPartingLineHeight);
        
    }];
    
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-255));
        make.centerY.equalTo(self.investmentPeriodTitleLabel);
        make.height.offset(kScrAdaptationH750(24));
        make.width.offset(kHXBPartingLineHeight);
    }];
    
    [self.purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationW750(75));
        make.right.equalTo(self.contentView.mas_right).offset(-kScrAdaptationW750(75));
        make.top.equalTo(self.investmentPeriodTitleLabel.mas_bottom).offset(kScrAdaptationH750(40)) ;
        make.height.equalTo(@kScrAdaptationH(38));
        
    }];
    
    [self.colourGradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.purchaseButton.mas_left);
        make.right.equalTo(self.purchaseButton.mas_right);
        make.top.equalTo(self.purchaseButton.mas_top);
        make.bottom.equalTo(self.purchaseButton.mas_bottom);
    }];
    
    
}



#pragma mark Set Methods

- (void)setHomePageModel_DataList:(HxbHomePageModel_DataList *)homePageModel_DataList
{
    _homePageModel_DataList = homePageModel_DataList;
    NSString *str = [NSString stringWithFormat:@"%@月期",homePageModel_DataList.lockPeriod];
    self.investmentPeriodTitleLabel.text = str;
    if (![homePageModel_DataList.fixExtraInterestRate isEqualToString:@"0"]) {
        self.expectAnnualizedRatesTitleLabel.text = [NSString stringWithFormat:@"%.1f%%%@",[homePageModel_DataList.baseInterestRate doubleValue],homePageModel_DataList.fixExtraInterestRate];
    } else {
        self.expectAnnualizedRatesTitleLabel.text = [NSString stringWithFormat:@"%.1f%%",[homePageModel_DataList.baseInterestRate doubleValue]];
    }
    self.minRegisterAmountLabel.text =  [NSString stringWithFormat:@"%d起投",homePageModel_DataList.minRegisterAmount];
    
    self.planTitleLabel.text = homePageModel_DataList.featuredSlogan;
    //根据数据返回
    [self setupBtnStyle];
    //是否显示tag
    [self isShowTag];
    //设置子控件的位置
    [self setupSubViewFrame];
    //设置显示的优惠券
    [self setupCoupon];
}

- (void)setupCoupon {
    self.moneyOffCouponImageView.hidden = !self.homePageModel_DataList.hasMoneyOffCoupon;
    self.discountCouponImageView.hidden = !self.homePageModel_DataList.hasDiscountCoupon;
    if (self.homePageModel_DataList.hasMoneyOffCoupon) {
        [self.moneyOffCouponImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(kScrAdaptationW750(10));
            make.width.offset(kScrAdaptationW750(60));
            make.height.offset(kScrAdaptationH750(28));
        }];
        [self.discountCouponImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.moneyOffCouponImageView.mas_right).offset(kScrAdaptationW750(10));
            make.width.offset(kScrAdaptationW750(60));
            make.height.offset(kScrAdaptationH750(28));
        }];
    } else {
        [self.discountCouponImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(kScrAdaptationW750(10));
            make.width.offset(kScrAdaptationW750(60));
            make.height.offset(kScrAdaptationH750(28));
        }];
    }
}


- (void)isShowTag {
    if (!self.homePageModel_DataList.tag.length) {
        self.icon.hidden = YES;
        self.tagLabbel.hidden = YES;
    } else {
        self.icon.hidden = NO;
        self.tagLabbel.hidden = NO;
        self.tagLabbel.text = self.homePageModel_DataList.tag;
    }
}


- (void)setCountDownString:(NSString *)countDownString
{
    _countDownString = countDownString;
    if (self.homePageModel_DataList.isCountDown) {
        self.colourGradientView.hidden = YES;
        [self.purchaseButton setTitle:countDownString forState:UIControlStateNormal];
        [self.purchaseButton setTitleColor:RGB(253, 54, 54) forState:UIControlStateNormal];
        self.purchaseButton.layer.borderColor = RGB(255, 133, 133).CGColor;
        self.purchaseButton.backgroundColor = RGB(255, 247, 247);
        if (self.homePageModel_DataList.countDownLastStr.integerValue <= 0) {
            self.homePageModel_DataList.isCountDown = NO;
            self.colourGradientView.hidden = NO;
            [self.purchaseButton setTitleColor:COR15 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = kHXBColor_Font0_5.CGColor;
            [self.purchaseButton setTitle:@"立即加入" forState:(UIControlStateNormal)];
        }
    }else
    {
        //根据数据返回
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
            self.colourGradientView.hidden = YES;
            [self.purchaseButton setTitleColor:COR29 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = RGB(255, 133, 133).CGColor;
            self.purchaseButton.backgroundColor = RGB(255, 247, 247);
        } else if([self.homePageModel_DataList.cellBtnTitle isEqualToString:@"立即加入"]) {
            self.colourGradientView.hidden = NO;
            [self.purchaseButton setTitleColor:COR15 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = kHXBColor_Font0_5.CGColor;
        } else {
            self.colourGradientView.hidden = YES;
            [self.purchaseButton setTitleColor:kHXBColor_Font0_6 forState:UIControlStateNormal];
            self.purchaseButton.layer.borderColor = kHXBColor_Font0_5.CGColor;
            self.purchaseButton.backgroundColor = kHXBColor_Grey090909;
        }
        [self.purchaseButton setTitle:self.homePageModel_DataList.cellBtnTitle forState:(UIControlStateNormal)];
        //        if ([self.homePageModel_DataList.unifyStatus isEqualToString:@"销售结束"]) {
//            [self.purchaseButton setTitleColor:kHXBColor_Font0_6 forState:UIControlStateNormal];
//            self.purchaseButton.layer.borderColor = kHXBColor_Font0_5.CGColor;
//            self.purchaseButton.backgroundColor = kHXBColor_Grey090909;
//        }else if([self.homePageModel_DataList.cellBtnTitle isEqualToString:@"收益中"]){
//            [self.purchaseButton setTitleColor:kHXBColor_Font0_6 forState:UIControlStateNormal];
//            self.purchaseButton.layer.borderColor = kHXBColor_Font0_5.CGColor;
//            self.purchaseButton.backgroundColor = kHXBColor_Grey090909;
//        }else{
//            [self.purchaseButton setTitleColor:COR29 forState:UIControlStateNormal];
//            self.purchaseButton.layer.borderColor = RGB(255, 133, 133).CGColor;
//            self.purchaseButton.backgroundColor = RGB(255, 247, 247);
//        }
    } else {
        self.colourGradientView.hidden = NO;
        [self setCountDownString:self.countDownString];
    }
}

#pragma mark Get Methods
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = COR6;
        _titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _titleLabel.text = @"红利计划";
    }
    return _titleLabel;
}

/**
 右边标签栏Label
 */
- (UILabel *)tagLabbel
{
    if (!_tagLabbel) {
        _tagLabbel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 0, 110, 14)];
        _tagLabbel.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _tagLabbel.textColor = COR6;
        _tagLabbel.hidden = YES;
    }
    return _tagLabbel;
}

-(UILabel *)expectAnnualizedRatesTitleLabel{
    if (!_expectAnnualizedRatesTitleLabel) {
        _expectAnnualizedRatesTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 80, 100, 15)];
        _expectAnnualizedRatesTitleLabel.text = @"--";
        _expectAnnualizedRatesTitleLabel.font = PINGFANG_Medium(40);
        _expectAnnualizedRatesTitleLabel.textColor = RGB(253, 54, 54);
    }
    return _expectAnnualizedRatesTitleLabel;
}

- (UILabel *)expectAnnualizedRatesLabel
{
    if (!_expectAnnualizedRatesLabel) {
        _expectAnnualizedRatesLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 50, 120, 22)];
        _expectAnnualizedRatesLabel.textColor = COR10;
        _expectAnnualizedRatesLabel.text = @"平均历史年化收益";
        _expectAnnualizedRatesLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _expectAnnualizedRatesLabel;
}
-(UILabel *)investmentPeriodTitleLabel{
    if (!_investmentPeriodTitleLabel) {
        _investmentPeriodTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake( RightItemPercent*SCREEN_WIDTH, 80, 80, 11)];
        _investmentPeriodTitleLabel.text = @"月期";
        _investmentPeriodTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _investmentPeriodTitleLabel.textColor = COR6;
    }
    return _investmentPeriodTitleLabel;
}

- (UILabel *)planTitleLabel {
    if (!_planTitleLabel) {
        _planTitleLabel = [[UILabel alloc] init];
        _planTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _planTitleLabel.textColor = COR6;
    }
    return _planTitleLabel;
}

- (UILabel *)minRegisterAmountLabel {
    if (!_minRegisterAmountLabel) {
        _minRegisterAmountLabel = [[UILabel alloc] init];
        _minRegisterAmountLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _minRegisterAmountLabel.textColor = COR6;
    }
    return _minRegisterAmountLabel;
}


- (UIButton *)purchaseButton
{
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.investmentPeriodTitleLabel.frame) + 10, 0, SCREEN_WIDTH - CGRectGetMaxX(self.investmentPeriodTitleLabel.frame) - 20, 36)];
        _purchaseButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        [_purchaseButton setTitleColor:COR15 forState:UIControlStateNormal];
        //        [_purchaseButton setTitle:@"加入" forState:UIControlStateNormal];
        [_purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _purchaseButton.enabled = NO;
        _purchaseButton.layer.borderWidth = kXYBorderWidth;
        _purchaseButton.layer.borderColor = RGB(255, 133, 133).CGColor;
        _purchaseButton.layer.cornerRadius = 4.0f;
        _purchaseButton.layer.masksToBounds = YES;
        _purchaseButton.backgroundColor = RGB(255, 247, 247);
        self.colourGradientView = [[HXBColourGradientView alloc] init];
        self.colourGradientView.hidden = YES;
        [_purchaseButton insertSubview:self.colourGradientView atIndex:0];
    }
    return _purchaseButton;
}

- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        _icon.image = [UIImage imageNamed:@"home_package"];
        _icon.hidden = YES;
    }
    return _icon;
}

- (UIImageView *)recommendImageView {
    if (!_recommendImageView) {
        _recommendImageView = [[UIImageView alloc] init];
        _recommendImageView.contentMode = UIViewContentModeScaleAspectFit;
        _recommendImageView.image = [UIImage imageNamed:@"Home_Recommend"];
    }
    return _recommendImageView;
}

- (UIView *)leftLine {
    if (!_leftLine) {
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = COR192;
    }
    return _leftLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = COR192;
    }
    return _rightLine;
}
- (UIImageView *)discountCouponImageView {
    if (!_discountCouponImageView) {
        _discountCouponImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_DiscountCoupon"]];
        _discountCouponImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _discountCouponImageView;
}

- (UIImageView *)moneyOffCouponImageView {
    if (!_moneyOffCouponImageView) {
        _moneyOffCouponImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_MoneyOffCoupon"]];
        _moneyOffCouponImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _moneyOffCouponImageView;
}

#pragma mark - 处理按钮点击事件
- (void)purchaseButtonClick
{
    //    NSLog(@"%s",__func__);
    if (self.purchaseButtonClickBlock) {
        self.purchaseButtonClickBlock();
    }
}


@end


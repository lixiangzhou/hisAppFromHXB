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

//@property (nonatomic, strong) UIView *backView;
//@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UILabel *expectAnnualizedRatesLabel;
//@property (nonatomic, strong) UILabel *investmentPeriodLabel;
//@property (nonatomic, strong) UILabel *purchaseLabel;
@property (nonatomic, strong) UIButton *purchaseButton;
@property (nonatomic, strong) UILabel *expectAnnualizedRatesTitleLabel;
//@property (nonatomic, strong) UILabel *extraInterestRateLabel;
@property (nonatomic, strong) UILabel *investmentPeriodTitleLabel;
@property (nonatomic, strong) UIImageView *icon;
//@property (nonatomic, strong) CategoryLabel *categoryLabel;
//@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) HXBColourGradientView *colourGradientView;
@end

@implementation HXBHomePageProductCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.backView];
//        [self.backView addSubview:self.titleLabel];
        [self.backView addSubview:self.promptLabel];
        [self.backView addSubview:self.expectAnnualizedRatesTitleLabel];
        [self.backView addSubview:self.expectAnnualizedRatesLabel];
//        [self.backView addSubview:self.extraInterestRateLabel];
        [self.backView addSubview:self.investmentPeriodTitleLabel];
//        [self.backView addSubview:self.investmentPeriodLabel];
//        [self.backView addSubview:self.purchaseLabel];
        [self.backView addSubview:self.purchaseButton];
        [self.backView addSubview:self.icon];
        
    }
    return self;
}

/**
 设置子控件的位置
 */
- (void)setupSubViewFrame
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kScrAdaptationW(17));
        make.right.equalTo(self.contentView.mas_right).offset(-kScrAdaptationW(17));
        make.top.equalTo(self.contentView.mas_top).offset(kScrAdaptationH(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kScrAdaptationH(20));
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(kScrAdaptationW(33));
        make.top.equalTo(self.backView.mas_top).offset(kScrAdaptationH(13));
        make.height.with.equalTo(@13);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(kScrAdaptationW(15));
        make.top.equalTo(self.backView.mas_top).offset(kScrAdaptationH(14));
        make.height.with.equalTo(@13);
    }];
    if (!self.homePageModel_DataList.tag.length) {
        [self.expectAnnualizedRatesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backView);
            make.top.equalTo(self.backView.mas_top).offset(kScrAdaptationH(27));
            make.height.offset(kScrAdaptationH(14));
        }];
    }else
    {
        [self.expectAnnualizedRatesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backView);
            make.top.equalTo(self.backView.mas_top).offset(kScrAdaptationH(48));
            make.height.offset(kScrAdaptationH(14));
        }];
    }
    [self.expectAnnualizedRatesTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.expectAnnualizedRatesLabel.mas_bottom).offset(kScrAdaptationH(5));
        make.height.offset(kScrAdaptationH(40));
    }];
    [self.investmentPeriodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.expectAnnualizedRatesTitleLabel.mas_bottom).offset(kScrAdaptationH(14));
        make.height.offset(kScrAdaptationH(14));
    }];
    [self.purchaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(kScrAdaptationW(20));
        make.right.equalTo(self.backView.mas_right).offset(-kScrAdaptationW(20));
        make.top.equalTo(self.investmentPeriodTitleLabel.mas_bottom).offset(kScrAdaptationH(17));
        make.height.equalTo(@kScrAdaptationH(38));
        
    }];
    [self.colourGradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.purchaseButton.mas_left);
        make.right.equalTo(self.purchaseButton.mas_right);
        make.top.equalTo(self.purchaseButton.mas_top);
        make.bottom.equalTo(self.purchaseButton.mas_bottom);
        
    }];
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setSelected:highlighted animated:animated];
//    if (highlighted) {
//        self.backView.backgroundColor = COR13;
//    }else{
//        self.backView.backgroundColor = [UIColor whiteColor];
//    }
}
//-(void)setExpectAnnualizedRatesTitleString:(NSString *)expectAnnualizedRatesTitleString{
//    _expectAnnualizedRatesTitleString = expectAnnualizedRatesTitleString;
//    _expectAnnualizedRatesTitleLabel.text = _expectAnnualizedRatesTitleString;
//}

#pragma mark Set Methods

- (void)setHomePageModel_DataList:(HxbHomePageModel_DataList *)homePageModel_DataList
{
    _homePageModel_DataList = homePageModel_DataList;
    _titleString = homePageModel_DataList.name;
//    self.titleLabel.text = _titleString;
    NSString *str = [NSString stringWithFormat:@"投资期限%@个月",homePageModel_DataList.lockPeriod];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 设置字体和设置字体的范围
    [attrStr addAttribute:NSForegroundColorAttributeName
                       value:RGB(253, 54, 54)
                       range:[str rangeOfString:homePageModel_DataList.lockPeriod]];
    self.investmentPeriodTitleLabel.attributedText = attrStr;
    
    if (![homePageModel_DataList.extraInterestRate isEqualToString:@"0"]) {
        self.expectAnnualizedRatesTitleLabel.text = [NSString stringWithFormat:@"%.2f%@%@",[homePageModel_DataList.baseInterestRate doubleValue],@"%",homePageModel_DataList.extraInterestRate];
    }else
    {
         self.expectAnnualizedRatesTitleLabel.text = [NSString stringWithFormat:@"%.2f%@",[homePageModel_DataList.baseInterestRate doubleValue],@"%"];
    }
    if (self.homePageModel_DataList.isHidden) {
        if (![self.homePageModel_DataList.unifyStatus isEqualToString:@"立即加入"]) {
            self.colourGradientView.hidden = YES;
            [self.purchaseButton setTitleColor:RGB(253, 54, 54) forState:UIControlStateNormal];
        }else
        {
            self.colourGradientView.hidden = NO;
            [self.purchaseButton setTitleColor:COR15 forState:UIControlStateNormal];
        }
        
        [self.purchaseButton setTitle:self.homePageModel_DataList.unifyStatus forState:UIControlStateNormal];
    }else
    {
        [self.purchaseButton setTitle:[[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:self.homePageModel_DataList.diffTime andDateFormat:@"mm分ss秒后可加入"] forState:UIControlStateNormal];
    }
    if (!homePageModel_DataList.tag.length) {
        self.icon.hidden = YES;
    }
    self.promptLabel.text = homePageModel_DataList.tag;
    //设置子控件的位置
    [self setupSubViewFrame];
    
}

- (void)setCountDownString:(NSString *)countDownString
{
    _countDownString = countDownString;
    if (!self.homePageModel_DataList.isHidden) {
        [self.purchaseButton setTitle:countDownString forState:UIControlStateNormal];
        [self.purchaseButton setTitleColor:RGB(253, 54, 54) forState:UIControlStateNormal];
        self.colourGradientView.hidden = YES;
    }else
    {
        [self.purchaseButton setTitle:@"立即加入" forState:UIControlStateNormal];
        self.colourGradientView.hidden = NO;
        [self.purchaseButton setTitleColor:COR15 forState:UIControlStateNormal];
    }
}
//- (void)setModel:(TopProductModel *)model
//{
//    _model = model;
//    self.purchaseLabel.text = model.getProductStatusString;
//    self.expectAnnualizedRatesLabel.attributedText = [NSMutableAttributedString transferWithString:model.interestStr rightLength:1 leftFont:HXB_Text_Font(22) rightFont:HXB_Text_Font(11)];
//    self.investmentPeriodLabel.attributedText = [NSMutableAttributedString transferWithString:model.periodStr rightLength:2 leftFont:HXB_Text_Font(22) rightFont:HXB_Text_Font(11)];
//    self.titleLabel.text = model.name;
//    [self.titleLabel sizeToFit];
//
//    
//    [self.backView addSubview:self.categoryLabel];
//    if (model.category == 0 || model.category == 3) {  //优质债券、定期理财
//        _expectAnnualizedRatesTitleLabel.text = @"年利率";
//        _investmentPeriodTitleLabel.text = @"还款期限";
//        self.categoryLabel.hidden = YES;
//    }else if (model.category ==1 ){     //债转
//        _expectAnnualizedRatesTitleLabel.text = @"年利率";
//        _investmentPeriodTitleLabel.text = @"剩余期限";
//        self.categoryLabel.hidden = NO;
//    }else if(model.category ==2){      //计划类
//        _expectAnnualizedRatesTitleLabel.text = @"预期年化";
//        _investmentPeriodTitleLabel.text = @"计划期限";
//        self.categoryLabel.hidden = YES;
//    }
//
//}


#pragma mark Get Methods
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.borderWidth = 0.5;
        _backView.layer.borderColor = RGBA(229, 229, 229, 1).CGColor;
    }
    return _backView;
}
//- (UILabel *)titleLabel
//{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 16, SCREEN_WIDTH -  200, 14)];
////        [_titleLabel sizeToFit];
//        _titleLabel.font = [UIFont systemFontOfSize:10];
//    }
//    return _titleLabel;
//}

/**
 右边标签栏Label
 */
- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 0, 110, 14)];
        _promptLabel.font = kHXBFont_PINGFANGSC_REGULAR(13);
        _promptLabel.text = @"喜迎国庆，立加息啦";
        _promptLabel.textColor = RGB(94, 149, 255);
    }
    return _promptLabel;
}

-(UILabel *)expectAnnualizedRatesTitleLabel{
    if (!_expectAnnualizedRatesTitleLabel) {
        _expectAnnualizedRatesTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 80, 100, 15)];
        _expectAnnualizedRatesTitleLabel.text = @"8.00%";
        _expectAnnualizedRatesTitleLabel.font = PINGFANG_Medium(40);
        _expectAnnualizedRatesTitleLabel.textColor = RGB(253, 54, 54);
    }
    return _expectAnnualizedRatesTitleLabel;
}

//- (UILabel *)extraInterestRateLabel
//{
//    if (!_extraInterestRateLabel) {
//        _extraInterestRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.expectAnnualizedRatesTitleLabel.right, self.expectAnnualizedRatesTitleLabel.bottom, 100, 15)];
//        _extraInterestRateLabel.text = @"+8.00%";
//        _extraInterestRateLabel.font = [UIFont systemFontOfSize:12];
//        _extraInterestRateLabel.textColor = COR7;
//    }
//    return _extraInterestRateLabel;
//}

- (UILabel *)expectAnnualizedRatesLabel
{
    if (!_expectAnnualizedRatesLabel) {
        _expectAnnualizedRatesLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 50, 120, 22)];
        _expectAnnualizedRatesLabel.textColor = COR10;
        _expectAnnualizedRatesLabel.text = @"预期年利率";
        _expectAnnualizedRatesLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _expectAnnualizedRatesLabel;
}
-(UILabel *)investmentPeriodTitleLabel{
    if (!_investmentPeriodTitleLabel) {
        _investmentPeriodTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake( RightItemPercent*SCREEN_WIDTH, 80, 80, 11)];
        _investmentPeriodTitleLabel.text = @"3个月";
        _investmentPeriodTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _investmentPeriodTitleLabel.textColor = COR10;
    }
    return _investmentPeriodTitleLabel;
}
//- (UILabel *)investmentPeriodLabel
//{
//    if (!_investmentPeriodLabel) {
//        _investmentPeriodLabel = [[UILabel alloc]initWithFrame:CGRectMake(RightItemPercent*SCREEN_WIDTH, 50, 50, 22)];
//        _investmentPeriodLabel.textColor = COR10;
//        _investmentPeriodLabel.text = @"期限";
//        _investmentPeriodLabel.font = [UIFont systemFontOfSize:12];
//    }
//    return _investmentPeriodLabel;
//}

//- (UILabel *)purchaseLabel
//{
//    if (!_purchaseLabel) {
//        _purchaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.investmentPeriodTitleLabel.frame) + 10, self.investmentPeriodLabel.y, SCREEN_WIDTH - CGRectGetMaxX(self.investmentPeriodTitleLabel.frame) - 20, 36)];
//        _purchaseLabel.font = HXB_Text_Font(13);
//        _purchaseLabel.textColor = COR8;
//        _purchaseLabel.text = @"加入";
//        _purchaseLabel.userInteractionEnabled = YES;
//        _purchaseLabel.textAlignment = NSTextAlignmentCenter;
//        _purchaseLabel.layer.borderWidth = 1.f;
//        _purchaseLabel.layer.borderColor = [COR10 CGColor];
//        _purchaseLabel.layer.cornerRadius = 4.0f;
//    }
//    return _purchaseLabel;
//}

- (UIButton *)purchaseButton
{
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.investmentPeriodTitleLabel.frame) + 10, 0, SCREEN_WIDTH - CGRectGetMaxX(self.investmentPeriodTitleLabel.frame) - 20, 36)];
        _purchaseButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
        [_purchaseButton setTitleColor:COR15 forState:UIControlStateNormal];
//        [_purchaseButton setTitle:@"加入" forState:UIControlStateNormal];
        [_purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _purchaseButton.enabled = NO;
        _purchaseButton.layer.borderWidth = 0.5;
        _purchaseButton.layer.borderColor = RGB(255, 133, 133).CGColor;
        _purchaseButton.layer.cornerRadius = 4.0f;
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
        SVGKImage *svgImage = [SVGKImage imageNamed:@"package.svg"];
        _icon.image = svgImage.UIImage;
    }
    return _icon;
}

//- (CategoryLabel *)categoryLabel
//{
//    if (!_categoryLabel) {
//        _categoryLabel = [[CategoryLabel alloc] init];
//        _categoryLabel.backgroundColor = RGB(254, 163, 163);
//        [_categoryLabel setLabelLetterSpace:5 font:[UIFont systemFontOfSize:10] str:@"债转"];
//        _categoryLabel.textAlignment = NSTextAlignmentCenter;
//        _categoryLabel.textColor = [UIColor whiteColor];
//    }
//    return _categoryLabel;
//}


#pragma mark - 处理按钮点击事件
- (void)purchaseButtonClick
{
//    NSLog(@"%s",__func__);
    if (self.purchaseButtonClickBlock) {
        self.purchaseButtonClickBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end

@implementation CategoryLabel

//- (void)drawTextInRect:(CGRect)rect {
//    UIEdgeInsets insets = {0, 4, 0, 0};
//    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
//}

@end

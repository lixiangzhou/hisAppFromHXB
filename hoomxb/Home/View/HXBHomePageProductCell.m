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

#define RightItemPercent        0.436
#define BackWidth               (SCREEN_WIDTH - 16)

@interface HXBHomePageProductCell ()

//@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *expectAnnualizedRatesLabel;
@property (nonatomic, strong) UILabel *investmentPeriodLabel;
@property (nonatomic, strong) UILabel *purchaseLabel;
@property (nonatomic, strong) UILabel *expectAnnualizedRatesTitleLabel;
@property (nonatomic, strong) UILabel *investmentPeriodTitleLabel;
@property (nonatomic, strong) CategoryLabel *categoryLabel;

@end

@implementation HXBHomePageProductCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.titleLabel];
        [self.backView addSubview:self.expectAnnualizedRatesTitleLabel];
        [self.backView addSubview:self.expectAnnualizedRatesLabel];
        [self.backView addSubview:self.investmentPeriodTitleLabel];
        [self.backView addSubview:self.investmentPeriodLabel];
        [self.backView addSubview:self.purchaseLabel];

    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setSelected:highlighted animated:animated];
    if (highlighted) {
        self.backView.backgroundColor = COR13;
    }else{
        self.backView.backgroundColor = [UIColor whiteColor];
    }
}
//-(void)setExpectAnnualizedRatesTitleString:(NSString *)expectAnnualizedRatesTitleString{
//    _expectAnnualizedRatesTitleString = expectAnnualizedRatesTitleString;
//    _expectAnnualizedRatesTitleLabel.text = _expectAnnualizedRatesTitleString;
//}
#pragma mark Set Methods
- (void)setHomeDataListViewModel:(HxbHomePageViewModel_dataList *)homeDataListViewModel{
    _homeDataListViewModel = homeDataListViewModel;
    _titleString = homeDataListViewModel.homePageModel_DataList.name;
    _titleLabel.text = _titleString;
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
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 159)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 4.f;
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_backView.bounds];
        _backView.layer.masksToBounds = NO;
        _backView.layer.shadowColor = COR12.CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        _backView.layer.shadowOpacity = 0.5f;
        _backView.layer.shadowPath = shadowPath.CGPath;
    }
    return _backView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 16, SCREEN_WIDTH - 90, 14)];
//        [_titleLabel sizeToFit];
        _titleLabel.font = HXB_Text_Font(14);
    }
    return _titleLabel;
}
-(UILabel *)expectAnnualizedRatesTitleLabel{
    if (!_expectAnnualizedRatesTitleLabel) {
        _expectAnnualizedRatesTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 80, 100, 11)];
//        _expectAnnualizedRatesTitleLabel.text = @"年利率";
        _expectAnnualizedRatesTitleLabel.font = HXB_Text_Font(12);
        _expectAnnualizedRatesTitleLabel.textColor = COR10;
    }
    return _expectAnnualizedRatesTitleLabel;
}

- (UILabel *)expectAnnualizedRatesLabel
{
    if (!_expectAnnualizedRatesLabel) {
        
        _expectAnnualizedRatesLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 50, 120, 22)];
        _expectAnnualizedRatesLabel.textColor = COR1;
    }
    return _expectAnnualizedRatesLabel;
}
-(UILabel *)investmentPeriodTitleLabel{
    if (!_investmentPeriodTitleLabel) {
        _investmentPeriodTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake( RightItemPercent*SCREEN_WIDTH, 80, 80, 11)];
//        titleLabel.text = @"还款期限";
        _investmentPeriodTitleLabel.font = HXB_Text_Font(12);
        _investmentPeriodTitleLabel.textColor = COR10;
    }
    return _investmentPeriodTitleLabel;
}
- (UILabel *)investmentPeriodLabel
{
    if (!_investmentPeriodLabel) {
        _investmentPeriodLabel = [[UILabel alloc]initWithFrame:CGRectMake(RightItemPercent*SCREEN_WIDTH, 50, 100, 22)];
        _investmentPeriodLabel.textColor = RGB(85, 85, 85);
    }
    return _investmentPeriodLabel;
}

- (UILabel *)purchaseLabel
{
    if (!_purchaseLabel) {
        _purchaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 107, SCREEN_WIDTH - 32, 36)];
        _purchaseLabel.font = HXB_Text_Font(13);
        _purchaseLabel.textColor = COR1;
        _purchaseLabel.text = @"立即加入";
        _purchaseLabel.userInteractionEnabled = YES;
        _purchaseLabel.textAlignment = NSTextAlignmentCenter;
        _purchaseLabel.layer.borderWidth = 1.f;
        _purchaseLabel.layer.borderColor = [COR1 CGColor];
    }
    return _purchaseLabel;
}

- (CategoryLabel *)categoryLabel
{
    if (!_categoryLabel) {
        _categoryLabel = [[CategoryLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 2, _titleLabel.y, 33, 14)];
        _categoryLabel.backgroundColor = RGB(254, 163, 163);
        [_categoryLabel setLabelLetterSpace:5 font:[UIFont systemFontOfSize:10] str:@"债转"];
        _categoryLabel.textAlignment = NSTextAlignmentCenter;
        _categoryLabel.textColor = [UIColor whiteColor];
    }
    return _categoryLabel;
}

@end

@implementation CategoryLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 4, 0, 0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end

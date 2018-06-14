//
//  HXBFinancting_PlanListTableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define DottedLineHeight 1

#import "HXBFinancting_PlanListTableViewCell.h"
#import "HXBFinHomePageViewModel_PlanList.h"
#import "HXBFinHomePageModel_PlanList.h"
#import "HXBFinHomePageViewModel_LoanList.h"
#import "HXBFinHomePageModel_LoanList.h"
#import "SVGKit/SVGKImage.h"
@interface HXBFinancting_PlanListTableViewCell ()

@property (nonatomic,strong) UILabel *nameLabel;                //计划名称
@property (nonatomic,strong) UILabel *expectedYearRateLable;    //预期年化
@property (nonatomic,strong) UILabel *lockPeriodLabel;          //计划期限
@property (nonatomic,strong) UILabel *addStatus;                //加入的状态
@property (nonatomic,strong) UILabel *preferentialLabel;        //打折的label
@property (nonatomic,strong) UIImageView *arrowImageView;       //时间的图标
@property (nonatomic,strong) UILabel *expectedYearRateLable_Const;
@property (nonatomic,strong) UILabel *lockPeriodLabel_Const;
@property (nonatomic,strong) UILabel *countDownLable;           //倒计时label
@property (nonatomic,strong) UILabel *tagLabel;                 //tag标签
@property (nonatomic,strong) UIImageView *tagLableImageView;
@property (nonatomic,strong) UIImageView *lineImageView;
@property (nonatomic,strong) UIImageView *HXBImageView;                   // 按月付息的icon
@property (nonatomic,strong) UIView *countDownView;                       //承载倒计时的View
@property (nonatomic,strong) UIImageView *moneyOffCouponImageView;        // 满减券
@property (nonatomic,strong) UIImageView *discountCouponImageView;        // 抵扣券
@property (nonatomic,strong) UIImageView *backgroundImageView;            // 大背景颜色

@end
@implementation HXBFinancting_PlanListTableViewCell

- (void)setFinPlanListViewModel:(HXBFinHomePageViewModel_PlanList *)finPlanListViewModel {
    _finPlanListViewModel = finPlanListViewModel;
    self.nameLabel.text = finPlanListViewModel.planListModel.name;
    self.addStatus.text = finPlanListViewModel.unifyStatus;
    self.countDownLable.text = finPlanListViewModel.countDownString;
    
    self.expectedYearRateLable.attributedText = finPlanListViewModel.expectedYearRateAttributedStr;
    self.expectedYearRateLable.textColor = (finPlanListViewModel.planType == planType_newComer) ? kHXBColor_FF7D2F_100 : kHXBColor_Red_090303;
    self.backgroundImageView.hidden = finPlanListViewModel.planType == planType_newComer ? NO : YES;
    self.lockPeriodLabel.text = finPlanListViewModel.lockPeriod;
    
    if (self.finPlanListViewModel.remainTimeString.length) {
        self.countDownLable.text = _finPlanListViewModel.remainTimeString;
    }
    self.addStatus.backgroundColor = finPlanListViewModel.addButtonBackgroundColor;
    self.addStatus.textColor = finPlanListViewModel.addButtonTitleColor;
    self.addStatus.layer.borderColor = finPlanListViewModel.addButtonBorderColor.CGColor;
    [self setupAddStatusWithPlanType:_finPlanListViewModel.planType status:self.addStatus.text];
    
    
    if (finPlanListViewModel.planType == planType_newComer) { // 如果是新手标，隐藏一些图标
        self.HXBImageView.hidden = YES;
        self.lineImageView.hidden = YES;
        self.arrowImageView.image = [UIImage imageNamed:@"finPlanList_CountDown_newComer"];
    } else {
        self.HXBImageView.hidden = [finPlanListViewModel.planListModel.cashType isEqualToString:@"HXB"] ? NO: YES;
        self.lineImageView.hidden = [finPlanListViewModel.planListModel.cashType isEqualToString:@"HXB"] ? NO: !finPlanListViewModel.planListModel.hasCoupon;
        self.arrowImageView.image = [UIImage imageNamed:@"finPlanList_CountDown_default"];
    }
    if (finPlanListViewModel.planListModel.tag.length > 0) {
        self.tagLabel.text = finPlanListViewModel.planListModel.tag;
        self.tagLableImageView.hidden = NO;
        self.tagLabel.hidden = NO;
    } else {
        self.tagLabel.hidden = YES;
        [self.tagLableImageView setHidden:YES];
    }
    [self.countDownLable setHidden:self.finPlanListViewModel.isHidden];
    [self.arrowImageView setHidden:self.finPlanListViewModel.isHidden];
    //设置优惠券
    [self setupCoupon];
}

- (void) setLoanListViewModel:(HXBFinHomePageViewModel_LoanList *)loanListViewModel {
    _loanListViewModel = loanListViewModel;
    HXBFinHomePageModel_LoanList *model = loanListViewModel.loanListModel;
    self.nameLabel.text = model.title;
    
    self.addStatus.backgroundColor = loanListViewModel.addButtonBackgroundColor;
    self.addStatus.textColor = loanListViewModel.addButtonTitleColor;
    self.addStatus.layer.borderColor = loanListViewModel.addButtonBorderColor.CGColor;

    
    self.expectedYearRateLable.attributedText = loanListViewModel.expectedYearRateAttributedStr;
    self.lockPeriodLabel.text = model.months;
    self.addStatus.text = loanListViewModel.status;
}


//设置优惠券
- (void)setupCoupon {
    self.moneyOffCouponImageView.hidden = !self.finPlanListViewModel.planListModel.hasMoneyOffCoupon;
    self.discountCouponImageView.hidden = !self.finPlanListViewModel.planListModel.hasDiscountCoupon;
    if (self.finPlanListViewModel.planListModel.hasMoneyOffCoupon) {
        [self.discountCouponImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineImageView.mas_bottom);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.moneyOffCouponImageView.mas_right).offset(kScrAdaptationW750(25));
            make.width.offset(kScrAdaptationW750(60));
        }];
    } else {
        [self.discountCouponImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lineImageView.mas_bottom);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(kScrAdaptationW750(30));
            make.width.offset(kScrAdaptationW750(60));
        }];
    }
}

//设置等待加入label的背景颜色
- (void)setupAddStatusWithPlanType:(PlanType)planType status:(NSString *)status {
    if ([status isEqualToString:@"等待加入"]) {
        if (planType == planType_newComer) {
            self.addStatus.backgroundColor = kHXBColor_FFFCF5_100;
            self.addStatus.layer.borderColor = kHXBColor_FF9535_100.CGColor;
            self.addStatus.textColor = kHXBColor_FF7D2F_100;
            self.countDownLable.textColor = kHXBColor_FF7D2F_100;
        } else {
            self.addStatus.backgroundColor = RGB(255, 247, 247);
            self.addStatus.layer.borderColor = RGB(255, 133, 133).CGColor;
            self.addStatus.textColor = RGB(253, 54, 54);
            self.countDownLable.textColor = HXBC_Red_Deep;
        }
    } else if ([status isEqualToString:@"立即加入"]) {
        if (planType == planType_newComer) {
            self.addStatus.backgroundColor = kHXBColor_FF7D2F_100;
            self.addStatus.layer.borderColor = kHXBColor_FF7D2F_100.CGColor;
            self.countDownLable.textColor = kHXBColor_FF7D2F_100;
        } else {
            self.addStatus.backgroundColor = kHXBColor_Red_090303;
            self.addStatus.layer.borderColor = kHXBColor_Red_090303.CGColor;
            self.countDownLable.textColor = HXBC_Red_Deep;
        }
        self.addStatus.textColor = [UIColor whiteColor];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupSubView {
    
    [self addSubUI];//添加子控件
    [self layoutSubUI];//布局UI
}

///添加子控件
- (void)addSubUI {
    //添加
    [self.contentView addSubview:self.backgroundImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.expectedYearRateLable];
    [self.contentView addSubview:self.expectedYearRateLable_Const];
    [self.contentView addSubview:self.lockPeriodLabel_Const];
    [self.contentView addSubview:self.lockPeriodLabel];
    [self.contentView addSubview:self.addStatus];
    [self.contentView addSubview:self.preferentialLabel];
    [self.contentView addSubview:self.countDownView];
    [self.countDownView addSubview:self.arrowImageView];
    [self.countDownView addSubview:self.countDownLable];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView addSubview:self.tagLableImageView];
    [self.contentView addSubview:self.lineImageView];
    [self.contentView addSubview:self.discountCouponImageView];
    [self.contentView addSubview:self.moneyOffCouponImageView];
    [self.contentView addSubview:self.HXBImageView];
}
///布局UI

- (void)layoutSubUI {
    kWeakSelf
    //布局
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH(13));
        make.bottom.left.right.equalTo(weakSelf.contentView);
    }];
    
    [self.moneyOffCouponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineImageView.mas_bottom);
        make.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW750(30));
        make.width.offset(kScrAdaptationW750(60));
    }];
    
    [self.discountCouponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineImageView.mas_bottom);
        make.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.moneyOffCouponImageView.mas_right).offset(kScrAdaptationW750(25));
        make.width.offset(kScrAdaptationW750(60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH750(32));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(15));
        make.height.equalTo(@(kScrAdaptationH750(25)));
        make.right.equalTo(weakSelf.contentView.mas_centerX);
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.tagLableImageView);
        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationW750(-30));
    }];
    [self.tagLableImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.nameLabel);
        make.right.equalTo(weakSelf.tagLabel.mas_left).offset(kScrAdaptationW750(-10));
        make.height.with.offset(kScrAdaptationH750(25));
    }];
    [self.nameLabel sizeToFit];
    [self.expectedYearRateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(kScrAdaptationH750(37));
        make.left.equalTo(weakSelf.nameLabel);
        make.height.equalTo(@(kScrAdaptationH(24)));
    }];
    [self.expectedYearRateLable_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.expectedYearRateLable);
        make.top.equalTo(weakSelf.expectedYearRateLable.mas_bottom).offset(kScrAdaptationH(10));
        make.height.equalTo(@(kScrAdaptationH(13)));
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.height.offset(DottedLineHeight);
        make.top.equalTo(weakSelf.expectedYearRateLable_Const.mas_bottom).offset(kScrAdaptationH750(30));
    }];
    
    [self.lockPeriodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.equalTo(weakSelf.expectedYearRateLable);
        make.centerX.equalTo(weakSelf.contentView.mas_centerX);
    }];
    [self.lockPeriodLabel_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.bottom.equalTo(weakSelf.expectedYearRateLable_Const);
        make.centerX.equalTo(weakSelf.lockPeriodLabel);
    }];
    [self.addStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.expectedYearRateLable);
        make.right.equalTo(@(kScrAdaptationW(-14)));
        make.height.equalTo(@(kScrAdaptationH(30)));
        make.width.equalTo(@(kScrAdaptationW(85)));
    }];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.expectedYearRateLable_Const);
        make.centerX.equalTo(weakSelf.addStatus);
        make.left.equalTo(weakSelf.arrowImageView.mas_left);
        make.right.equalTo(weakSelf.countDownLable.mas_right);
        make.bottom.equalTo(weakSelf.countDownLable.mas_bottom);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.countDownView.mas_left);
        make.height.top.equalTo(weakSelf.countDownLable);
        make.width.equalTo(weakSelf.countDownLable.mas_height);
    }];
    [self.preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH750(20));
        make.right.equalTo(weakSelf.arrowImageView);
        make.height.offset(kScrAdaptationH750(20));
    }];
    [self.countDownLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.countDownView);
        make.left.equalTo(weakSelf.arrowImageView.mas_right).offset(kScrAdaptationW(6));
        //        make.width.equalTo(@(kScrAdaptationW(36)));
        make.height.equalTo(@(kScrAdaptationH(13)));
    }];
    [self.HXBImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.moneyOffCouponImageView);
        make.right.equalTo(weakSelf.mas_right).offset(-kScrAdaptationW(15));
        make.width.equalTo(@(kScrAdaptationW750(146)));
        make.height.equalTo(@(kScrAdaptationH750(32)));
    }];
    
    [self.countDownLable setHidden: YES];
    [self.arrowImageView setHidden: YES];
    
    
}

#pragma mark - setter
//MARK: 倒计时的重要传递
- (void)setCountDownString:(NSString *)countDownString {
    _countDownString = countDownString;
    [self.countDownLable setHidden:self.finPlanListViewModel.isHidden];
    [self.arrowImageView setHidden:self.finPlanListViewModel.isHidden];
    
    if (self.finPlanListViewModel.remainTimeString.length) {
        self.countDownLable.text = _finPlanListViewModel.remainTimeString;
        return;
    }
    if (self.finPlanListViewModel.isCountDown) {
        self.countDownLable.text = countDownString;
        self.addStatus.text = @"等待加入";
        [self setupAddStatusWithPlanType:_finPlanListViewModel.planType status:self.addStatus.text];
    }
    if ([self.addStatus.text isEqualToString:@"等待加入"] && self.finPlanListViewModel.isHidden) {
        self.addStatus.text = @"立即加入";
        [self setupAddStatusWithPlanType:_finPlanListViewModel.planType status:self.addStatus.text];
    }
}
- (void)setLockPeriodLabel_ConstStr:(NSString *)lockPeriodLabel_ConstStr {
    _lockPeriodLabel_ConstStr = lockPeriodLabel_ConstStr;
    self.lockPeriodLabel_Const.text = lockPeriodLabel_ConstStr;
}
- (void)setExpectedYearRateLable_ConstStr:(NSString *)expectedYearRateLable_ConstStr {
    _expectedYearRateLable_ConstStr = expectedYearRateLable_ConstStr;
    _expectedYearRateLable_Const.text = _expectedYearRateLable_ConstStr;
}

#pragma mark Getter
- (UIImageView *)discountCouponImageView {
    if (!_discountCouponImageView) {
        _discountCouponImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_DiscountCoupon"]];
        _discountCouponImageView.contentMode = UIViewContentModeScaleAspectFit;
        _discountCouponImageView.hidden = YES;
    }
    return _discountCouponImageView;
}

- (UIImageView *)moneyOffCouponImageView {
    if (!_moneyOffCouponImageView) {
        _moneyOffCouponImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_MoneyOffCoupon"]];
        _moneyOffCouponImageView.contentMode = UIViewContentModeScaleAspectFit;
        _moneyOffCouponImageView.hidden = YES;
    }
    return _moneyOffCouponImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
        _nameLabel.textColor = kHXBColor_Grey_Font0_2;
    }
    return _nameLabel;
}
- (UILabel *) expectedYearRateLable{
    if (!_expectedYearRateLable) {
        _expectedYearRateLable = [[UILabel alloc]init];
        _expectedYearRateLable.font = kHXBFont_PINGFANGSC_REGULAR(24);
    }
    return _expectedYearRateLable;
}
- (UILabel *)lockPeriodLabel {
    if (!_lockPeriodLabel) {
        _lockPeriodLabel = [[UILabel alloc]init];
        _lockPeriodLabel.font = kHXBFont_PINGFANGSC_REGULAR(18);
        _lockPeriodLabel.textColor = kHXBColor_Grey_Font0_3;
        _lockPeriodLabel_Const.font = kHXBFont_PINGFANGSC_REGULAR(13);
        _lockPeriodLabel_Const.textColor = kHXBColor_Font0_6;
    }
    return _lockPeriodLabel;
}
- (UILabel *)addStatus {
    if (!_addStatus) {
        _addStatus = [[UILabel alloc] init];
        _addStatus.layer.borderWidth = kXYBorderWidth;
        
    }
    return _addStatus;
}
- (UILabel *)preferentialLabel {
    if (!_preferentialLabel) {
        _preferentialLabel = [[UILabel alloc]init];
        _addStatus.layer.cornerRadius = kScrAdaptationW(2.5);
        _addStatus.layer.masksToBounds = YES;
        _addStatus.backgroundColor = kHXBColor_Red_090303;
        _addStatus.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _addStatus.textColor = [UIColor whiteColor];
        _addStatus.textAlignment = NSTextAlignmentCenter;
    }
    return _preferentialLabel;
}
- (UILabel *)lockPeriodLabel_Const {
    if (!_lockPeriodLabel_Const) {
        _lockPeriodLabel_Const = [[UILabel alloc]init];
        _lockPeriodLabel_Const.text = self.lockPeriodLabel_ConstStr;
        _lockPeriodLabel_Const.textColor = [UIColor grayColor];
    }
    return _lockPeriodLabel_Const;
}
- (UILabel *)expectedYearRateLable_Const {
    if (!_expectedYearRateLable_Const) {
        _expectedYearRateLable_Const = [[UILabel alloc]init];
        _expectedYearRateLable_Const.font = kHXBFont_PINGFANGSC_REGULAR(13);
        _expectedYearRateLable_Const.textColor = kHXBColor_Font0_6;
    }
    return _expectedYearRateLable_Const;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}
- (UILabel *)countDownLable {
    if (!_countDownLable){
        _countDownLable = [[UILabel alloc]init];
        _countDownLable.font = kHXBFont_PINGFANGSC_REGULAR(13);
    }
    return _countDownLable;
}

- (UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _tagLabel.textColor = COR6;
    }
    return _tagLabel;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHXBDivisionLineHeight)];
        _lineImageView.image = [UIImageView imageWithLineWithImageView:_lineImageView];
        _lineImageView.hidden = YES;
    }
    return _lineImageView;
}

- (UIImageView *)tagLableImageView {
    if (!_tagLableImageView) {
        _tagLableImageView = [[UIImageView alloc]init];
        _tagLableImageView.image = [UIImage imageNamed:@"home_package"];
        _tagLableImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_tagLableImageView setHidden:YES];
    }
    return _tagLableImageView;
}

- (UIView *)countDownView {
    if (!_countDownView) {
        _countDownView = [[UIView alloc] init];
        _countDownView.backgroundColor = [UIColor clearColor];
    }
    return _countDownView;
    
}

- (UIImageView *)HXBImageView {
    if (!_HXBImageView) {
        _HXBImageView = [[UIImageView alloc]init];
        _HXBImageView.image = [UIImage imageNamed:@"finance_mouthTip"];
        _HXBImageView.contentMode = UIViewContentModeScaleAspectFit;
        _HXBImageView.hidden = YES;
    }
    return _HXBImageView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]init];
        _backgroundImageView.image = [UIImage imageNamed:@"planListBackImage"];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}

@end

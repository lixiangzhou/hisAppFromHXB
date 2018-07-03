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

@property (nonatomic, strong) UIView *topView;
@property (nonatomic,strong) UILabel *nameLabel;                //计划名称
@property (nonatomic,strong) UILabel *tagLabel;                 //tag标签

@property (nonatomic,strong) UILabel *expectedYearRateLable;    //预期年化
@property (nonatomic,strong) UILabel *lockPeriodLabel;          //计划期限
@property (nonatomic,strong) UILabel *expectedYearRateLable_Const;  // 平均历史年化收益
@property (nonatomic,strong) UILabel *lockPeriodLabel_Const;    // 适用期限

@property (nonatomic,strong) UILabel *addStatus;                //加入的状态

@property (nonatomic,strong) UIImageView *arrowImageView;       //时间的图标
@property (nonatomic,strong) UILabel *countDownLable;           //倒计时label
@property (nonatomic,strong) UIView *countDownView;                       //承载倒计时的View

@property (nonatomic, strong) UIView *bottomLine;


//@property (nonatomic,strong) UIImageView *moneyOffCouponImageView;        // 满减券
//@property (nonatomic,strong) UIImageView *discountCouponImageView;        // 抵扣券

@end
@implementation HXBFinancting_PlanListTableViewCell

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
    [self.contentView addSubview:self.topView];
    [self.topView addSubview:self.nameLabel];
    [self.topView addSubview:self.tagLabel];
    
    [self.contentView addSubview:self.expectedYearRateLable];
    [self.contentView addSubview:self.lockPeriodLabel];
    
    [self.contentView addSubview:self.expectedYearRateLable_Const];
    [self.contentView addSubview:self.lockPeriodLabel_Const];
    
    [self.contentView addSubview:self.addStatus];
    
    [self.contentView addSubview:self.countDownView];
    [self.countDownView addSubview:self.arrowImageView];
    [self.countDownView addSubview:self.countDownLable];

    [self.contentView addSubview:self.bottomLine];
//    [self.contentView addSubview:self.discountCouponImageView];
//    [self.contentView addSubview:self.moneyOffCouponImageView];
}
///布局UI

- (void)layoutSubUI {
    kWeakSelf
    //布局
    
//    [self.moneyOffCouponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.lineImageView.mas_bottom);
//        make.bottom.equalTo(weakSelf.contentView);
//        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW750(30));
//        make.width.offset(kScrAdaptationW750(60));
//    }];
//
//    [self.discountCouponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.lineImageView.mas_bottom);
//        make.bottom.equalTo(weakSelf.contentView);
//        make.left.equalTo(weakSelf.moneyOffCouponImageView.mas_right).offset(kScrAdaptationW750(25));
//        make.width.offset(kScrAdaptationW750(60));
//    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kScrAdaptationW(6)));
        make.right.left.equalTo(weakSelf.contentView);
        make.height.equalTo(@(kScrAdaptationW(34)));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.topView).offset(kScrAdaptationW(15));
        make.right.equalTo(weakSelf.topView.mas_centerX);
        make.bottom.equalTo(weakSelf.topView);
    }];
    
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.topView);
        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationW(-15));
        make.left.greaterThanOrEqualTo(weakSelf.topView.mas_centerX);
        make.height.equalTo(@kScrAdaptationH(20));
    }];
    
    [self.expectedYearRateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topView.mas_bottom).offset(kScrAdaptationW(16));
        make.left.equalTo(weakSelf.nameLabel);
        make.height.equalTo(@(kScrAdaptationH(25)));
    }];
    
    [self.expectedYearRateLable_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.expectedYearRateLable);
        make.top.equalTo(weakSelf.expectedYearRateLable.mas_bottom).offset(kScrAdaptationH(12));
        make.height.equalTo(@(kScrAdaptationH(13)));
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
        make.centerY.equalTo(weakSelf.expectedYearRateLable.mas_bottom);
        make.right.equalTo(@(kScrAdaptationW(-15)));
        make.height.equalTo(@(kScrAdaptationH(27)));
        make.width.equalTo(@(kScrAdaptationW(80)));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.right.equalTo(@(kScrAdaptationW(-15)));
        make.height.equalTo(@0.5);
    }];
//    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.expectedYearRateLable_Const);
//        make.centerX.equalTo(weakSelf.addStatus);
//        make.left.equalTo(weakSelf.arrowImageView.mas_left);
//        make.right.equalTo(weakSelf.countDownLable.mas_right);
//        make.bottom.equalTo(weakSelf.countDownLable.mas_bottom);
//    }];
//
//    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.countDownView.mas_left);
//        make.height.top.equalTo(weakSelf.countDownLable);
//        make.width.equalTo(weakSelf.countDownLable.mas_height);
//    }];
//
//    [self.countDownLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(weakSelf.countDownView);
//        make.left.equalTo(weakSelf.arrowImageView.mas_right).offset(kScrAdaptationW(6));
//        //        make.width.equalTo(@(kScrAdaptationW(36)));
//        make.height.equalTo(@(kScrAdaptationH(13)));
//    }];
    
    [self.countDownLable setHidden: YES];
    [self.arrowImageView setHidden: YES];
    
    
}

#pragma mark - setter
- (void)setFinPlanListViewModel:(HXBFinHomePageViewModel_PlanList *)finPlanListViewModel {
    _finPlanListViewModel = finPlanListViewModel;
    
    self.nameLabel.attributedText = finPlanListViewModel.nameAttributeString;
    self.tagLabel.attributedText = finPlanListViewModel.tagAttributeString;
    
    if (finPlanListViewModel.planListModel.novice) {
        [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.topView.hidden = YES;
    } else {
        [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@34);
        }];
        self.topView.hidden = NO;
    }
    
    self.addStatus.text = finPlanListViewModel.unifyStatus;
    self.addStatus.backgroundColor = finPlanListViewModel.addButtonBackgroundColor;
    self.addStatus.textColor = finPlanListViewModel.addButtonTitleColor;
    
    self.countDownLable.text = finPlanListViewModel.countDownString;
    
    self.expectedYearRateLable.attributedText = finPlanListViewModel.expectedYearRateAttributedStr;
    
    self.lockPeriodLabel.attributedText = finPlanListViewModel.lockPeriod;
    
    if (finPlanListViewModel.planListModel.novice == 1) {
        self.lockPeriodLabel_Const.text = finPlanListViewModel.planListModel.lockPeriod.length ? @"锁定期(月)" : @"锁定期(天)";
    } else {
        self.lockPeriodLabel_Const.text =  finPlanListViewModel.planListModel.lockPeriod.length ? @"适用期限(月)" : @"期限(天)";
    }
    
    if (self.finPlanListViewModel.remainTimeString.length) {
        self.countDownLable.text = _finPlanListViewModel.remainTimeString;
    }
    
    if (finPlanListViewModel.planType == planType_newComer) { // 如果是新手标，隐藏一些图标
        self.arrowImageView.image = [UIImage imageNamed:@"finPlanList_CountDown_newComer"];
    } else {
        self.arrowImageView.image = [UIImage imageNamed:@"finPlanList_CountDown_default"];
    }

    [self.countDownLable setHidden:self.finPlanListViewModel.isHidden];
    [self.arrowImageView setHidden:self.finPlanListViewModel.isHidden];
    //设置优惠券
    [self setupCoupon];
}

- (void)setLoanListViewModel:(HXBFinHomePageViewModel_LoanList *)loanListViewModel {
    _loanListViewModel = loanListViewModel;
    HXBFinHomePageModel_LoanList *model = loanListViewModel.loanListModel;
    self.nameLabel.text = model.title;
    
    self.addStatus.backgroundColor = loanListViewModel.addButtonBackgroundColor;
    self.addStatus.textColor = loanListViewModel.addButtonTitleColor;
    

    
    self.expectedYearRateLable.attributedText = loanListViewModel.expectedYearRateAttributedStr;
    self.lockPeriodLabel.text = model.months;
    self.addStatus.text = loanListViewModel.status;
}


//设置优惠券
- (void)setupCoupon {
//    self.moneyOffCouponImageView.hidden = !self.finPlanListViewModel.planListModel.hasMoneyOffCoupon;
//    self.discountCouponImageView.hidden = !self.finPlanListViewModel.planListModel.hasDiscountCoupon;
//    if (self.finPlanListViewModel.planListModel.hasMoneyOffCoupon) {
//        [self.discountCouponImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.lineImageView.mas_bottom);
//            make.bottom.equalTo(self.contentView);
//            make.left.equalTo(self.moneyOffCouponImageView.mas_right).offset(kScrAdaptationW750(25));
//            make.width.offset(kScrAdaptationW750(60));
//        }];
//    } else {
//        [self.discountCouponImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.lineImageView.mas_bottom);
//            make.bottom.equalTo(self.contentView);
//            make.left.equalTo(self.contentView).offset(kScrAdaptationW750(30));
//            make.width.offset(kScrAdaptationW750(60));
//        }];
//    }
}

//设置等待加入label的背景颜色
- (void)setupAddStatusWithPlanType:(PlanType)planType status:(NSString *)status {
    if ([status isEqualToString:@"等待加入"]) {
        self.addStatus.backgroundColor = UIColorFromRGB(0xF5F5F9);
        self.addStatus.textColor = UIColorFromRGB(0x9295A2);
        self.countDownLable.textColor = HXBC_Red_Deep;
    } else if ([status isEqualToString:@"立即加入"]) {
        self.addStatus.backgroundColor = kHXBColor_Red_090303;
        self.addStatus.textColor = [UIColor whiteColor];
        self.countDownLable.textColor = HXBC_Red_Deep;
    }
}

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

//- (void)setLockPeriodLabel_ConstStr:(NSString *)lockPeriodLabel_ConstStr {
//    _lockPeriodLabel_ConstStr = lockPeriodLabel_ConstStr;
//    self.lockPeriodLabel_Const.text = lockPeriodLabel_ConstStr;
//}

//- (void)setExpectedYearRateLable_ConstStr:(NSString *)expectedYearRateLable_ConstStr {
//    _expectedYearRateLable_ConstStr = expectedYearRateLable_ConstStr;
//    _expectedYearRateLable_Const.text = _expectedYearRateLable_ConstStr;
//}

#pragma mark - Getter
//- (UIImageView *)discountCouponImageView {
//    if (!_discountCouponImageView) {
//        _discountCouponImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_DiscountCoupon"]];
//        _discountCouponImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _discountCouponImageView.hidden = YES;
//    }
//    return _discountCouponImageView;
//}
//
//- (UIImageView *)moneyOffCouponImageView {
//    if (!_moneyOffCouponImageView) {
//        _moneyOffCouponImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_MoneyOffCoupon"]];
//        _moneyOffCouponImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _moneyOffCouponImageView.hidden = YES;
//    }
//    return _moneyOffCouponImageView;
//}

- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
    }
    return _topView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kHXBFont_28;
        _nameLabel.textColor = kHXBColor_333333_100;
    }
    return _nameLabel;
}

- (UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.font = kHXBFont_PINGFANGSC_REGULAR(11);
        _tagLabel.textColor = UIColorFromRGB(0xFD9718);
        _tagLabel.backgroundColor = kHXBColor_RGB(0.99, 0.59, 0, 0.08);
        _tagLabel.layer.cornerRadius = 1;
    }
    return _tagLabel;
}

- (UILabel *)expectedYearRateLable{
    if (!_expectedYearRateLable) {
        _expectedYearRateLable = [[UILabel alloc]init];
        _expectedYearRateLable.font = kHXBFont_PINGFANGSC_REGULAR(25);
        _expectedYearRateLable.textColor = UIColorFromRGB(0xFF3B2D);
    }
    return _expectedYearRateLable;
}

- (UILabel *)lockPeriodLabel {
    if (!_lockPeriodLabel) {
        _lockPeriodLabel = [[UILabel alloc]init];
        _lockPeriodLabel.font = kHXBFont_34;
        _lockPeriodLabel.textColor = kHXBColor_333333_100;
    }
    return _lockPeriodLabel;
}

- (UILabel *)lockPeriodLabel_Const {
    if (!_lockPeriodLabel_Const) {
        _lockPeriodLabel_Const = [[UILabel alloc]init];
        _lockPeriodLabel_Const.text = self.lockPeriodLabel_ConstStr;
        _lockPeriodLabel_Const.textColor = kHXBColor_333333_100;
        _lockPeriodLabel_Const.font = kHXBFont_24;
    }
    return _lockPeriodLabel_Const;
}

- (UILabel *)expectedYearRateLable_Const {
    if (!_expectedYearRateLable_Const) {
        _expectedYearRateLable_Const = [[UILabel alloc]init];
        _expectedYearRateLable_Const.font = kHXBFont_24;
        _expectedYearRateLable_Const.textColor = kHXBColor_333333_100;
        _expectedYearRateLable_Const.text = @"平均历史年化收益";
    }
    return _expectedYearRateLable_Const;
}

- (UILabel *)addStatus {
    if (!_addStatus) {
        _addStatus = [[UILabel alloc] init];
        _addStatus.textAlignment = NSTextAlignmentCenter;
        _addStatus.font = kHXBFont_28;
    }
    return _addStatus;
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

- (UIView *)countDownView {
    if (!_countDownView) {
        _countDownView = [[UIView alloc] init];
        _countDownView.backgroundColor = [UIColor clearColor];
    }
    return _countDownView;
    
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColorFromRGB(0xECECEC);
    }
    return _bottomLine;
}

@end

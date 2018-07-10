//
//  HXBFinancting_PlanListTableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define DottedLineHeight 1

#import "HXBFinancePlanListCell.h"
#import "HXBFinHomePageViewModel_PlanList.h"
#import "HXBFinHomePageModel_PlanList.h"
#import "HXBFinHomePageViewModel_LoanList.h"
#import "HXBFinHomePageModel_LoanList.h"
#import "SVGKit/SVGKImage.h"
@interface HXBFinancePlanListCell ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic,strong) UILabel *nameLabel;                //计划名称
@property (nonatomic,strong) UILabel *tagLabel;                 //tag标签

@property (nonatomic,strong) UILabel *expectedYearRateLable;    //预期年化
@property (nonatomic,strong) UILabel *lockPeriodLabel;          //计划期限
@property (nonatomic,strong) UILabel *expectedYearRateLable_Const;  // 平均历史年化收益
@property (nonatomic,strong) UILabel *lockPeriodLabel_Const;    // 适用期限

@property (nonatomic,strong) UIButton *statusView;                //加入的状态

@property (nonatomic,strong) UIButton *countDownView;           //倒计时label

@property (nonatomic, strong) UIView *happyView;    // 加息、满减、抵扣

@property (nonatomic, strong) UIView *bottomLine;

@end
@implementation HXBFinancePlanListCell

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
    
    [self.contentView addSubview:self.statusView];
    
    [self.contentView addSubview:self.countDownView];

    [self.contentView addSubview:self.happyView];
    
    [self.contentView addSubview:self.bottomLine];
}
///布局UI

- (void)layoutSubUI {
    kWeakSelf
    //布局
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
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.expectedYearRateLable.mas_bottom);
        make.right.equalTo(@(kScrAdaptationW(-15)));
        make.height.equalTo(@(kScrAdaptationH(27)));
        make.width.equalTo(@(kScrAdaptationW(80)));
    }];
    
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.statusView);
    }];
    
    [self.happyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel);
        make.top.equalTo(weakSelf.expectedYearRateLable_Const.mas_bottom);
        make.right.equalTo(weakSelf.statusView);
        make.height.equalTo(@33);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView);
        make.left.equalTo(@(kScrAdaptationW(15)));
        make.right.equalTo(@(kScrAdaptationW(-15)));
        make.height.equalTo(@0.5);
    }];

}

#pragma mark - setter
- (void)setFinPlanListViewModel:(HXBFinHomePageViewModel_PlanList *)finPlanListViewModel {
    _finPlanListViewModel = finPlanListViewModel;
    // 标题
    self.nameLabel.attributedText = finPlanListViewModel.nameAttributeString;
    // tag
    self.tagLabel.attributedText = finPlanListViewModel.tagAttributeString;
    
    // 顶部View是否显示，新手不显示
    [self setTopViews];
    
    // 状态
    
    [self.statusView setTitle:finPlanListViewModel.unifyStatus forState:UIControlStateNormal];
    [self.statusView setBackgroundImage:finPlanListViewModel.statusBackgroundImage forState:UIControlStateNormal];
    [self.statusView setTitleColor:finPlanListViewModel.statusTitleColor forState:UIControlStateNormal];
    
    // 利率
    self.expectedYearRateLable.attributedText = finPlanListViewModel.expectedYearRateAttributedStr;
    
    // 锁定期
    self.lockPeriodLabel.attributedText = finPlanListViewModel.lockPeriod;
    
    // 加息、抵扣、满减
    [self setHappyViews];
    
    // 倒计时
    self.countDownView.hidden = self.finPlanListViewModel.isHidden;
    if (self.finPlanListViewModel.remainTimeString.length) {
        [self.countDownView setTitle:finPlanListViewModel.remainTimeString forState:UIControlStateNormal];
    }
}

- (void)setTopViews {
    if (self.finPlanListViewModel.planListModel.novice) {
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
}

- (void)setHappyViews {
    if (self.finPlanListViewModel.hasHappyThing) {
        [self.happyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@33);
        }];
        self.happyView.hidden = NO;
        [self.happyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
        
        NSMutableArray *btnArray = [NSMutableArray new];
        // 加息
        if (self.finPlanListViewModel.planListModel) {
            NSString *text = [NSString stringWithFormat:@"加息%%%@", self.finPlanListViewModel.planListModel];
//            NSString *text = [NSString stringWithFormat:@"加息%@%%", @"0.5"];
            UIButton *btn = [UIButton new];
            btn.userInteractionEnabled = NO;
            [btn setBackgroundImage:[UIImage imageNamed:@"jx_background"] forState:UIControlStateNormal];
            [btn setTitle:text forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0xFF9817) forState:UIControlStateNormal];
            btn.titleLabel.font = kHXBFont_22;
            btn.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
            [btn sizeToFit];
            btn.size = CGSizeMake(btn.size.width + 4, 16);
//            [btnArray addObject:btn];
//            [self.happyView addSubview:btn];
        }
        // 满减
        if (self.finPlanListViewModel.planListModel.hasMoneyOffCoupon) {
            UIButton *btn = [UIButton new];
            btn.userInteractionEnabled = NO;
            [btn setBackgroundImage:[UIImage imageNamed:@"mj_background"] forState:UIControlStateNormal];
            [btn setTitle:@"满减 " forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0x4C7BFE) forState:UIControlStateNormal];
            btn.titleLabel.font = kHXBFont_22;
            btn.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
            btn.size = CGSizeMake(32, 16);
            [btnArray addObject:btn];
            [self.happyView addSubview:btn];
        }
        // 折扣
        if (self.finPlanListViewModel.planListModel.hasDiscountCoupon) {
            UIButton *btn = [UIButton new];
            btn.userInteractionEnabled = NO;
            [btn setBackgroundImage:[UIImage imageNamed:@"zk_background"] forState:UIControlStateNormal];
            [btn setTitle:@"折扣 " forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0xFF3B2D) forState:UIControlStateNormal];
            btn.titleLabel.font = kHXBFont_22;
            btn.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0);
            btn.size = CGSizeMake(32, 16);
            [btnArray addObject:btn];
            [self.happyView addSubview:btn];
        }
        
        CGFloat x = 0;
        for (NSInteger i = 0; i < btnArray.count; i++) {
            UIButton *btn = btnArray[i];
            [btn setX:x];
            [btn setY:17];
            x = x + btn.width + 4;
        }
    } else {
        [self.happyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.happyView.hidden = NO;
    }
}

//设置等待加入label的背景颜色
- (void)setupAddStatusWithPlanType:(PlanType)planType status:(NSString *)status {
    if ([status isEqualToString:@"等待加入"]) {
        [self.statusView setBackgroundImage:[UIImage imageNamed:@"list_bt_bg_dis"] forState:UIControlStateNormal];
        [self.statusView setTitleColor:UIColorFromRGB(0x9295A2) forState:UIControlStateNormal];
    } else if ([status isEqualToString:@"立即加入"]) {
        [self.statusView setBackgroundImage:[UIImage imageNamed:@"bt_bg_nor"] forState:UIControlStateNormal];
        [self.statusView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)setCountDownString:(NSString *)countDownString {
    _countDownString = countDownString;
    self.countDownView.hidden = self.finPlanListViewModel.isHidden;
    
    if (self.finPlanListViewModel.remainTimeString.length) {
        [self.countDownView setTitle:_finPlanListViewModel.remainTimeString forState:UIControlStateNormal];
        return;
    }
    if (self.finPlanListViewModel.isCountDown) {
        [self.countDownView setTitle:countDownString forState:UIControlStateNormal];
        [self.statusView setTitle:@"等待加入" forState:UIControlStateNormal];
        [self setupAddStatusWithPlanType:_finPlanListViewModel.planType status:self.statusView.currentTitle];
    }
    if ([self.statusView.currentTitle isEqualToString:@"等待加入"] && self.finPlanListViewModel.isHidden) {
        [self.statusView setTitle:@"立即加入" forState:UIControlStateNormal];
        [self setupAddStatusWithPlanType:_finPlanListViewModel.planType status:self.statusView.currentTitle];
    }
}

#pragma mark - Getter

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
        _expectedYearRateLable.font = [UIFont systemFontOfSize:kScrAdaptationW(25)];
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
        _lockPeriodLabel_Const.textColor = kHXBColor_333333_100;
        _lockPeriodLabel_Const.font = kHXBFont_24;
        _lockPeriodLabel_Const.text = @"适用出借期限";
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

- (UIButton *)statusView {
    if (!_statusView) {
        _statusView = [[UIButton alloc] init];
        _statusView.titleLabel.font = kHXBFont_28;
        _statusView.layer.cornerRadius = 2;
        _statusView.layer.masksToBounds = YES;
    }
    return _statusView;
}

- (UIButton *)countDownView {
    if (!_countDownView){
        _countDownView = [[UIButton alloc]init];
        _countDownView.titleLabel.font = kHXBFont_24;
        [_countDownView setBackgroundImage:[UIImage imageNamed:@"bt_bg_nor"] forState:UIControlStateNormal];
        _countDownView.layer.cornerRadius = 2;
        _countDownView.layer.masksToBounds = YES;
    }
    return _countDownView;
}


- (UIView *)happyView {
    if (!_happyView) {
        _happyView = [UIView new];
    }
    return _happyView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColorFromRGB(0xECECEC);
    }
    return _bottomLine;
}

@end

//
//  HXBFinancting_PlanListTableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancting_PlanListTableViewCell.h"
#import "HXBFinHomePageViewModel_PlanList.h"
#import "HXBFinHomePageModel_PlanList.h"
#import "HXBFinHomePageViewModel_LoanList.h"
#import "HXBFinHomePageModel_LoanList.h"
#import "SVGKImage.h"
@interface HXBFinancting_PlanListTableViewCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *expectedYearRateLable;//预期年化
@property (nonatomic,strong) UILabel *lockPeriodLabel;//计划期限
@property (nonatomic,strong) UILabel *addStatus;//加入的状态
@property (nonatomic,strong) UILabel *preferentialLabel;//打折的label
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) UILabel *expectedYearRateLable_Const;
@property (nonatomic,strong) UILabel *lockPeriodLabel_Const;
@property (nonatomic,strong) UILabel *countDownLable;//倒计时label
@property (nonatomic, strong) UILabel *tagLabel;//tag标签
@property (nonatomic,strong) UIImageView *tagLableImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *countDownView;//承载倒计时的View
@end
@implementation HXBFinancting_PlanListTableViewCell

- (void)setFinPlanListViewModel:(HXBFinHomePageViewModel_PlanList *)finPlanListViewModel {
    _finPlanListViewModel = finPlanListViewModel;
    HXBFinHomePageModel_PlanList *model = finPlanListViewModel.planListModel;
    self.nameLabel.text = model.name;
//    [self.countDownLable setHidden: !finPlanListViewModel.countDownString.integerValue];
//    [self.arrowImageView setHidden: !finPlanListViewModel.countDownString.integerValue];
    self.countDownLable.text = finPlanListViewModel.countDownString;
    self.expectedYearRateLable.attributedText = finPlanListViewModel.expectedYearRateAttributedStr;
    self.lockPeriodLabel.text = finPlanListViewModel.planListModel.lockPeriod;
    self.addStatus.text = finPlanListViewModel.unifyStatus;
    
    [self.countDownLable setHidden:self.finPlanListViewModel.isHidden];
    [self.arrowImageView setHidden:self.finPlanListViewModel.isHidden];
    if (self.finPlanListViewModel.remainTimeString.length) {
        self.countDownLable.text = _finPlanListViewModel.remainTimeString;
    }
    self.addStatus.backgroundColor = finPlanListViewModel.addButtonBackgroundColor;
    self.addStatus.textColor = finPlanListViewModel.addButtonTitleColor;
    self.addStatus.layer.borderColor = finPlanListViewModel.addButtonBorderColor.CGColor;
    self.addStatus.layer.borderWidth = kScrAdaptationH(0.8f);
    
    self.countDownLable.text = _finPlanListViewModel.remainTimeString;
    if (finPlanListViewModel.planListModel.tag.length > 0) {
        self.tagLabel.text = finPlanListViewModel.planListModel.tag;
        self.tagLableImageView.hidden = NO;
        self.tagLabel.hidden = NO;
    }else
    {
        self.tagLabel.hidden = YES;
        [self.tagLableImageView setHidden:YES];
    }
    [self setupAddStatus];
}
//设置等待加入label的背景颜色
- (void)setupAddStatus
{
    if ([self.addStatus.text isEqualToString:@"等待加入"]) {
        self.addStatus.backgroundColor = RGB(255, 247, 247);
        self.addStatus.textColor = RGB(253, 54, 54);
        self.addStatus.layer.borderColor = RGB(255, 133, 133).CGColor;
        self.addStatus.layer.borderWidth = kScrAdaptationH(0.5f);
    }
}

- (void) setLoanListViewModel:(HXBFinHomePageViewModel_LoanList *)loanListViewModel {
    _loanListViewModel = loanListViewModel;
    HXBFinHomePageModel_LoanList *model = loanListViewModel.loanListModel;
    self.nameLabel.text = model.title;
    
    self.addStatus.backgroundColor = loanListViewModel.addButtonBackgroundColor;
    self.addStatus.textColor = loanListViewModel.addButtonTitleColor;
    self.addStatus.layer.borderColor = loanListViewModel.addButtonBorderColor.CGColor;
    self.addStatus.layer.borderWidth = kXYBorderWidth;

    self.expectedYearRateLable.attributedText = loanListViewModel.expectedYearRateAttributedStr;
    self.lockPeriodLabel.text = model.months;
    self.addStatus.text = loanListViewModel.status;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
    }
    return _nameLabel;
}
- (UILabel *) expectedYearRateLable{
    if (!_expectedYearRateLable) {
        _expectedYearRateLable = [[UILabel alloc]init];
    }
    return _expectedYearRateLable;
}
- (UILabel *)lockPeriodLabel {
    if (!_lockPeriodLabel) {
        _lockPeriodLabel = [[UILabel alloc]init];
        
    }
    return _lockPeriodLabel;
}
- (UILabel *)addStatus {
    if (!_addStatus) {
        _addStatus = [[UILabel alloc]init];
        
    }
    return _addStatus;
}
- (UILabel *)preferentialLabel {
    if (!_preferentialLabel) {
        _preferentialLabel = [[UILabel alloc]init];
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
        _expectedYearRateLable_Const.textColor = [UIColor grayColor];
    }
    return _expectedYearRateLable_Const;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [SVGKImage imageNamed:@"FinPlanList_CountDown.svg"].UIImage;
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}
- (UILabel *)countDownLable {
    if (!_countDownLable){
        _countDownLable = [[UILabel alloc]init];
        _countDownLable.textColor = [UIColor blueColor];
        _countDownLable.text = @"a11111";

    }
    return _countDownLable;
}

- (UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.font = [UIFont systemFontOfSize:12];
    }
    return _tagLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kScrAdaptationH(120.5), kScreenWidth, kScrAdaptationH(0.5))];
        _lineView.backgroundColor = kHXBColor_Font0_5;
    }
    return _lineView;
}

- (UIImageView *)tagLableImageView {
    if (!_tagLableImageView) {
        _tagLableImageView = [[UIImageView alloc]init];
        _tagLableImageView.image = [SVGKImage imageNamed:@"FinPlanList_present.svg"].UIImage;
        _tagLableImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_tagLableImageView setHidden:true];
    }
    return _tagLableImageView;
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
        self.addStatus.backgroundColor = RGB(255, 247, 247);
        self.addStatus.textColor = RGB(253, 54, 54);
        self.addStatus.layer.borderColor = RGB(255, 133, 133).CGColor;
        self.addStatus.layer.borderWidth = kScrAdaptationH(0.5f);
    }
    if ([self.addStatus.text isEqualToString:@"等待加入"] && self.finPlanListViewModel.isHidden) {
        self.addStatus.text = @"立即加入";
        self.addStatus.backgroundColor = kHXBColor_Red_090303;
        self.addStatus.textColor = [UIColor whiteColor];
        self.addStatus.layer.borderColor = kHXBColor_Red_090303.CGColor;
        self.addStatus.layer.borderWidth = kXYBorderWidth;
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
- (void)setupSubView {
  
//    [self Tests];//测试数据
    [self addSubUI];//添加子控件
    [self layoutSubUI];//布局UI
    }
- (void)Tests {
    self.nameLabel.text = @"11111期";
    self.expectedYearRateLable.text = @"预期年化";
    self.lockPeriodLabel.text = @"3个月";
    self.addStatus.text = @"等待加入";
    self.preferentialLabel.text = @"限时8折，速速抢购";
    self.countDownLable.backgroundColor = [UIColor redColor];
    self.arrowImageView.backgroundColor = [UIColor redColor];
}
///添加子控件
- (void)addSubUI {
    //添加
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
    [self.contentView addSubview:self.lineView];
}
///布局UI
- (void)layoutSubUI {
    __weak typeof (self)weakSelf = self;
    //布局
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH(20));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(15));
        make.height.equalTo(@(kScrAdaptationH(15)));
    }];
    [self.tagLableImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.nameLabel);
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(10);
        make.height.with.equalTo(@(kScrAdaptationH(12)));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.tagLableImageView);
        make.left.equalTo(weakSelf.tagLableImageView.mas_right).offset(4);
    }];
    [self.nameLabel sizeToFit];
    [self.expectedYearRateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.left.equalTo(weakSelf.nameLabel);
        make.height.equalTo(@(kScrAdaptationH(24)));
    }];
    [self.expectedYearRateLable_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.expectedYearRateLable);
        make.top.equalTo(weakSelf.expectedYearRateLable.mas_bottom).offset(kScrAdaptationH(10));
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
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(@(kScrAdaptationW(-14)));
        make.height.equalTo(@(kScrAdaptationH(30)));
        make.width.equalTo(@(kScrAdaptationW(85)));
    }];
    [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addStatus.mas_bottom).offset(kScrAdaptationH(13));
        make.centerX.equalTo(weakSelf.addStatus);
        make.left.equalTo(weakSelf.arrowImageView.mas_left);
        make.right.equalTo(weakSelf.countDownLable.mas_right);
        make.bottom.equalTo(weakSelf.countDownLable.mas_bottom);
    }];
    //时间的图标
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countDownView.mas_left);
        make.height.top.equalTo(self.countDownLable);
        make.width.equalTo(self.countDownLable.mas_height);
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
    
    [self.countDownLable setHidden: true];
    [self.arrowImageView setHidden: true];
    
    self.nameLabel.font = kHXBFont_PINGFANGSC_REGULAR(13);
    self.nameLabel.textColor = kHXBColor_Grey_Font0_2;
    
    self.tagLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.tagLabel.textColor = RGB(94, 149, 255);
    
    self.expectedYearRateLable.font = kHXBFont_PINGFANGSC_REGULAR(24);
    self.expectedYearRateLable.textColor = kHXBColor_Red_090202;
    self.expectedYearRateLable_Const.font = kHXBFont_PINGFANGSC_REGULAR(13);
    self.expectedYearRateLable_Const.textColor = kHXBColor_Font0_6;
    
    self.lockPeriodLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
    self.lockPeriodLabel.textColor = kHXBColor_Grey_Font0_3;
    self.lockPeriodLabel_Const.font = kHXBFont_PINGFANGSC_REGULAR(13);
    self.lockPeriodLabel_Const.textColor = kHXBColor_Font0_6;
    
    self.countDownLable.text = @"59:02";
    self.countDownLable.textColor = HXBC_Red_Deep;
    self.countDownLable.font = kHXBFont_PINGFANGSC_REGULAR(13);
    
    self.addStatus.layer.cornerRadius = kScrAdaptationW(2.5);
    self.addStatus.layer.masksToBounds = true;
    self.addStatus.backgroundColor = kHXBColor_Red_090303;
    self.addStatus.font = kHXBFont_PINGFANGSC_REGULAR(14);
    self.addStatus.textColor = [UIColor whiteColor];
    self.addStatus.textAlignment = NSTextAlignmentCenter;
    
}

- (UIView *)countDownView
{
    if (!_countDownView) {
        _countDownView = [[UIView alloc] init];
        _countDownView.backgroundColor = [UIColor clearColor];
    }
    return _countDownView;
    
}


//- (NSMutableAttributedString *)setupAttributeStringWithString:(NSString *)string WithRange: (NSRange)range andAttributeColor: (UIColor *)color andAttributeFont: (UIFont *)font{
//        //添加字符串
//        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
//        //设置字体
//        [attr addAttribute:NSFontAttributeName value:font range: range];
//        //设置颜色
//        [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
//    
//        return attr;
//}


///富文本处理的知识
//- (void)setupAttributeStringWithString:(NSString *)string{
//    //添加123你好i am fine
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"123你好 i am fine"];
//    //设置123 redColor，
//    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, 3)];
//    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
//    //设置“你好” 为绿色
//    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(4, 2)];
//    [attr addAttribute:NSUnderlineColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(4, 2)];
//    [attr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleDouble) range:NSMakeRange(4, 2)];
//    //设置 “i am fine”为高亮
//    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(7, 2)];
//    self.expectedYearRateLable.attributedText = attr;
//
//}
@end

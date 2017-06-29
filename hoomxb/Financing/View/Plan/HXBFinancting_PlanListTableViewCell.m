//
//  HXBFinancting_PlanListTableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinancting_PlanListTableViewCell.h"
#import "HXBFinHomePageViewModel_PlanList.h"
#import "HXBFinHomePageModel_PlanList.h"
#import "HXBFinHomePageViewModel_LoanList.h"
#import "HXBFinHomePageModel_LoanList.h"
@interface HXBFinancting_PlanListTableViewCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *expectedYearRateLable;//语气年化
@property (nonatomic,strong) UILabel *lockPeriodLabel;//计划期限
@property (nonatomic,strong) UILabel *addStatus;//加入的状态
@property (nonatomic,strong) UILabel *preferentialLabel;//打折的label
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) UILabel *expectedYearRateLable_Const;
@property (nonatomic,strong) UILabel *lockPeriodLabel_Const;
@property (nonatomic,strong) UILabel *countDownLable;//倒计时label
@property (nonatomic, strong) UILabel *tagLabel;//tag标签
@end
@implementation HXBFinancting_PlanListTableViewCell

- (void)setFinPlanListViewModel:(HXBFinHomePageViewModel_PlanList *)finPlanListViewModel {
    _finPlanListViewModel = finPlanListViewModel;
    HXBFinHomePageModel_PlanList *model = finPlanListViewModel.planListModel;
    self.nameLabel.text = model.name;
    [self.countDownLable setHidden: !finPlanListViewModel.countDownString.integerValue];
    self.countDownLable.text = finPlanListViewModel.countDownString;
    self.expectedYearRateLable.attributedText = finPlanListViewModel.expectedYearRateAttributedStr;
    self.lockPeriodLabel.text = finPlanListViewModel.planListModel.lockPeriod;
    self.addStatus.text = finPlanListViewModel.unifyStatus;
    self.tagLabel.text = finPlanListViewModel.planListModel.tag;
}

- (void) setLoanListViewModel:(HXBFinHomePageViewModel_LoanList *)loanListViewModel {
    _loanListViewModel = loanListViewModel;
    HXBFinHomePageModel_LoanList *model = loanListViewModel.loanListModel;
    self.nameLabel.text = model.title;
    
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


#pragma mark - setter
//MARK: 倒计时的重要传递
- (void)setCountDownString:(NSString *)countDownString {
    _countDownString = countDownString;
    [self.countDownLable setHidden:!countDownString.integerValue];
    self.countDownLable.text = countDownString;
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
    self.countDownLable.backgroundColor = [UIColor redColor];
   
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
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.countDownLable];
    [self.contentView addSubview:self.tagLabel];
}
///布局UI
- (void)layoutSubUI {
    __weak typeof (self)weakSelf = self;
    //布局
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(20);
        make.left.equalTo(weakSelf.contentView).offset(20);
        make.right.equalTo(weakSelf.contentView).offset(-20);
    }];
    [self.expectedYearRateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.contentView).offset(20);
        make.height.equalTo(@20);
    }];
    [self.expectedYearRateLable_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.expectedYearRateLable);
        make.top.equalTo(weakSelf.expectedYearRateLable.mas_bottom).offset(20);
        make.height.equalTo(@20);
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
        make.right.equalTo(@(-80));
        make.height.equalTo(@20);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.centerY.equalTo(weakSelf.contentView);
        make.height.width.equalTo(@20);
    }];
    [self.preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(20);
        make.right.equalTo(weakSelf.arrowImageView);
        make.height.equalTo(@20);
    }];
    self.countDownLable.backgroundColor = [UIColor hxb_randomColor];
    [self.countDownLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addStatus.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.addStatus);
        make.right.equalTo(weakSelf.addStatus);
        make.height.equalTo(@20);
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.nameLabel);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-20);
    }];
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

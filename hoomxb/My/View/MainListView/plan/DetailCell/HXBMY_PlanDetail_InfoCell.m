//
//  HXBMY_PlanDetail_InfoCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanDetail_InfoCell.h"
#import "HXBMYViewModel_PlanDetailViewModel.h"

@interface HXBMY_PlanDetail_InfoCell ()
///加入金额
@property (nonatomic,strong) UILabel *addTheAmountLable;
///预期年利率
@property (nonatomic,strong) UILabel *expectedAnnualInterestRateLable;
///期限
@property (nonatomic,strong) UILabel *theTermLable;
///加入日期
@property (nonatomic,strong) UILabel *joinDateLable;

///加入金额const
@property (nonatomic,strong) UILabel *addTheAmountLable_const;
///预期年利率_const
@property (nonatomic,strong) UILabel *expectedAnnualInterestRateLable_const;
///期限_const
@property (nonatomic,strong) UILabel *theTermLable_const;
///加入日期_const
@property (nonatomic,strong) UILabel *joinDateLable_const;

@end

static NSString *kAddTheAmountLable_const = @"加入金额";
static NSString *kExpectedAnnualInterestRateLable_const = @"预期年利率";
static NSString *kTheTermLable_const = @"期限";
static NSString *kJoinDateLable_const = @"加入日期";

@implementation HXBMY_PlanDetail_InfoCell
- (void)setPlanDetailViewModel:(HXBMYViewModel_PlanDetailViewModel *)planDetailViewModel {
    self.addTheAmountLable.text = self.planDetailViewModel.planDetailModel.earnAmount;
    self.expectedAnnualInterestRateLable.text = self.planDetailViewModel.planDetailModel.amount;
    self.theTermLable.text = self.planDetailViewModel.planDetailModel.lockPeriod;
    self.joinDateLable.text = self.planDetailViewModel.planDetailModel.registerTime;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
    }
    return self;
}

- (void)setUP {
    [self creatSubView];
    [self layoutSubViews_PlanInfoCell];
    [self setUPConstLable];
}

- (void)creatSubView {
    
    self.addTheAmountLable = [[UILabel alloc]init];
    self.expectedAnnualInterestRateLable = [[UILabel alloc]init];
    self.theTermLable = [[UILabel alloc]init];
    self.joinDateLable = [[UILabel alloc]init];
    
    [self.contentView addSubview:self.addTheAmountLable];
    [self.contentView addSubview:self.expectedAnnualInterestRateLable];
    [self.contentView addSubview:self.theTermLable];
    [self.contentView addSubview:self.joinDateLable];
    
    
    self.addTheAmountLable_const = [[UILabel alloc]init];
    self.expectedAnnualInterestRateLable_const = [[UILabel alloc]init];
    self.theTermLable_const = [[UILabel alloc]init];
    self.joinDateLable_const = [[UILabel alloc]init];
    
    [self.contentView addSubview:self.addTheAmountLable_const];
    [self.contentView addSubview:self.expectedAnnualInterestRateLable_const];
    [self.contentView addSubview:self.theTermLable_const];
    [self.contentView addSubview:self.joinDateLable_const];
}


- (void)layoutSubViews_PlanInfoCell {
    __weak typeof(self) weakSelf = self;
    [self.addTheAmountLable_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH(10));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(10));
    }];
    [self.expectedAnnualInterestRateLable_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addTheAmountLable_const.mas_bottom).offset(kScrAdaptationH(10));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(10));
    }];
    [self.theTermLable_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.expectedAnnualInterestRateLable_const.mas_bottom).offset(kScrAdaptationH(10));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(10));
    }];
    [self.joinDateLable_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.theTermLable_const.mas_bottom).offset(kScrAdaptationH(10));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(10));
    }];
    

    [self.addTheAmountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.addTheAmountLable_const).offset(kScrAdaptationH(10));
        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationW(-10));
    }];
    [self.expectedAnnualInterestRateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.expectedAnnualInterestRateLable_const).offset(kScrAdaptationH(10));
        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationW(-10));
    }];
    [self.theTermLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.theTermLable_const).offset(kScrAdaptationH(10));
        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationW(-10));
    }];
    [self.joinDateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.joinDateLable_const).offset(kScrAdaptationH(10));
        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationW(-10));
    }];
}

- (void)setUPConstLable {
    self.addTheAmountLable_const.text = kAddTheAmountLable_const;
    self.expectedAnnualInterestRateLable_const.text = kExpectedAnnualInterestRateLable_const;
    self.theTermLable_const.text = kTheTermLable_const;
    self.joinDateLable_const.text = kJoinDateLable_const;
}
@end

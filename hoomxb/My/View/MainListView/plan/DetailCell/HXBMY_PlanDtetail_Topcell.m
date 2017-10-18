//
//  HXBMY_PlanDtetail_Topcell.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanDtetail_Topcell.h"
#import "HXBMYViewModel_PlanDetailViewModel.h"

@interface HXBMY_PlanDtetail_Topcell ()
@property (nonatomic,strong) UILabel *inComeLable;
@property (nonatomic,strong) UILabel *inComeLable_Const;
@property (nonatomic,strong) UILabel *planTypeLable;
@property (nonatomic,strong) UILabel *planTypeLable_Const;
@end


@implementation HXBMY_PlanDtetail_Topcell
- (void)setPlanDetailViewModel:(HXBMYViewModel_PlanDetailViewModel *)planDetailViewModel {
    _planDetailViewModel = planDetailViewModel;
    self.inComeLable.text = self.planDetailViewModel.addAuomt;
    self.planTypeLable.text = self.planDetailViewModel.cashType;
    self.inComeLable_Const.text = self.planDetailViewModel.inComeLable_ConstStr;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
    }
    return self;
}

- (void)setUP {
    self.inComeLable = [[UILabel alloc]init];
    self.inComeLable_Const = [[UILabel alloc]init];
    
    self.planTypeLable = [[UILabel alloc]init];
    self.planTypeLable_Const = [[UILabel alloc]init];
    
    
    [self.contentView addSubview:self.inComeLable];
    [self.contentView addSubview:self.planTypeLable];
    [self.contentView addSubview:self.inComeLable_Const];
    [self.contentView addSubview:self.planTypeLable_Const];
    
    
    __weak typeof (self)weakSelf = self;
    [self.inComeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.centerY.equalTo(weakSelf.contentView).offset(kScrAdaptationH(-10));
    }];
    [self.inComeLable_Const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView).offset(kScrAdaptationH(10));
        make.centerX.equalTo(weakSelf.contentView);
    }];
    [self.planTypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH(20));
        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationH(20));
    }];
    
    self.inComeLable_Const.text = @"已获收益(元)";
}

- (void) temp {
    self.inComeLable_Const.text = @"测试";
    self.inComeLable.text = @"测试";
}
@end

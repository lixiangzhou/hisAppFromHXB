//
//  HXBMY_PlanInvestmentRecordCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanInvestmentRecordCell.h"
#import "HXBMYViewModel_PlanDetailViewModel.h"

@interface HXBMY_PlanInvestmentRecordCell ()
@property (nonatomic,strong) UILabel *planInvestmentRecord_label;
@property (nonatomic,strong) UILabel *planInvestmentRecord_constLabel;
@end
@implementation HXBMY_PlanInvestmentRecordCell
- (void)setPlanInvestmentRecord:(NSString *)planInvestmentRecord {
    _planInvestmentRecord = planInvestmentRecord;
    self.planInvestmentRecord_label.text = planInvestmentRecord;
}

- (void)setPlanInvestmentRecord_const:(NSString *)PlanInvestmentRecord_const {
    _PlanInvestmentRecord_const = PlanInvestmentRecord_const;
    self.planInvestmentRecord_constLabel.text = PlanInvestmentRecord_const;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    [self creatLabel];
}
- (void)creatLabel {
    self.planInvestmentRecord_label = [[UILabel alloc]init];
    self.planInvestmentRecord_constLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:self.planInvestmentRecord_constLabel];
    [self.contentView addSubview:self.planInvestmentRecord_label];
    
    __weak typeof (self)weakSelf = self;
    [self.planInvestmentRecord_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(10));
    }];
    [self.planInvestmentRecord_constLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-10));
    }];

}

- (void) setUPLable {
    self.planInvestmentRecord_constLabel.text = @"测试";
    self.planInvestmentRecord_label.text = @"cccccc";
}
@end

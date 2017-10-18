//
//  HXBMY_PlanDetail_TypeCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanDetail_TypeCell.h"
#import "HXBMYViewModel_PlanDetailViewModel.h"
@interface HXBMY_PlanDetail_TypeCell ()

@property (nonatomic,strong) UILabel *inComeType_Lable;
@property (nonatomic,strong) UILabel *inComeType_ConstLable;
@end



@implementation HXBMY_PlanDetail_TypeCell

- (void)setupValueWithModel:(HXBMYViewModel_PlanDetailViewModel *)planDetailViewModel andLeftStr:(NSString *)leftStr andRightStr:(NSString *)right andRightColor:(UIColor *)rightColor {
    self.inComeType_Lable.text = leftStr;
    self.inComeType_ConstLable.text = right;
    self.inComeType_ConstLable.textColor = rightColor;
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
    self.inComeType_Lable = [[UILabel alloc]init];
    self.inComeType_ConstLable = [[UILabel alloc]init];
    
    [self.contentView addSubview:self.inComeType_Lable];
    [self.contentView addSubview:self.inComeType_ConstLable];
    
    __weak typeof (self)weakSelf = self;
    [self.inComeType_Lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(10));
    }];
    [self.inComeType_ConstLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-10));
    }];
//    [self setUPLable];
}
- (void) setUPLable {
    self.inComeType_ConstLable.text = @"测试";
    self.inComeType_Lable.text = @"cccccc";
}

@end

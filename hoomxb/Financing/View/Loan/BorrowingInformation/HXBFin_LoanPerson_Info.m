//
//  HXBFin_LoanPerson_Info.m
//  hoomxb
//
//  Created by HXB on 2017/7/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanPerson_Info.h"
#import "HXBBaseView_Button.h"

@interface HXBFin_LoanPerson_Info ()
@property (nonatomic, strong) UILabel *borrowUserinforTitleLabel;
@property (nonatomic, strong) UILabel *borrowUserTypeLabel;
//认证
@property (nonatomic, strong) HXBBaseView_Button *incomButton;///收入认证
@property (nonatomic, strong) HXBBaseView_Button *identityButton;///身份认证
@property (nonatomic, strong) HXBBaseView_Button *individualTrustworthinessButton;//个人信用报告
@property (nonatomic, strong) HXBBaseView_Button *jobButton;//工作认证

@end

@implementation HXBFin_LoanPerson_Info
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}

- (void)setUP {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.borrowUserinforTitleLabel];
    [self addSubview:self.borrowUserTypeLabel];
    [self addSubview:self.incomButton];
    [self addSubview:self.identityButton];
    [self addSubview: self.individualTrustworthinessButton];
    [self addSubview: self.jobButton];
    
    [self setUPFrame];
    [self setUPType];
}

- (void)setUPType {
    self.incomButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    self.identityButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    self.individualTrustworthinessButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    self.jobButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
}
- (void)setUPFrame {
    //借款人信息
    [self.borrowUserinforTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(kScrAdaptationH(15));
        make.height.equalTo(@(kScrAdaptationH(21)));
    }];
    //借款人审核状态
    [self.borrowUserTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.borrowUserinforTitleLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(self.borrowUserinforTitleLabel);
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
    //收入
    [self.incomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(9));
        make.left.equalTo(self.borrowUserTypeLabel);
        make.height.equalTo(@(kScrAdaptationH(20)));
        make.right.equalTo(self.mas_centerX);
    }];
    //身份
    [self.identityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.incomButton.mas_right);
        make.height.equalTo(@(kScrAdaptationH(20)));
        make.top.bottom.equalTo(self.incomButton);
        make.right.equalTo(self);
    }];
    //个人信用报告
    [self.individualTrustworthinessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomButton.mas_bottom).offset(kScrAdaptationH(5));
        make.left.right.height.equalTo(self.incomButton);
    }];
    //工作
    [self.jobButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.identityButton);
        make.bottom.top.equalTo(self.individualTrustworthinessButton);
    }];
}




- (UILabel *)borrowUserinforTitleLabel
{
    if (!_borrowUserinforTitleLabel) {
        _borrowUserinforTitleLabel = [[UILabel alloc] init];
        _borrowUserinforTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _borrowUserinforTitleLabel.textColor = kHXBColor_Grey_Font0_2;
        _borrowUserinforTitleLabel.text = @"借款人信息";
    }
    return _borrowUserinforTitleLabel;
}
- (UILabel *)borrowUserTypeLabel {
    if (!_borrowUserTypeLabel) {
        _borrowUserTypeLabel = [[UILabel alloc] init];
        _borrowUserTypeLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _borrowUserTypeLabel.textColor = kHXBColor_HeightGrey_Font0_4;
        _borrowUserTypeLabel.text = @"借款人审核状态";
    }
    return _borrowUserTypeLabel;
}
///收入认证
- (HXBBaseView_Button *) incomButton {
    if (!_incomButton) {
        _incomButton = [[HXBBaseView_Button alloc]init];
        [_incomButton setTitle:@"收入认证" forState: UIControlStateNormal];
        _incomButton.imageName = @"audit_status";
        _incomButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_incomButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
        
    }
    return _incomButton;
}

///身份认证
- (HXBBaseView_Button *)identityButton {
    if (!_identityButton) {
        _identityButton = [[HXBBaseView_Button alloc]init];
        [_identityButton setTitle:@"身份认证" forState: UIControlStateNormal];
        _identityButton.imageName = @"audit_status";
        _identityButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_identityButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
        
    }
    return _identityButton;
}

//个人信用报告
- (UIButton *)individualTrustworthinessButton {
    if (!_individualTrustworthinessButton) {
        _individualTrustworthinessButton = [[HXBBaseView_Button alloc]init];
        [_individualTrustworthinessButton setTitle:@"个人信用报告" forState: UIControlStateNormal];
//        [_individualTrustworthinessButton setImage:[UIImage imageNamed:@"duigou"]  forState:UIControlStateNormal];
        _individualTrustworthinessButton.imageName = @"audit_status";
        _individualTrustworthinessButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_individualTrustworthinessButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
    }
    return _individualTrustworthinessButton;
}
//工作认证
- (HXBBaseView_Button *)jobButton{
    if (!_jobButton) {
        _jobButton = [[HXBBaseView_Button alloc]init];
        [_jobButton setTitle:@"工作认证" forState: UIControlStateNormal];
        _jobButton.imageName = @"audit_status";
        _jobButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_jobButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
    }
    return _jobButton;
}

@end

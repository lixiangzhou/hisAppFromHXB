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
    [self.borrowUserinforTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(kScrAdaptationH(15)));
    }];
    [self.borrowUserTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.borrowUserinforTitleLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(self.borrowUserinforTitleLabel);
    }];
    [self.incomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(9));
        make.left.equalTo(self.borrowUserTypeLabel);
        make.width.equalTo(self).multipliedBy(1.0/2);
    }];

    [self.identityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(1.0/2);
        make.top.bottom.equalTo(self.incomButton);
        make.right.equalTo(self);
    }];
    [self.individualTrustworthinessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomButton.mas_bottom).offset(kScrAdaptationH(5));
        make.left.right.height.equalTo(self.incomButton);
    }];
    [self.jobButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.identityButton);
        make.bottom.top.equalTo(self.individualTrustworthinessButton);
    }];
}




- (UILabel *)borrowUserinforTitleLabel
{
    if (!_borrowUserinforTitleLabel) {
        _borrowUserinforTitleLabel = [[UILabel alloc] init];
        _borrowUserinforTitleLabel.font = [UIFont systemFontOfSize:15];
        _borrowUserinforTitleLabel.textColor = COR11;
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
        _incomButton.imageName = @"duigou";
        _incomButton.isReduce = true;
        _incomButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _incomButton.imageRect = CGRectMake(0, kScrAdaptationH(5), kScrAdaptationH(10), kScrAdaptationH(10));
        [_incomButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
        
    }
    return _incomButton;
}

///身份认证
- (HXBBaseView_Button *)identityButton {
    if (!_identityButton) {
        _identityButton = [[HXBBaseView_Button alloc]init];
        [_identityButton setTitle:@"身份认证" forState: UIControlStateNormal];
        _identityButton.isReduce = true;
        _identityButton.imageView.image = [UIImage imageNamed:@"duigou"];
        _identityButton.imageView.layer.borderColor = kHXBColor_Blue040610.CGColor;
        _identityButton.imageView.layer.borderWidth = kScrAdaptationH(1);
        _identityButton.imageView.layer.masksToBounds = true;
        _identityButton.imageView.layer.cornerRadius = kScrAdaptationH(10);
        _identityButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_identityButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
        
    }
    return _incomButton;
}

//个人信用报告
- (UIButton *)individualTrustworthinessButton {
    if (!_individualTrustworthinessButton) {
        _individualTrustworthinessButton = [[HXBBaseView_Button alloc]init];
        _individualTrustworthinessButton.isReduce = true;
        [_individualTrustworthinessButton setTitle:@"个人信用报告" forState: UIControlStateNormal];
        _individualTrustworthinessButton.imageView.image = [UIImage imageNamed:@"duigou"];
        _individualTrustworthinessButton.imageView.layer.borderColor = kHXBColor_Blue040610.CGColor;
        _individualTrustworthinessButton.imageView.layer.borderWidth = kScrAdaptationH(1);
        _individualTrustworthinessButton.imageView.layer.masksToBounds = true;
        _individualTrustworthinessButton.imageView.layer.cornerRadius = kScrAdaptationH(10);
        _individualTrustworthinessButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_individualTrustworthinessButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
    }
    return _individualTrustworthinessButton;
}
//工作认证
- (UIButton *)jobButton{
    if (!_jobButton) {
        _jobButton = [[HXBBaseView_Button alloc]init];
        [_jobButton setTitle:@"工作认证" forState: UIControlStateNormal];
        _jobButton.isReduce = true;
        _jobButton.imageView.image = [UIImage imageNamed:@"duigou"];
        _jobButton.imageView.layer.borderColor = kHXBColor_Blue040610.CGColor;
        _jobButton.imageView.layer.borderWidth = kScrAdaptationH(1);
        _jobButton.imageView.layer.masksToBounds = true;
        _jobButton.imageView.layer.cornerRadius = kScrAdaptationH(10);
        _jobButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [_jobButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
    }
    return _jobButton;
}

@end

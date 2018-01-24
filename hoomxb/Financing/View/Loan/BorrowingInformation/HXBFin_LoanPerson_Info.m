//
//  HXBFin_LoanPerson_Info.m
//  hoomxb
//
//  Created by HXB on 2017/7/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanPerson_Info.h"
#import "HXBBaseView_Button.h"

@interface HXBFin_LoanPerson_Info ()
@property (nonatomic, strong) UILabel *borrowUserinforTitleLabel;//借款人信息
@property (nonatomic, strong) UILabel *borrowUserTypeLabel;//借款人审核状态
@property (nonatomic, strong) UIView *redFlagView;//红标志
@property (nonatomic, strong) NSArray *infoArray;/// 借款人审核状态
//@property (nonatomic, strong) NSMutableDictionary *infoImgDict;/// 借款人审核状态对应图片按钮名字字典
//@property (nonatomic, strong) NSMutableDictionary *infoTitleDict;/// 借款人审核状态对应标题按钮名字字典
@property (nonatomic, strong) NSMutableArray *infoBtnMArr;/// 借款人审核状态对应按钮数组
//认证
//@property (nonatomic, strong) HXBBaseView_Button *incomButton;///收入认证
//@property (nonatomic, strong) HXBBaseView_Button *identityButton;///身份认证
//@property (nonatomic, strong) HXBBaseView_Button *individualTrustworthinessButton;//个人信用报告
//@property (nonatomic, strong) HXBBaseView_Button *jobButton;//工作认证
//@property (nonatomic, strong) HXBBaseView_Button *otherButton;//其他认证

@end

@implementation HXBFin_LoanPerson_Info

- (instancetype)initWithFrame:(CGRect)frame withLoanPersonInfoArray:(NSArray *)infoArray{
    self = [super initWithFrame:frame];
    if (self) {
        _infoArray = infoArray;
        [self setUP];
    }
    return self;
}

- (HXBBaseView_Button *) getInfoButton {
    HXBBaseView_Button * infoButton = [[HXBBaseView_Button alloc]init];
    infoButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    [infoButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
    infoButton.userInteractionEnabled = NO;
    return infoButton;
}

///标准化数组
- (void)standardizationButtons{
//    self.infoImgDict = [NSMutableDictionary dictionaryWithCapacity:0];
//    self.infoTitleDict = [NSMutableDictionary dictionaryWithCapacity:0];
    self.infoBtnMArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString *key in _infoArray) {
        if ([key isEqualToString:@"IDENTIFICATION_SCANNING"]) { //身份证认证
//            [self.infoImgDict setValue:@"identity" forKey:key];
//            [self.infoTitleDict setValue:@"身份认证" forKey:key];
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"身份认证" forState: UIControlStateNormal];
            infoButton.imageName = @"identity";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        } else if ([key isEqualToString:@"WORK"]){ // 工作认证
//            [self.infoImgDict setValue:@"work" forKey:key];
//            [self.infoTitleDict setValue:@"工作认证" forKey:key];
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"工作认证" forState: UIControlStateNormal];
            infoButton.imageName = @"work";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        } else if ([key isEqualToString:@"INCOME_DUTY"]){ //收入认证
//            [self.infoImgDict setValue:@"money" forKey:key];
//            [self.infoTitleDict setValue:@"收入认证" forKey:key];
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"收入认证" forState: UIControlStateNormal];
            infoButton.imageName = @"money";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        } else if ([key isEqualToString:@"CREDIT"]){ //个人信用报告
            //            [self.infoImgDict setValue:@"credit" forKey:key];
            //            [self.infoTitleDict setValue:@"个人信用报告" forKey:key];
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"个人信用报告" forState: UIControlStateNormal];
            infoButton.imageName = @"credit";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        } else { //其他认证
//            [self.infoImgDict setValue:@"other" forKey:key];
//            [self.infoTitleDict setValue:@"其他" forKey:key];
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"其他" forState: UIControlStateNormal];
            infoButton.imageName = @"other";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        }
    }
}

- (void)setUP {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.borrowUserinforTitleLabel];
    [self addSubview:self.redFlagView];
    [self addSubview:self.borrowUserTypeLabel];
    [self standardizationButtons];
//    [self addSubview:self.incomButton];
//    [self addSubview:self.identityButton];
//    [self addSubview: self.individualTrustworthinessButton];
//    [self addSubview: self.jobButton];
//    [self addSubview:self.otherButton];
    
    [self setUPFrame];
//    [self setUPType];
}

//- (void)setUPType {
//    self.incomButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//    self.identityButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//    self.individualTrustworthinessButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//    self.jobButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//    self.otherButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//}
- (void)setUPFrame {
    //借款人信息
    [self.borrowUserinforTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(kScrAdaptationH(15));
        make.height.equalTo(@(kScrAdaptationH(21)));
    }];
    //红标记
    [self.redFlagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.borrowUserTypeLabel);
        make.height.mas_equalTo(kScrAdaptationW(12));
        make.width.mas_equalTo(kScrAdaptationW(2));
        make.left.equalTo(self.borrowUserTypeLabel).offset(-7);//kScrAdaptationW(-7)
    }];
    //借款人审核状态
    [self.borrowUserTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.borrowUserinforTitleLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(self.borrowUserinforTitleLabel);
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
    
    float space = kScrAdaptationW((375-2*kScrAdaptationW(27)-3*kScrAdaptationW(72))/2);//比例间距
    if (self.infoBtnMArr.count<=0) {
        return;
    } else {
        switch (self.infoBtnMArr.count) {
            case 1:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(self).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(72));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
            }
                break;
            case 2:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(self).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(72));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
                [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(self.infoBtnMArr[0]);
                    make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(72)+1*space));
                }];
            }
                break;
            case 3:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(self).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(72));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
                [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(self.infoBtnMArr[0]);
                    make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(72)+1*space));
                }];
                [self.infoBtnMArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(self.infoBtnMArr[1]);
                    make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+2*kScrAdaptationW(72)+2*space));
                }];
            }
                break;
            case 4:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(self).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(72));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
                [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(self.infoBtnMArr[0]);
                    make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(72)+1*space));
                }];
                [self.infoBtnMArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(self.infoBtnMArr[1]);
                    make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+2*kScrAdaptationW(72)+2*space));
                }];
                [self.infoBtnMArr[3] mas_makeConstraints:^(MASConstraintMaker *make) {
                    HXBBaseView_Button *btn = self.infoBtnMArr[1];
                    make.top.equalTo(btn.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.right.height.width.equalTo(self.infoBtnMArr[0]);
                }];
            }
                break;
            case 5:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(self).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(72));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
                [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(self.infoBtnMArr[0]);
                    make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(72)+1*space));
                }];
                [self.infoBtnMArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(self.infoBtnMArr[1]);
                    make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+2*kScrAdaptationW(72)+2*space));
                }];
                [self.infoBtnMArr[3] mas_makeConstraints:^(MASConstraintMaker *make) {
                    HXBBaseView_Button *btn = self.infoBtnMArr[1];
                    make.top.equalTo(btn.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.right.height.width.equalTo(self.infoBtnMArr[0]);
                }];
                [self.infoBtnMArr[4] mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.height.width.equalTo(self.infoBtnMArr[3]);
                    make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(72)+1*space));
                }];
            }
                break;
            default:
                break;
        }
    }
    
    
    
//    else if (self.infoBtnMArr.count<=3){
//        //收入
//        [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
//            make.left.equalTo(self).offset(kScrAdaptationW(27));
//            make.width.mas_equalTo(kScrAdaptationW(72));
//            make.height.equalTo(@(kScrAdaptationH(47)));
//        }];
//
//        //身份
//        [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.bottom.height.width.equalTo(self.infoBtnMArr[0]);
//            make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(72)+1*space));
//        }];
//
//        //工作
//        [self.infoBtnMArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.bottom.height.width.equalTo(self.infoBtnMArr[1]);
//            make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+2*kScrAdaptationW(72)+2*space));
//        }];
//    } else {
//        //收入
//        [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.equalTo(self.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
//            make.left.equalTo(self).offset(kScrAdaptationW(27));
//            make.width.mas_equalTo(kScrAdaptationW(72));
//            make.height.equalTo(@(kScrAdaptationH(47)));
//        }];
//
//        //身份
//        [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.bottom.height.width.equalTo(self.infoBtnMArr[0]);
//            make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(72)+1*space));
//        }];
//
//
//        //工作
//        [self.infoBtnMArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.bottom.height.width.equalTo(self.infoBtnMArr[1]);
//            make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+2*kScrAdaptationW(72)+2*space));
//        }];
//
//        //个人信用报告
//        [self.infoBtnMArr[3] mas_makeConstraints:^(MASConstraintMaker *make) {
//            HXBBaseView_Button *btn = self.infoBtnMArr[1];
//            make.top.equalTo(btn.mas_bottom).offset(kScrAdaptationH(20));
//            make.left.right.height.width.equalTo(self.incomButton);
//        }];
//        //其他
//        [self.infoBtnMArr[4] mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.height.width.equalTo(self.infoBtnMArr[3]);
//            make.left.mas_equalTo(self).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(72)+1*space));
//        }];
//    }
    
    
    /*
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
     */
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
- (UIView *)redFlagView{
    if (!_redFlagView) {
        _redFlagView = [[UIView alloc]init];
        _redFlagView.backgroundColor = RGB(245, 81, 81);
    }
    return _redFlagView;
}
/////收入认证
//- (HXBBaseView_Button *) incomButton {
//    if (!_incomButton) {
//        _incomButton = [[HXBBaseView_Button alloc]init];
//        [_incomButton setTitle:@"收入认证" forState: UIControlStateNormal];
//        _incomButton.imageName = @"money";
//        _incomButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//        [_incomButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
//        _incomButton.userInteractionEnabled = NO;
//    }
//    return _incomButton;
//}
//
/////身份认证
//- (HXBBaseView_Button *)identityButton {
//    if (!_identityButton) {
//        _identityButton = [[HXBBaseView_Button alloc]init];
//        [_identityButton setTitle:@"身份认证" forState: UIControlStateNormal];
//        _identityButton.imageName = @"identity";
//        _identityButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//        [_identityButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
//        _identityButton.userInteractionEnabled = NO;
//    }
//    return _identityButton;
//}
//
////个人信用报告
//- (UIButton *)individualTrustworthinessButton {
//    if (!_individualTrustworthinessButton) {
//        _individualTrustworthinessButton = [[HXBBaseView_Button alloc]init];
//        [_individualTrustworthinessButton setTitle:@"个人信用报告" forState: UIControlStateNormal];
////        [_individualTrustworthinessButton setImage:[UIImage imageNamed:@"duigou"]  forState:UIControlStateNormal];
//        _individualTrustworthinessButton.imageName = @"credit";
//        _individualTrustworthinessButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//        [_individualTrustworthinessButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
//        _individualTrustworthinessButton.userInteractionEnabled = NO;
//    }
//    return _individualTrustworthinessButton;
//}
////工作认证
//- (HXBBaseView_Button *)jobButton{
//    if (!_jobButton) {
//        _jobButton = [[HXBBaseView_Button alloc]init];
//        [_jobButton setTitle:@"工作认证" forState: UIControlStateNormal];
//        _jobButton.imageName = @"work";
//        _jobButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//        [_jobButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
//        _jobButton.userInteractionEnabled = NO;
//    }
//    return _jobButton;
//}
////其他认证
//- (HXBBaseView_Button *)otherButton{
//    if (!_otherButton) {
//        _otherButton = [[HXBBaseView_Button alloc]init];
//        [_otherButton setTitle:@"其他" forState: UIControlStateNormal];
//        _otherButton.imageName = @"other";
//        _otherButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
//        [_otherButton setTitleColor:kHXBColor_HeightGrey_Font0_4 forState:UIControlStateNormal];
//        _otherButton.userInteractionEnabled = NO;
//    }
//    return _otherButton;
//}

@end

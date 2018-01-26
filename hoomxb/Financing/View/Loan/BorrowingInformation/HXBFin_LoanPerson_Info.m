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
@property (nonatomic, strong) NSMutableArray *infoBtnMArr;/// 借款人审核状态对应按钮数组

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
    self.infoBtnMArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString *key in _infoArray) {
        if ([key isEqualToString:@"IDENTIFICATION_SCANNING"]) {
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"身份认证" forState: UIControlStateNormal];
            infoButton.imageName = @"identity";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        } else if ([key isEqualToString:@"WORK"]){
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"工作认证" forState: UIControlStateNormal];
            infoButton.imageName = @"work";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        } else if ([key isEqualToString:@"INCOME_DUTY"]){
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"收入认证" forState: UIControlStateNormal];
            infoButton.imageName = @"money";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        } else if ([key isEqualToString:@"CREDIT"]){
            HXBBaseView_Button * infoButton = [self getInfoButton];
            [infoButton setTitle:@"个人信用报告" forState: UIControlStateNormal];
            infoButton.imageName = @"credit";
            [self.infoBtnMArr addObject:infoButton];
            [self addSubview:infoButton];
        } else { //其他认证
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

    [self setUPFrame];
}

- (void)setUPFrame {
    kWeakSelf
    //借款人信息
    [self.borrowUserinforTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf).offset(kScrAdaptationH(15));
        make.height.equalTo(@(kScrAdaptationH(21)));
    }];
    //红标记
    [self.redFlagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.borrowUserTypeLabel);
        make.height.mas_equalTo(kScrAdaptationW(12));
        make.width.mas_equalTo(kScrAdaptationW(2));
        make.left.equalTo(weakSelf).offset(7);
    }];
    //借款人审核状态
    [self.borrowUserTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.borrowUserinforTitleLabel.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(weakSelf.borrowUserinforTitleLabel);
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
    
    float space = kScrAdaptationW((375-2*kScrAdaptationW(27)-3*kScrAdaptationW(80))/2);//比例间距
    if (self.infoBtnMArr.count<=0) {
        return;
    } else {
        switch (self.infoBtnMArr.count) {
            case 1:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(weakSelf.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(weakSelf).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(80));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
            }
                break;
            case 2:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(weakSelf.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(weakSelf).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(80));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
                [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(weakSelf.infoBtnMArr[0]);
                    make.left.mas_equalTo(weakSelf).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(80)+1*space));
                }];
            }
                break;
            case 3:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(weakSelf.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(weakSelf).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(80));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
                [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(weakSelf.infoBtnMArr[0]);
                    make.left.mas_equalTo(weakSelf).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(80)+1*space));
                }];
                [self.infoBtnMArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(weakSelf.infoBtnMArr[1]);
                    make.left.mas_equalTo(weakSelf).offset(kScrAdaptationW(kScrAdaptationW(27)+2*kScrAdaptationW(80)+2*space));
                }];
            }
                break;
            case 4:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(weakSelf.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(weakSelf).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(80));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
                [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(weakSelf.infoBtnMArr[0]);
                    make.left.mas_equalTo(weakSelf).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(80)+1*space));
                }];
                [self.infoBtnMArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(weakSelf.infoBtnMArr[1]);
                    make.left.mas_equalTo(weakSelf).offset(kScrAdaptationW(kScrAdaptationW(27)+2*kScrAdaptationW(80)+2*space));
                }];
                [self.infoBtnMArr[3] mas_makeConstraints:^(MASConstraintMaker *make) {
                    HXBBaseView_Button *btn = weakSelf.infoBtnMArr[1];
                    make.top.equalTo(btn.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.right.height.width.equalTo(weakSelf.infoBtnMArr[0]);
                }];
            }
                break;
            case 5:
            {
                [self.infoBtnMArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(weakSelf.borrowUserTypeLabel.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.equalTo(weakSelf).offset(kScrAdaptationW(27));
                    make.width.mas_equalTo(kScrAdaptationW(80));
                    make.height.equalTo(@(kScrAdaptationH(47)));
                }];
                [self.infoBtnMArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(weakSelf.infoBtnMArr[0]);
                    make.left.mas_equalTo(weakSelf).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(80)+1*space));
                }];
                [self.infoBtnMArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.bottom.height.width.equalTo(weakSelf.infoBtnMArr[1]);
                    make.left.mas_equalTo(weakSelf).offset(kScrAdaptationW(kScrAdaptationW(27)+2*kScrAdaptationW(80)+2*space));
                }];
                [self.infoBtnMArr[3] mas_makeConstraints:^(MASConstraintMaker *make) {
                    HXBBaseView_Button *btn = weakSelf.infoBtnMArr[1];
                    make.top.equalTo(btn.mas_bottom).offset(kScrAdaptationH(20));
                    make.left.right.height.width.equalTo(weakSelf.infoBtnMArr[0]);
                }];
                [self.infoBtnMArr[4] mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.height.width.equalTo(weakSelf.infoBtnMArr[3]);
                    make.left.mas_equalTo(weakSelf).offset(kScrAdaptationW(kScrAdaptationW(27)+kScrAdaptationW(80)+1*space));
                }];
            }
                break;
            default:
                break;
        }
    }
    
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

@end

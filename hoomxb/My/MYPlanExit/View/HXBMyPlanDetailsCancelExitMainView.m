//
//  HXBMyPlanDetailsCancelExitMainView.m
//  hoomxb
//
//  Created by hxb on 2018/3/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanDetailsCancelExitMainView.h"

@interface HXBMyPlanDetailsCancelExitMainView()
@property (nonatomic,strong) UIView *cancelExitInfoV;
@property (nonatomic,strong) UILabel *exitAmountLeftLab; ///退出金额
@property (nonatomic,strong) UILabel *exitAmountRightLab; ///
@property (nonatomic,strong) UIImageView *ticketImgV;
@property (nonatomic,strong) UILabel *ticketLab;
@property (nonatomic,strong) UIView *lineV;
@property (nonatomic,strong) UILabel *exitDateLeftLab; ///推出时间
@property (nonatomic,strong) UILabel *exitDateRightLab; ///
@property (nonatomic,strong) UIImageView *iconImgV;
@property (nonatomic,strong) UILabel *descLab;
@property (nonatomic,strong) UIButton *cancelBtn;     /// 确认取消
@property (nonatomic,strong) UIButton *notCancelBtn;   /// 暂不取消
@end

@implementation HXBMyPlanDetailsCancelExitMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPViews];
    }
    return self;
}

- (void)setUPViews {
    self.backgroundColor = kHXBColor_BackGround;
    [self setUPViewsCreate];
    [self setUPSubViewsFrame];
}

- (void)setUPViewsCreate {
    [self addSubview:self.cancelExitInfoV];
    [self.cancelExitInfoV addSubview:self.exitAmountLeftLab];
    [self.cancelExitInfoV addSubview:self.exitAmountRightLab];
    [self.cancelExitInfoV addSubview:self.ticketImgV];
    [self.cancelExitInfoV addSubview:self.ticketLab];
    [self.cancelExitInfoV addSubview:self.lineV];
    [self.cancelExitInfoV addSubview:self.exitDateLeftLab];
    [self.cancelExitInfoV addSubview:self.exitDateRightLab];
    [self addSubview:self.iconImgV];
    [self addSubview:self.descLab];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.notCancelBtn];
}

- (void)setUPSubViewsFrame {
    kWeakSelf
    [self.cancelExitInfoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(kScrAdaptationH(10));
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kScrAdaptationH750(236)));
    }];
    [self.exitAmountLeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.cancelExitInfoV).offset(kScrAdaptationH750(30));
        make.width.equalTo(@(kScrAdaptationH750(120)));
        make.height.equalTo(@(kScrAdaptationH750(36)));
    }];
    [self.exitAmountRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakSelf.exitAmountLeftLab);
        make.right.equalTo(weakSelf.cancelExitInfoV).offset(kScrAdaptationW750(-30));
        make.width.equalTo(@(kScrAdaptationH750(560)));
    }];
    [self.ticketImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.exitAmountRightLab.mas_bottom).offset(kScrAdaptationH750(16));
        make.left.equalTo(@kScrAdaptationW750(314));
        make.width.height.equalTo(@(kScrAdaptationH750(24)));
    }];
    [self.ticketLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.exitAmountRightLab.mas_bottom).offset(kScrAdaptationH750(12));
        make.left.equalTo(weakSelf.ticketImgV.mas_right).offset(kScrAdaptationW750(9));
        make.right.equalTo(weakSelf.cancelExitInfoV).offset(kScrAdaptationW750(-30));
        make.height.equalTo(@(kScrAdaptationH750(32)));
    }];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cancelExitInfoV).offset(kScrAdaptationH750(139));
        make.left.right.equalTo(weakSelf.cancelExitInfoV);
        make.height.equalTo(@(kScrAdaptationH750(1)));
    }];
    [self.exitDateLeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cancelExitInfoV).offset(kScrAdaptationH750(170));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW750(30));
        make.width.equalTo(@(kScrAdaptationH750(120)));
        make.height.equalTo(@(kScrAdaptationH750(36)));
    }];
    [self.exitDateRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(weakSelf.exitAmountLeftLab);
        make.right.equalTo(weakSelf.cancelExitInfoV).offset(kScrAdaptationW750(-30));
        make.width.equalTo(@(kScrAdaptationH750(560)));
    }];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cancelExitInfoV.mas_bottom).offset(kScrAdaptationH750(34));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW750(28));
        make.width.height.equalTo(@(kScrAdaptationH750(28)));
    }];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cancelExitInfoV.mas_bottom).offset(kScrAdaptationH750(30));
        make.left.equalTo(weakSelf.iconImgV.mas_right).offset(kScrAdaptationW750(10));
        make.right.equalTo(weakSelf.mas_right).offset(kScrAdaptationW750(-28));
        make.height.equalTo(@(kScrAdaptationH750(144)));
    }];
    [self.notCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.descLab.mas_bottom).offset(kScrAdaptationH750(100));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW750(30));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW750(-30));
        make.height.equalTo(@(kScrAdaptationH750(82)));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cancelBtn.mas_bottom).offset(kScrAdaptationH750(40));
        make.left.right.height.equalTo(weakSelf.cancelBtn);
    }];

    self.exitAmountLeftLab.hidden = YES;
    self.exitAmountRightLab.hidden = YES;
    self.ticketImgV.hidden = YES;
    self.ticketLab.hidden = YES;
    self.exitDateLeftLab.hidden = YES;
    self.exitDateRightLab.hidden = YES;
    self.iconImgV.hidden = YES;
    self.descLab.hidden = YES;
    self.cancelBtn.hidden = YES;
    self.notCancelBtn.hidden = YES;
}

- (void)cancelBtnClick {
    if (self.cancelExitBtnClickBlock) {
        self.cancelExitBtnClickBlock();
    }
}

- (void)notCancelBtnClick {
    if (self.notCancelBtnClickBlock) {
        self.notCancelBtnClickBlock();
    }
}

-(UIView *)cancelExitInfoV{
    if (!_cancelExitInfoV) {
        _cancelExitInfoV = [[UIView alloc]initWithFrame:CGRectZero];
        _cancelExitInfoV.backgroundColor = [UIColor whiteColor];
    }
    return _cancelExitInfoV;
}
- (UILabel *)exitAmountLeftLab{
    if (!_exitAmountLeftLab) {
        _exitAmountLeftLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _exitAmountLeftLab.text = @"退出金额";
        _exitAmountLeftLab.textColor = kHXBColor_333333_100;
        _exitAmountLeftLab.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _exitAmountLeftLab;
}
- (UILabel *)exitAmountRightLab{
    if (!_exitAmountRightLab) {
        _exitAmountRightLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _exitAmountRightLab.textColor = kHXBColor_999999_100;
        _exitAmountRightLab.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _exitAmountRightLab;
}
-(UIImageView *)ticketImgV {
    if (!_ticketImgV) {
        _ticketImgV = [[UIImageView alloc]init];
        _ticketImgV.image = [UIImage imageNamed:@"myPlanDetailsTicketExitIcon"];
    }
    return _ticketImgV;
}
-(UILabel *)ticketLab{
    if (!_ticketLab) {
        _ticketLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _ticketLab.textColor = kHXBColor_999999_100;
        _ticketLab.font = kHXBFont_PINGFANGSC_REGULAR_750(22);
    }
    return _ticketLab;
}
-(UIView *)lineV{
    if (!_lineV) {
        _lineV = [[UIView alloc]initWithFrame:CGRectZero];
        _lineV.backgroundColor = COR12;
    }
    return _lineV;
}
-(UILabel *)exitDateLeftLab{
    if (!_exitDateLeftLab) {
        _exitDateLeftLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _exitDateLeftLab.text = @"退出时间";
        _exitDateLeftLab.textColor = kHXBColor_333333_100;
        _exitDateLeftLab.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _exitDateLeftLab;
}
- (UILabel *)exitDateRightLab{
    if (!_exitDateRightLab) {
        _exitDateRightLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _exitDateRightLab.textColor = kHXBColor_999999_100;
        _exitDateRightLab.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _exitDateRightLab;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_cancelBtn setTitle:@"确认取消" forState:UIControlStateNormal];
        [_cancelBtn.layer setBorderColor:kHXBFountColor_F55151_100.CGColor];
        [_cancelBtn.layer setBorderWidth:1.0f];
        [_cancelBtn setTitleColor:kHXBFountColor_F55151_100 forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:kHXBColor_BackGround];
        _cancelBtn.userInteractionEnabled = YES;
        _cancelBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _cancelBtn.layer.cornerRadius = 5.0f;
        _cancelBtn.layer.masksToBounds = YES;
        
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIButton *)notCancelBtn {
    if (!_notCancelBtn) {
        _notCancelBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_notCancelBtn setTitle:@"暂不取消" forState:UIControlStateNormal];
        [_notCancelBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [_notCancelBtn setBackgroundColor:kHXBFountColor_F55151_100];
        _notCancelBtn.userInteractionEnabled = YES;
        _notCancelBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _notCancelBtn.layer.cornerRadius = 5.0f;
        _notCancelBtn.layer.masksToBounds = YES;
        [_notCancelBtn addTarget:self action:@selector(notCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notCancelBtn;
}
- (UIImageView *)iconImgV {
    if (!_iconImgV) {
        _iconImgV = [[UIImageView alloc]init];
        _iconImgV.image = [UIImage imageNamed:@"myPlanDetailsExitIcon"];
    }
    return _iconImgV;
}
- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [[UILabel alloc]init];
        _descLab.numberOfLines = 0;
        _descLab.textColor = kHXBColor_999999_100;
        _descLab.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
        _descLab.text = @"";
    }
    return _descLab;
}

@end

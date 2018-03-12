//
//  HXBMyPlanDetailsExitMainView.m
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanDetailsExitMainView.h"

@interface HXBMyPlanDetailsExitMainView()
@property (nonatomic,strong) UILabel *descLab; ///描述
@property (nonatomic,strong) UILabel *principalTitleLab;
@property (nonatomic,strong) UILabel *principalLab; /// 本金
@property (nonatomic,strong) UILabel *profitTitleLab;
@property (nonatomic,strong) UILabel *profitLab;    /// 当前已赚
@property (nonatomic,strong) UILabel *earningsTitleLab;
@property (nonatomic,strong) UILabel *earningsLab;  /// 预期收益
@property (nonatomic,strong) UIButton *exitBtn;     /// 确认退出
@property (nonatomic,strong) UIButton *cancelBtn;   /// 暂不退出
@end

@implementation HXBMyPlanDetailsExitMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPViews];
    }
    return self;
}

- (void)setUPViews {
    [self setUPViewsCreate];
    [self setUPViewsFrame];
}

- (void)setUPViewsCreate {
    [self addSubview:self.descLab];
    [self addSubview:self.principalTitleLab];
    [self addSubview:self.principalLab];
    [self addSubview:self.profitTitleLab];
    [self addSubview:self.profitLab];
    [self addSubview:self.earningsTitleLab];
    [self addSubview:self.earningsLab];
    [self addSubview:self.exitBtn];
    [self addSubview:self.cancelBtn];
}

- (void)setUPViewsFrame {
    kWeakSelf
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.principalTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.principalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.profitTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.profitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.earningsTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.earningsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)setMyPlanDetailsExitModel:(HXBMyPlanDetailsExitModel *)myPlanDetailsExitModel {
//    self.descLab.text = myPlanDetailsExitModel.;
//    self.principalLab.text = myPlanDetailsExitModel.;
//    self.profitLab.text = myPlanDetailsExitModel.;
//    self.earningsLab.text = myPlanDetailsExitModel.;
    
}

- (void)exitBtnClick {
    if (self.exitBtnClickBlock) {
        self.exitBtnClickBlock();
    }
}

- (void)cancelBtnClick {
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
    }
}

- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [[UILabel alloc]init];
    }
    return _descLab;
}
- (UILabel *)principalTitleLab {
    if (!_principalTitleLab) {
        _principalTitleLab = [[UILabel alloc]init];
        _principalTitleLab.text = @"加入本金";
    }
    return _principalTitleLab;
}
- (UILabel *)principalLab {
    if (!_principalLab) {
        _principalLab = [[UILabel alloc]init];
    }
    return _principalLab;
}
- (UILabel *)profitTitleLab {
    if (!_profitTitleLab) {
        _profitTitleLab = [[UILabel alloc]init];
        _profitTitleLab.text = @"当前已赚";
    }
    return _profitTitleLab;
}
- (UILabel *)profitLab {
    if (!_profitLab) {
        _profitLab = [[UILabel alloc]init];
    }
    return _profitLab;
}
- (UILabel *)earningsTitleLab {
    if (!_earningsTitleLab) {
        _earningsTitleLab = [[UILabel alloc]init];
        _earningsTitleLab.text = @"或预期收益";
    }
    return _earningsTitleLab;
}
- (UILabel *)earningsLab {
    if (!_earningsLab) {
        _earningsLab = [[UILabel alloc]init];
    }
    return _earningsLab;
}
- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc]init];
        [_exitBtn setTitle:@"确认退出" forState:UIControlStateNormal];
        [_exitBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [_exitBtn setBackgroundColor:RGB(232, 232, 238)];
        _exitBtn.userInteractionEnabled = YES;
        _exitBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        [_exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]init];
        _cancelBtn = [[UIButton alloc]init];
        [_cancelBtn setTitle:@"暂不退出" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:RGB(232, 232, 238)];
        _cancelBtn.userInteractionEnabled = YES;
        _cancelBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
@end

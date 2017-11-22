//
//  HXBHeadView.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2017/11/8.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHeadView.h"

@interface HXBHeadView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *topItemLabel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *leftItemLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *rightItemLabel;

@end

@implementation HXBHeadView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        [self addObservers];
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark - Observers

- (void)addObservers {
    
}

#pragma mark - UI

- (void)setUI {
    [self addSubview:self.backImageView];
    [self addSubview:self.topLabel];
    [self addSubview:self.topItemLabel];
    [self addSubview:self.leftLabel];
    [self addSubview:self.leftItemLabel];
    [self addSubview:self.rightLabel];
    [self addSubview:self.rightItemLabel];
    [self setupFrame];
}

- (void)setupFrame {
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        if (LL_iPhoneX) {
            make.height.offset(kScrAdaptationH(248) - HxbNavigationBarY);
        } else {
            make.height.offset(kScrAdaptationH(248) - HxbNavigationBarMaxY);
        }
    }];
    
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(15));
        make.centerX.equalTo(self.mas_centerX);
        make.height.offset(kScrAdaptationH(40));
    }];
    
    [_topItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLabel.mas_bottom).offset(kScrAdaptationH(5));
        make.centerX.equalTo(self.mas_centerX);
        make.height.offset(kScrAdaptationH(20));
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topItemLabel.mas_bottom).offset(kScrAdaptationH(20));
        make.centerX.equalTo(self.mas_centerX).offset(-kScreenWidth / 4);
        make.height.offset(kScrAdaptationH(33));
    }];
    
    [_leftItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftLabel.mas_bottom).offset(kScrAdaptationH(5));
        make.centerX.equalTo(_leftLabel);
        make.height.offset(kScrAdaptationH(20));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftLabel.mas_top);
        make.centerX.equalTo(self.mas_centerX).offset(kScreenWidth / 4);
        make.height.offset(kScrAdaptationH(33));
    }];
    
    [_rightItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftItemLabel);
        make.centerX.equalTo(_rightLabel);
        make.height.offset(kScrAdaptationH(20));
    }];
}

#pragma mark - Action
- (void)setDataDic:(NSDictionary *)dataDic {
    if (dataDic) {
        _backImageView.image = [UIImage imageNamed:@"top"];
        _topLabel.text = dataDic[@"topLabel"];
        _topItemLabel.text = dataDic[@"topItemLabel"];
        _leftLabel.text = dataDic[@"leftLabel"];
        _leftItemLabel.text = dataDic[@"leftItemLabel"];
        _rightLabel.text = dataDic[@"rightLabel"];
        _rightItemLabel.text = dataDic[@"rightItemLabel"];
    }
}

#pragma mark - Setter / Getter / Lazy
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
    }
    return _backImageView;
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = kHXBFont_PINGFANGSC_REGULAR(36);
    }
    return _topLabel;
}

- (UILabel *)topItemLabel {
    if (!_topItemLabel) {
        _topItemLabel = [[UILabel alloc] init];
        _topItemLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        _topItemLabel.textAlignment = NSTextAlignmentCenter;
        _topItemLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _topItemLabel;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = [UIColor whiteColor];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
    }
    return _leftLabel;
}

- (UILabel *)leftItemLabel {
    if (!_leftItemLabel) {
        _leftItemLabel = [[UILabel alloc] init];
        _leftItemLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        _leftItemLabel.textAlignment = NSTextAlignmentCenter;
        _leftItemLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _leftItemLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor whiteColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = kHXBFont_PINGFANGSC_REGULAR(24);
    }
    return _rightLabel;
}

- (UILabel *)rightItemLabel {
    if (!_rightItemLabel) {
        _rightItemLabel = [[UILabel alloc] init];
        _rightItemLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        _rightItemLabel.textAlignment = NSTextAlignmentCenter;
        _rightItemLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    }
    return _rightItemLabel;
}

#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end

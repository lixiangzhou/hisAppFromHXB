//
//  HXBFinPlanDetailExitView.m
//  测试
//
//  Created by HXB-C on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinPlanDetailExitView.h"
#import "Masonry.h"
@interface HXBFinPlanDetailExitView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;


@end

@implementation HXBFinPlanDetailExitView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    kWeakSelf
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(15));
        make.top.equalTo(weakSelf).offset(kScrAdaptationH(15));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel.mas_left);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(kScrAdaptationW(15));
        make.right.equalTo(weakSelf.mas_right).offset(-kScrAdaptationW(15));
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_top);
        make.bottom.equalTo(weakSelf.contentLabel.mas_bottom).offset(kScrAdaptationW(15));
    }];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _titleLabel.textColor = kHXBFountColor_333333_100;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font =  kHXBFont_PINGFANGSC_REGULAR(13);
        _contentLabel.textColor = kHXBFountColor_999999_100;
    }
    return _contentLabel;
}

@end

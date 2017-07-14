//
//  HXBLeftLabelTextView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBLeftLabelTextView.h"

@interface HXBLeftLabelTextView()

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation HXBLeftLabelTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.leftLabel];
        [self addSubview:self.textField];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self.leftLabel.mas_right);
        make.right.equalTo(self).offset(kScrAdaptationW750(-30));
    }];
}

- (void)setLeftStr:(NSString *)leftStr
{
    _leftStr = leftStr;
    _leftLabel.text = leftStr;
}

- (NSString *)text
{
    return self.textField.text;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    
}
#pragma mark - 懒加载
- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _leftLabel.textColor = COR6;
    }
    return _leftLabel;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _textField.textColor = COR6;
    }
    return _textField;
}

@end

//
//  HXBCustomTextField.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCustomTextField.h"

@interface HXBCustomTextField ()
{
    NSString *_text;
}
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *line;



@end


@implementation HXBCustomTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.textField];
        [self addSubview:self.line];
        [self addSubview:self.rightImageView];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(40));
        make.top.equalTo(self).offset(kScrAdaptationH750(43));
        make.width.offset(kScrAdaptationW750(36));
        make.height.offset(kScrAdaptationH750(38));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImageView);
        make.left.equalTo(self.leftImageView.mas_right).offset(kScrAdaptationW750(20));
        make.right.equalTo(self).offset(kScrAdaptationW750(-40));
        make.height.offset(kScrAdaptationH750(30));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.leftImageView.mas_left);
        make.right.equalTo(self).offset(kScrAdaptationW750(-40));
        make.height.offset(1);
    }];
   
}

#pragma mark - set方法
- (void)setIsHidenLine:(BOOL )isHidenLine
{
    _isHidenLine = isHidenLine;
    self.line.hidden = isHidenLine;
}
- (void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    self.leftImageView.image = leftImage;
}
- (void)setRightImage:(UIImage *)rightImage
{
    _rightImage = rightImage;
    self.rightImageView.image = rightImage;
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textField);
        make.right.equalTo(self.textField.mas_right);
        make.height.offset(kScrAdaptationH750(30));
        make.width.offset(kScrAdaptationW750(16));
    }];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:placeholder];
    // 设置字体和设置字体的范围
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:COR10
                    range:NSMakeRange(0, placeholder.length)];
    self.textField.attributedPlaceholder = attrStr;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    _attributedPlaceholder = attributedPlaceholder;
    self.textField.attributedPlaceholder = attributedPlaceholder;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textField.text = text;
}

- (NSString *)text
{
    return self.textField.text;
}

#pragma mark - 懒加载
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    }
    return _textField;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(221, 221, 221);
    }
    return _line;
}
@end
//
//  HXBGetValidationCodeView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBGetValidationCodeView.h"

@interface HXBGetValidationCodeView ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *button;

/**
 记录时间
 */
@property (nonatomic, assign) int timeCount;

@property (nonatomic, weak) NSTimer *timer;
@end

@implementation HXBGetValidationCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textField];
        [self addSubview:self.line];
        [self addSubview:self.button];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_left);
        make.right.equalTo(self.textField.mas_right);
        make.top.equalTo(self.textField.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textField);
        make.right.equalTo(self.textField.mas_right);
        make.height.equalTo(@44);
        make.width.equalTo(@kScrAdaptationH(100));
    }];

}

- (void)buttonClick
{
    self.button.enabled = NO;
    self.timeCount = 60;
    [self.button setTitle:[NSString stringWithFormat:@"%d秒",self.timeCount] forState:UIControlStateNormal];
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
}

- (void)timeDown
{
    self.timeCount--;
    [self.button setTitle:[NSString stringWithFormat:@"%d秒",self.timeCount] forState:UIControlStateNormal];
    if (self.timeCount <= -1) {
        self.button.enabled = YES;
        [self.timer invalidate];
        self.timer = nil;
        [self.button setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 懒加载
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"输入验证码";
    }
    return _textField;
}


- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.borderColor = COR12.CGColor;
        _button.layer.borderWidth = kXYBorderWidth;
    }
    return _button;
}
- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = COR11;
    }
    return _line;
}
@end

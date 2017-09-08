//
//  HXBCustomTextField.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCustomTextField.h"
#import "SVGKImage.h"
@interface HXBCustomTextField ()<UITextFieldDelegate>
{
    NSString *_text;
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) BXTextField *idTextField;
@property (nonatomic, strong) UIButton *bankNameBtn;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIButton *eyeBtn;
@property (nonatomic, strong) UIView *line;

@end


@implementation HXBCustomTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftImageView];
        [self addSubview:self.textField];
        [self addSubview:self.idTextField];
        [self addSubview:self.line];
        [self addSubview:self.rightImageView];
        [self addSubview:self.bankNameBtn];
        [self addSubview:self.eyeBtn];
        self.bankNameBtn.hidden = YES;
        [self setupSubViewFrame];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidChangeValue:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:self.textField];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidChangeValue:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:self.idTextField];
//
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidEndEditing1:)
                                                     name:UITextFieldTextDidEndEditingNotification
                                                   object:self.textField];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidEndEditing1:)
                                                     name:UITextFieldTextDidEndEditingNotification
                                                   object:self.idTextField];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidBeginEditing:)
                                                     name:UITextFieldTextDidBeginEditingNotification
                                                   object:self.textField];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldDidBeginEditing:)
                                                     name:UITextFieldTextDidBeginEditingNotification
                                                   object:self.idTextField];
        
    }
    return self;
}

- (void)setIsIDCardTextField:(BOOL)isIDCardTextField {
    
    _isIDCardTextField = isIDCardTextField;
    if (isIDCardTextField) {
        self.textField.hidden = YES;
        self.idTextField.hidden = NO;
    } else {
        self.textField.hidden = NO;
        self.idTextField.hidden = YES;
    }
}


- (void)setupSubViewFrame
{
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(40));
        make.centerY.equalTo(self);
        make.width.offset(kScrAdaptationW750(36));
        make.height.offset(kScrAdaptationH750(38));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(kScrAdaptationW750(20));
         make.right.equalTo(self).offset(-kScrAdaptationW750(40));
        make.top.bottom.equalTo(self);
    }];
    [self.idTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(kScrAdaptationW750(20));
        make.right.equalTo(self).offset(-kScrAdaptationW750(40));
        make.top.bottom.equalTo(self);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.leftImageView.mas_left);
        make.right.equalTo(self).offset(kScrAdaptationW750(-40));
        make.height.offset(0.5);
    }];
    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.textField);
        make.right.equalTo(self.mas_right).offset(kScrAdaptationW750(-40));
//        make.height.offset(kScrAdaptationH750(23.9));
        make.width.offset(kScrAdaptationW750(40));
        make.top.bottom.equalTo(self);
    }];

   
}
- (void)eyeBtnClick
{
    self.textField.secureTextEntry = self.eyeBtn.selected;
    self.eyeBtn.selected = !self.eyeBtn.selected;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.line.backgroundColor = COR12;
}


//这里可以通过发送object消息获取注册时指定的UITextField对象
- (void)textFieldDidBeginEditing:(NSNotification *)notification {
    self.line.backgroundColor = COR29;
}

- (void)textFieldDidEndEditing1:(NSNotification *)notification {
    self.line.backgroundColor = COR12;
}

- (void)textFieldDidChangeValue:(NSNotification *)notification {
    NSString *text = nil;
    UITextField *sender = (UITextField *)[notification object];
    text = sender.text;
    NSLog(@"%@", text);
    if (_secureTextEntry) {
        if (text.length > 0) {
            NSString *str = [text substringFromIndex:text.length - 1];
            NSUInteger lengthOfString = str.length;  //lengthOfString的值始终为1
            for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                unichar character = [str characterAtIndex:loopIndex]; //将输入的值转化为ASCII值（即内部索引值），可以参考ASCII表
                // 48-57;{0,9};65-90;{A..Z};97-122:{a..z}
                if (character < 48) sender.text = [sender.text substringToIndex:text.length - 1]; // 48 unichar for 0
                if (character > 57 && character < 65) sender.text = [sender.text substringToIndex:text.length - 1]; //
                if (character > 90 && character < 97) sender.text = [sender.text substringToIndex:text.length - 1];
                if (character > 122) sender.text = [sender.text substringToIndex:text.length - 1];
            }
        }
    }
    if (self.block) {
        self.block(sender.text);
    }
}

#pragma mark - set方法

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    _delegate = delegate;
    self.textField.delegate = delegate;
    self.idTextField.delegate = delegate;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = secureTextEntry;
    self.eyeBtn.hidden = !secureTextEntry;
    if (secureTextEntry) {
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImageView.mas_right).offset(kScrAdaptationW750(20));
            make.right.equalTo(self).offset(-kScrAdaptationW(50));
            make.top.bottom.equalTo(self);
        }];
    }
}

- (void)setIsGetCode:(BOOL)isGetCode {
    _isGetCode = isGetCode;
    if (_isGetCode) {
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImageView.mas_right).offset(kScrAdaptationW750(20));
            make.right.equalTo(self).offset(-kScrAdaptationW(110));
            make.top.bottom.equalTo(self);
        }];
    }
}



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
    self.bankNameBtn.hidden = NO;
    [self.bankNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
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
    self.idTextField.attributedPlaceholder = attrStr;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    _attributedPlaceholder = attributedPlaceholder;
    self.textField.attributedPlaceholder = attributedPlaceholder;
    self.idTextField.attributedPlaceholder = attributedPlaceholder;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textField.text = text;
    self.idTextField.text = text;
}

- (NSString *)text
{
    if (self.isIDCardTextField) {
        return self.idTextField.text;
    } else {
        return self.textField.text;
    }
    
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    _textField.keyboardType = keyboardType;
}
#pragma mark - 懒加载
- (UIButton *)eyeBtn
{
    if (!_eyeBtn) {
        _eyeBtn = [[UIButton alloc] init];
        [_eyeBtn setImage:[SVGKImage imageNamed:@"password_eye_close.svg"].UIImage forState:UIControlStateNormal];
        [_eyeBtn setImage:[SVGKImage imageNamed:@"password_eye_open.svg"].UIImage forState:UIControlStateSelected];
        [_eyeBtn addTarget:self action:@selector(eyeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _eyeBtn.hidden = YES;
    }
    return _eyeBtn;
}
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
    }
    return _textField;
}


- (BXTextField *)idTextField {
    if (!_idTextField) {
        _idTextField = [[BXTextField alloc] init];
        _idTextField.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _idTextField.hidden = YES;
        _idTextField.delegate = self;
        _idTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _idTextField;
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
        _line.backgroundColor = COR12;
    }
    return _line;
}
- (UIButton *)bankNameBtn{
    if (!_bankNameBtn) {
        _bankNameBtn = [[UIButton alloc] init];
        [_bankNameBtn setBackgroundColor:[UIColor clearColor]];
        [_bankNameBtn addTarget:self action:@selector(bankNameBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bankNameBtn;
    
}
- (void)bankNameBtnClick
{
    if (self.btnClick) {
        self.btnClick();
    }
}
@end

//
//  HXBBaseTextField.m
//  hoomxb
//
//  Created by HXB on 2017/6/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTextField.h"

@interface HXBBaseTextField ()

@property (nonatomic,assign) CGFloat lienHeight;
@property (nonatomic,assign) CGFloat buttonWidth;
@property (nonatomic,assign) CGFloat space;
@property (nonatomic,assign) BOOL isDrawLine;
@property (nonatomic,copy) void (^clickButton)(UIButton *button,UITextField *textField);
@end

@implementation HXBBaseTextField {
    CGFloat _red;
    CGFloat _green;
    CGFloat _blue;
    CGFloat _alpha;
}
- (void)setIsSecureTextEntry:(BOOL)isSecureTextEntry {
    _isSecureTextEntry = isSecureTextEntry;
    [self show];
}
- (void)clickButtonWithBlock: (void (^)(UIButton *button,UITextField *textField))clickButton {
    self.clickButton = clickButton;
}
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate {
    self.textField.delegate = textFieldDelegate;
}
- (instancetype)initWithFrame:(CGRect)frame andBottomLienSpace: (CGFloat)space
          andBottomLienHeight: (CGFloat)lienHeight
              andRightButtonW: (CGFloat) rightButtonWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lienHeight = lienHeight;
        self.space = space;
        self.buttonWidth = rightButtonWidth;
        self.backgroundColor = [UIColor whiteColor];
        [self creatViews];
    }
    return self;
}

- (void) show {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
     [self setUP];
}
- (void) setUP {
    [self layoutViews];
}

- (void)creatViews {
    [self setValue: [[UITextField alloc]init] forKey:@"textField"];
    [self setValue: [[UIButton alloc]init] forKey:@"button"];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.secureTextEntry = self.isSecureTextEntry;
    [self.textField becomeFirstResponder];
    [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button.layer.borderColor = kHXBColor_Blue040610.CGColor;//(r:0.45 g:0.68 b:0.68 a:1.00)
    self.button.layer.borderWidth = kScrAdaptationW750(2);
}
- (void) clickButton: (UIButton *)button {
    if (_isSecureTextEntry) {
        self.textField.secureTextEntry = !self.textField.secureTextEntry;
    }
    if (self.clickButton) {
        self.clickButton(button,self.textField);
    }
}

- (void)layoutViews {
    [self addSubview: self.textField];
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(self.lienHeight);
        make.width.equalTo(@(self.buttonWidth));
        make.right.equalTo(self);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.offset(self.lienHeight);
        make.left.equalTo(self);
        make.right.equalTo(self.button.mas_left);
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!self.isDrawLine) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, self.space, self.frame.size.height - self.lienHeight/2.0);
    CGPathAddLineToPoint(path, nil, self.frame.size.width - self.space, self.frame.size.height - self.lienHeight/2.0);
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, self.lienHeight);
    CGContextSetRGBStrokeColor(context, _red, _green, _blue, _alpha);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void) lienColorWithRed:(CGFloat)red andGreen: (CGFloat)green andBlue: (CGFloat)blue andAlpha: (CGFloat)alpha {
    self.isDrawLine = alpha;
    if (!alpha) return;
    _red = red;
    _green = green;
    _blue = blue;
    _alpha = alpha;
    [self setNeedsLayout];
}
@end


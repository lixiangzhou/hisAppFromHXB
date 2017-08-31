//
//  HXBCheckCaptcha.m
//  hoomxb
//
//  Created by HXB on 2017/6/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCheckCaptcha.h"

static NSString *const kPromptTetle = @"请输入下面的图形验证码";
static NSString *const kTrueButtonTitle = @"确定";

@interface HXBCheckCaptcha ()<UITextFieldDelegate>
///点击了确认按钮
@property (nonatomic, copy) void(^clickTrueButtonBlock)(NSString *checkCaptChaStr);

///点击了图验imageView
@property (nonatomic, copy) void(^clickCheckCaptchaImageViewBlock)();

@property (nonatomic,strong) UILabel *promptLabel;
@property (nonatomic,strong) UIImageView *checkCaptchaImageView;
@property (nonatomic,strong) UITextField *checkCaptchaTextField;
@property (nonatomic, strong) UIView *line;
@property (nonatomic,strong) UIButton *trueButton;
@property (nonatomic, strong) UIButton *cancelBtn;
@end


@implementation HXBCheckCaptcha
- (void)setIsCorrect:(BOOL)isCorrect {
    _isCorrect = isCorrect;
    if(!isCorrect) {
        self.promptLabel.text = @"验证码输入错误";
        self.checkCaptchaTextField.text = @"";
    }
}
- (void)setCheckCaptchaImage:(UIImage *)checkCaptchaImage {
    _checkCaptchaImage = checkCaptchaImage;
    self.checkCaptchaImageView.image = checkCaptchaImage;
    self.checkCaptchaImageView.contentMode = UIViewContentModeScaleAspectFit;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = kScrAdaptationW(5);
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self setUP];
    }
    return self;
}

- (void)setUP {
    [self creatSubView];
    [self layoutSubViewS_checkCaptcha];
    [self setUPSubVeiwValue];
    [self registerEvent];
}

- (void) creatSubView {
    self.promptLabel = [[UILabel alloc]init];
    self.checkCaptchaImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"captcha"]];
    self.checkCaptchaTextField = [[UITextField alloc]init];
    self.trueButton = [[UIButton alloc]init];
    self.line = [[UIView alloc] init];
    self.cancelBtn = [[UIButton alloc] init];
    
    [self addSubview: self.promptLabel];
    [self addSubview: self.checkCaptchaImageView];
    [self addSubview: self.checkCaptchaTextField];
    [self addSubview: self.trueButton];
    [self addSubview:self.line];
    [self addSubview:self.cancelBtn];
    [self.checkCaptchaTextField becomeFirstResponder];
}

- (void) layoutSubViewS_checkCaptcha {
    kWeakSelf
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.offset(kScrAdaptationH(40));
    }];
    [self.checkCaptchaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.promptLabel.mas_bottom).offset(kScrAdaptationW(25));
        make.right.equalTo(@(kScrAdaptationW(-43)));
        make.height.offset(kScrAdaptationH(33));
        make.width.offset(kScrAdaptationW(90));
    }];
    [self.checkCaptchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.checkCaptchaImageView);
        make.right.equalTo(weakSelf.checkCaptchaImageView.mas_left).offset(kScrAdaptationW(-20));
        make.width.offset(kScrAdaptationW(100));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.checkCaptchaImageView.mas_bottom);
        make.right.equalTo(weakSelf.checkCaptchaTextField.mas_right);
        make.left.equalTo(weakSelf.checkCaptchaTextField.mas_left);
        make.height.offset(0.5);
    }];
    [self.trueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.top.equalTo(weakSelf.checkCaptchaImageView.mas_bottom).offset(kScrAdaptationH(30));
        make.height.offset(kScrAdaptationH(35));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.top.equalTo(weakSelf.checkCaptchaImageView.mas_bottom).offset(kScrAdaptationH(30));
        make.height.offset(kScrAdaptationH(35));
        make.width.offset(kScrAdaptationW(115));
    }];
    
    
//    self.promptLabel.backgroundColor = [UIColor hxb_randomColor];
//    self.checkCaptchaTextField.backgroundColor = [UIColor hxb_randomColor];
//    self.checkCaptchaImageView.backgroundColor = [UIColor grayColor];
//    self.trueButton.backgroundColor = [UIColor hxb_randomColor];
}

- (void)setUPSubVeiwValue {
    self.promptLabel.text = kPromptTetle;
    [self.trueButton setTitle:kTrueButtonTitle forState:UIControlStateNormal];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(clickCheckCaptchaImageView:)];
    self.checkCaptchaImageView.userInteractionEnabled = true;
    [self.checkCaptchaImageView addGestureRecognizer:tap];
    
    self.checkCaptchaTextField.font = kHXBFont_PINGFANGSC_REGULAR(16);
    self.checkCaptchaTextField.textColor = RGB(51, 51, 51);
    self.checkCaptchaTextField.textAlignment = NSTextAlignmentCenter;
    self.checkCaptchaTextField.delegate = self;
    self.checkCaptchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.line.backgroundColor = RGB(222, 222, 222);
    
    self.trueButton.backgroundColor = RGB(245, 81, 81);
    self.trueButton.layer.cornerRadius = kScrAdaptationW(4);
    self.trueButton.layer.masksToBounds = YES;
    self.trueButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = kScrAdaptationW(4);
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.borderColor = RGB(253, 54, 54).CGColor;
    self.cancelBtn.layer.borderWidth = kXYBorderWidth;
    self.cancelBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    self.cancelBtn.hidden = YES;
    [self.cancelBtn setTitleColor:RGB(253, 54, 54) forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (void)cancelBtnClick
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)registerEvent {
    [self.trueButton addTarget:self action:@selector(clickTrueButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickTrueButton: (UIButton *)button {
    ///请求验证码 是否争正确
//    if (self.checkCaptchaTextField.text.length != 4) {
//        self.promptLabel.text = @"请输入正确的验证码";
//        return;
//    }
    if (self.clickTrueButtonBlock) {
        self.clickTrueButtonBlock(self.checkCaptchaTextField.text);
    }
}

- (void)clickTrueButtonFunc:(void (^)(NSString *checkCaptChaStr))clickTrueButtonBlock {
    self.clickTrueButtonBlock = clickTrueButtonBlock;
}

///点击了图形验证码 tap
- (void)clickCheckCaptchaImageView: (UITapGestureRecognizer *)tap {
    if (self.clickCheckCaptchaImageViewBlock) self.clickCheckCaptchaImageViewBlock();
}

///点击了图形验证码
- (void)clickCheckCaptchaImageViewFunc: (void(^)())clickCheckCaptchaImageViewBlock {
    self.clickCheckCaptchaImageViewBlock = clickCheckCaptchaImageViewBlock;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 6 && ![string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}
@end

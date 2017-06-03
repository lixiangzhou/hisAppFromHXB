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

@interface HXBCheckCaptcha ()
///点击了确认按钮
@property (nonatomic, copy) void(^clickTrueButtonBlock)(NSString *checkCaptChaStr);

///点击了图验imageView
@property (nonatomic, copy) void(^clickCheckCaptchaImageViewBlock)();

@property (nonatomic,strong) UILabel *promptLabel;
@property (nonatomic,strong) UIImageView *checkCaptchaImageView;
@property (nonatomic,strong) UITextField *checkCaptchaTextField;
@property (nonatomic,strong) UIButton *trueButton;
@end


@implementation HXBCheckCaptcha
- (void)setIsCorrect:(BOOL)isCorrect {
    _isCorrect = isCorrect;
    if(!isCorrect) {
        self.promptLabel.text = @"验证码输入错误";
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
    self.checkCaptchaImageView = [[UIImageView alloc]init];
    self.checkCaptchaTextField = [[UITextField alloc]init];
    self.trueButton = [[UIButton alloc]init];
    
    [self addSubview: self.promptLabel];
    [self addSubview: self.checkCaptchaImageView];
    [self addSubview: self.checkCaptchaTextField];
    [self addSubview: self.trueButton];
}

- (void) layoutSubViewS_checkCaptcha {
    kWeakSelf
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf);
        make.height.offset(kScrAdaptationH(40));
    }];
    [self.checkCaptchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.promptLabel.mas_bottom).offset(kScrAdaptationH(20));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.width.offset(kScrAdaptationW(80));
    }];
    [self.checkCaptchaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.checkCaptchaTextField);
        make.left.equalTo(weakSelf.checkCaptchaTextField.mas_right).offset(kScrAdaptationW(20));
        make.height.offset(kScrAdaptationH(40));
        make.width.offset(kScrAdaptationW(50));
    }];
    [self.trueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf);
        make.height.offset(kScrAdaptationH(40));
    }];
    
    self.promptLabel.backgroundColor = [UIColor hxb_randomColor];
    self.checkCaptchaTextField.backgroundColor = [UIColor hxb_randomColor];
    self.checkCaptchaImageView.backgroundColor = [UIColor grayColor];
    self.trueButton.backgroundColor = [UIColor hxb_randomColor];
}

- (void)setUPSubVeiwValue {
    self.promptLabel.text = kPromptTetle;
    [self.trueButton setTitle:kTrueButtonTitle forState:UIControlStateNormal];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(clickCheckCaptchaImageView:)];
    self.checkCaptchaImageView.userInteractionEnabled = true;
    [self.checkCaptchaImageView addGestureRecognizer:tap];
}

- (void)registerEvent {
    [self.trueButton addTarget:self action:@selector(clickTrueButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickTrueButton: (UIButton *)button {
    ///请求验证码 是否争正确
    if (self.checkCaptchaTextField.text.length != 4) {
        self.promptLabel.text = @"请输入正确的验证码";
        return;
    }
    if (self.clickTrueButtonBlock) {
        self.clickTrueButtonBlock(self.checkCaptchaTextField.text);
    }
}

- (void)clickTrueButtonFunc:(void (^)(NSString *checkCaptChaStr))clickTrueButtonBlock {
    self.clickTrueButtonBlock = clickTrueButtonBlock;
}

///点击了图形验证码 tap
- (void)clickCheckCaptchaImageView: (UITapGestureRecognizer *)tap {
    self.promptLabel.text = @"";
    if (self.clickCheckCaptchaImageViewBlock) self.clickCheckCaptchaImageViewBlock();
}

///点击了图形验证码
- (void)clickCheckCaptchaImageViewFunc: (void(^)())clickCheckCaptchaImageViewBlock {
    self.clickCheckCaptchaImageViewBlock = clickCheckCaptchaImageViewBlock;
}
@end

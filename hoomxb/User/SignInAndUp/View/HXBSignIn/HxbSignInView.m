
//
//  HxbSignInView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInView.h"
#import "SVGKit/SVGKImage.h"
#import "HXBSignInWaterView.h"//波浪式图
static NSString *const kForgetPasswordText = @"忘记密码";
static NSString *const kPhoneText = @"手机号";
static NSString *const kPasswordText = @"密码";
static NSString *const kSignInText = @"同意用户协议并登录";
static NSString *const kSignUPText = @"立即注册";

static NSString *const kPhoneText_Error = @"请输入正确的手机号码";
static NSString *const kPhoneText_Nil = @"手机号码不能为空";
static NSString *const kPassword_Nil = @"密码不能为空";
static NSString *const kThePhoneNumberDoesNotMatchThePassword = @"手机号与密码不匹配";

///注册登录的View
@interface HxbSignInView ()<UITextFieldDelegate>
///波浪视图
@property (nonatomic,strong) HXBSignInWaterView *waterView;

///点击了登录按钮
@property (nonatomic,copy) void(^clickSignInButtonBlock)(NSString *pasword,NSString *mobile);
///点击了注册按钮
@property (nonatomic,copy) void(^clickSignUpButtonBlock)();

///电话号码
@property (nonatomic, strong) HXBCustomTextField *phoneTextField;
///密码
@property (nonatomic, strong) HXBCustomTextField *passwordTextField;
///登录按钮
@property (nonatomic, strong) UIButton *signInButton;
///注册按钮
@property (nonatomic, strong) UIButton *signUpbutton;
///手机号是否存在
@property (nonatomic, copy) void(^checkMobileBlock)(NSString *mobile);
///是否已经注册
@property (nonatomic, assign) BOOL isRegisterWithMobile;
///忘记密码按钮
@property (nonatomic,strong) UIButton *forgetPasswordButton;
/**
 用户协议
 */
@property (nonatomic, strong) UIButton *userAgreementBtn;
/**
 分割线
 */
@property (nonatomic, strong) UIView *partingLine;
///点击了忘记密码 button
@property (nonatomic,copy) void(^forgetPasswordButtonBlock)();
///点击了用户协议
@property (nonatomic, copy) void(^userAgreementBtnBlock)();

/**
 判断输入是否应该去请求防止412
 */
@property (nonatomic, copy) NSString *phoneText;
@end

@implementation HxbSignInView

#pragma mark - UI
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        ///创建自控制器
        [self setUPSubViews_Creat];
        ///设置子控件
        [self setUPSubViews_SetUP];
    }
    return self;
}

///创建自控制器
- (void)setUPSubViews_Creat {
    self.waterView = [[HXBSignInWaterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(111))];

    self.phoneTextField = [[HXBCustomTextField alloc]init];
    self.phoneTextField.text = KeyChain.mobile;
    self.passwordTextField = [[HXBCustomTextField alloc]init];
    self.signInButton = [[UIButton alloc]init];
    self.signUpbutton = [[UIButton alloc]init];
    self.forgetPasswordButton = [[UIButton alloc]init];
    self.userAgreementBtn = [[UIButton alloc] init];
    self.partingLine = [[UIView alloc] init];

    self.phoneTextField.limitStringLength = 11;
    kWeakSelf
    self.phoneTextField.block = ^(NSString *text) {
        NSLog(@"text = %@", text);
        if (text.length > 0 && self.passwordTextField.text.length > 0) {
            weakSelf.signInButton.backgroundColor = COR29;
            weakSelf.signInButton.userInteractionEnabled = YES;
        } else {
            weakSelf.signInButton.backgroundColor = COR12;
            weakSelf.signInButton.userInteractionEnabled = NO;
        }
        if (text.length == 11) {
            //是否为电话号码
            if (![weakSelf.phoneText isEqualToString:text]) {
                [weakSelf showISMobileNumberViewWithString:text];
            }
        }
        weakSelf.phoneText = text;
    };
    self.passwordTextField.block = ^(NSString *text) {
        if (text.length > 0 && self.phoneTextField.text.length > 0) {
            weakSelf.signInButton.backgroundColor = COR29;
            weakSelf.signInButton.userInteractionEnabled = YES;
        } else {
            weakSelf.signInButton.backgroundColor = COR12;
            weakSelf.signInButton.userInteractionEnabled = NO;
        }
    };
    
    self.phoneTextField.leftImage = [UIImage imageNamed:@"mobile_number"];
    self.passwordTextField.leftImage = [UIImage imageNamed:@"password"];

    NSMutableAttributedString *phoneAttrStr = [[NSMutableAttributedString alloc] initWithString:kPhoneText];
    // 设置字体和设置字体的范围
    [phoneAttrStr addAttribute:NSForegroundColorAttributeName
                            value:COR10
                            range:NSMakeRange(0, kPhoneText.length)];
    self.phoneTextField.attributedPlaceholder = phoneAttrStr;
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTextField.secureTextEntry = YES;
    
    NSMutableAttributedString *passwordAttrStr = [[NSMutableAttributedString alloc] initWithString:kPasswordText];
    // 设置字体和设置字体的范围
    [passwordAttrStr addAttribute:NSForegroundColorAttributeName
                    value:COR10
                    range:NSMakeRange(0, kPasswordText.length)];
    self.passwordTextField.attributedPlaceholder = passwordAttrStr;
    
    [self addSubview:self.waterView];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.signInButton];
    [self addSubview:self.signUpbutton];

    self.signInButton.backgroundColor = COR12;
    self.signInButton.userInteractionEnabled = NO;
    [self addSubview:self.forgetPasswordButton];
    [self addSubview:self.userAgreementBtn];

    [self addSubview:self.partingLine];

    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.waterView.mas_bottom).offset(kScrAdaptationH(64));
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.offset(kScrAdaptationH(60));
    }];

    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom);
        make.left.equalTo(self.phoneTextField);
        make.right.equalTo(self.phoneTextField);
        make.height.offset(kScrAdaptationH(60));
    }];

    [self.signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordTextField.mas_bottom).offset(kScrAdaptationH(50));
        make.right.equalTo(weakSelf).offset(-20);
        make.left.equalTo(weakSelf).offset(20);
        make.height.equalTo(@(kScrAdaptationH(41)));
    }];
    [self.signUpbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.signInButton.mas_bottom).offset(kScrAdaptationH(10));
        make.right.equalTo(@(kScrAdaptationW(-20)));
        make.height.equalTo(@(kScrAdaptationH(15)));
    }];

    [self.partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(kScrAdaptationH(-31));
        make.centerX.equalTo(weakSelf);
        make.height.equalTo(@(kScrAdaptationH(14)));
        make.width.offset(0.5);
    }];
    [self.userAgreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.partingLine);
        make.right.equalTo(weakSelf.partingLine.mas_left).offset(kScrAdaptationW(-13));
    }];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.partingLine);
        make.left.equalTo(weakSelf.partingLine.mas_right).offset(kScrAdaptationW(13));
    }];

    
}

///设置子控件
- (void)setUPSubViews_SetUP {
    self.phoneTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    //button 的设置
    [self.signInButton setTitle:kSignInText forState:UIControlStateNormal];
    self.signInButton.layer.cornerRadius = kScrAdaptationW(4);
    self.signInButton.layer.masksToBounds = YES;
    self.signInButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
    [self.signUpbutton setTitle:kSignUPText forState:UIControlStateNormal];
    [self.signUpbutton setTitleColor:RGB(253, 54, 54) forState:UIControlStateNormal];
    self.signUpbutton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    [self.forgetPasswordButton setTitle:kForgetPasswordText forState:UIControlStateNormal];
    
    self.signUpbutton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.signInButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.forgetPasswordButton setTitleColor:COR10 forState:UIControlStateNormal];
    self.forgetPasswordButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(13);
    [self.userAgreementBtn setTitle:@"用户协议" forState:UIControlStateNormal];
    [self.userAgreementBtn setTitleColor:COR10 forState:UIControlStateNormal];
    self.userAgreementBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(13);
    self.partingLine.backgroundColor = RGB(151, 151, 151);
    //点击事件的添加
    [self.signInButton addTarget:self action:@selector(clickSignInButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpbutton addTarget:self action:@selector(clickSignUPButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPasswordButton addTarget:self action:@selector(clickForgetPasswordButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.userAgreementBtn addTarget:self action:@selector(clickUserAgreementBtn) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action
/**
 点击了用户协议
 */
- (void)clickUserAgreementBtn
{
    if (self.userAgreementBtnBlock) {
        self.userAgreementBtnBlock();
    }
}

///点击了 登录按钮
- (void)clickSignInButton: (UIButton *)signInButton {
       ///可以登录
    if (self.clickSignInButtonBlock && ![self notFillInThoseInformation])
    {
        self.clickSignInButtonBlock(self.passwordTextField.text,self.phoneTextField.text);
    }
}
///点击了 注册按钮
- (void)clickSignUPButton: (UIButton *)signUPButton {
    if (self.clickSignUpButtonBlock) self.clickSignUpButtonBlock();
}

///点击了忘记密码按钮
- (void)clickForgetPasswordButton: (UIButton *)button {
    if (self.forgetPasswordButtonBlock) self.forgetPasswordButtonBlock();
}

#pragma mark - Helper
///判断 未填写那些资料 （密码、手机号）
- (BOOL)notFillInThoseInformation {
    //电话号码未填写
    if (!self.phoneTextField.text.length) {
        NSLog(@"%@",kPhoneText_Nil);
        [HxbHUDProgress showMessageCenter:kPhoneText_Nil inView:self];
        return YES;
    }

    if (!self.passwordTextField.text.length) {
        NSLog(@"%@",kPassword_Nil);
        [HxbHUDProgress showMessageCenter:kPassword_Nil inView:self];
        return YES;
    }
    NSString * message = [NSString isOrNoPasswordStyle:self.passwordTextField.text];
    if (message.length > 0) {
        [HxbHUDProgress showTextWithMessage:message];
        return YES;
    }
    return NO;
}

- (void)setIsDeletePassword:(BOOL)isDeletePassword {
    _isDeletePassword = isDeletePassword;
    if (_isDeletePassword) {
        self.passwordTextField.text = @"";
    }
}

///展示是否为电话号码
- (void)showISMobileNumberViewWithString:(NSString *)str {
    if (self.checkMobileBlock) {
        self.checkMobileBlock(str);
    }
}

#pragma mark - 点击事件的传递
///登录
- (void)signIN_ClickButtonFunc:(void (^)(NSString *pasword,NSString *mobile))clickSignInButtonBlock {
    self.clickSignInButtonBlock = clickSignInButtonBlock;
}
//注册
- (void)signUP_clickButtonFunc:(void (^)())clickSignUPButtonBlock {
    self.clickSignUpButtonBlock = clickSignUPButtonBlock;
}

///请求手机号是否存在
- (void) checkMobileRequestBlockFunc: (void(^)(NSString *mobile))checkMobileBlock {
    self.checkMobileBlock = checkMobileBlock;
}

///点击了忘记密码
- (void) clickforgetPasswordButtonFunc: (void(^)())forgetPasswordButtonBlock {
    self.forgetPasswordButtonBlock = forgetPasswordButtonBlock;
}
///点击了用户协议
- (void)clickUserAgreementBtnFunc:(void (^)())userAgreementBtnBlock
{
    self.userAgreementBtnBlock = userAgreementBtnBlock;
}
@end


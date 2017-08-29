
//
//  HxbSignInView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInView.h"
#import "SVGKImage.h"
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
@interface HxbSignInView ()
<
UITextFieldDelegate
>
///波浪视图
@property (nonatomic,strong) HXBSignInWaterView *waterView;

///点击了登录按钮
@property (nonatomic,copy) void(^clickSignInButtonBlock)(NSString *pasword,NSString *mobile);
///点击了注册按钮
@property (nonatomic,copy) void(^clickSignUpButtonBlock)();

///电话号码
@property (nonatomic, strong) UITextField *phoneTextField;
///密码
@property (nonatomic, strong) UITextField *passwordTextField;
///登录按钮
@property (nonatomic, strong) UIButton *signInButton;
///注册按钮
@property (nonatomic, strong) UIButton *signUpbutton;
///手机号
//@property (nonatomic, strong) UILabel *phoneNumberLabel;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UIView *phoneline;
///密码
//@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UIView *passwordline;
@property (nonatomic, strong) UIButton *password_eye_btn;
///显示手机号的信息的label (是否为手机号，手机号是否已注册)
//@property (nonatomic, strong) UILabel *isPhoneNumberLabel;
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
@end

@implementation HxbSignInView



#pragma mark - 参数的传递

///李鹏跃 ： 禁止用 登录按钮
- (void)checkMobileResultFuncWithCheckMobileResultStr:(NSString *)checkMobileResultStr andIsEditLoginButton:(BOOL)isEditLoginButton {
//    self.isPhoneNumberLabel.text = checkMobileResultStr;
    if (!isEditLoginButton) {
//        [HxbHUDProgress showError:checkMobileResultStr inview:self];
        [HxbHUDProgress showMessageCenter:checkMobileResultStr inView:self];
    }
//    self.signInButton.userInteractionEnabled = isEditLoginButton;
}



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
    self.phoneline = [[UIView alloc] init];
    self.passwordline = [[UIView alloc] init];
    self.phoneline.backgroundColor = RGB(221, 221, 221);
    self.passwordline.backgroundColor = RGB(221, 221, 221);
    self.phoneTextField = [[UITextField alloc]init];
    self.phoneTextField.font = kHXBFont_PINGFANGSC_REGULAR(15);
    self.phoneTextField.text = KeyChain.mobile;
    self.passwordTextField = [[UITextField alloc]init];
    self.signInButton = [[UIButton alloc]init];
    self.signUpbutton = [[UIButton alloc]init];
    self.forgetPasswordButton = [[UIButton alloc]init];
    self.userAgreementBtn = [[UIButton alloc] init];
    self.password_eye_btn = [[UIButton alloc] init];
    self.partingLine = [[UIView alloc] init];
    
    [self.password_eye_btn setImage:[SVGKImage imageNamed:@"password_eye_close.svg"].UIImage forState:UIControlStateNormal];
    [self.password_eye_btn setImage:[SVGKImage imageNamed:@"password_eye_open.svg"].UIImage forState:UIControlStateSelected];
    [self.password_eye_btn addTarget:self action:@selector(passwordEyeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    self.phoneNumberLabel = [[UILabel alloc]init];///关于手机号的Label
//    SVGKImage *phonesvgImage = [SVGKImage imageNamed:@"mobile_number.svg"];
//    self.phoneImageView = [[UIImageView alloc] initWithImage:phonesvgImage.UIImage];
    self.phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_number"]];
    self.phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
//    SVGKImage *passwordsvgImage = [SVGKImage imageNamed:@"password.svg"];
//    self.passwordImageView = [[UIImageView alloc] initWithImage:passwordsvgImage.UIImage];///关于密码的label
    self.passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    self.passwordImageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    self.isPhoneNumberLabel = [[UILabel alloc]init];///显示手机号的信息的label (是否为手机号，手机号是否已注册)
    NSMutableAttributedString *phoneAttrStr = [[NSMutableAttributedString alloc] initWithString:kPhoneText];
    // 设置字体和设置字体的范围
    [phoneAttrStr addAttribute:NSForegroundColorAttributeName
                            value:COR10
                            range:NSMakeRange(0, kPhoneText.length)];
    self.phoneTextField.attributedPlaceholder = phoneAttrStr;
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTextField.secureTextEntry = true;
    NSMutableAttributedString *passwordAttrStr = [[NSMutableAttributedString alloc] initWithString:kPasswordText];
    // 设置字体和设置字体的范围
    [passwordAttrStr addAttribute:NSForegroundColorAttributeName
                    value:COR10
                    range:NSMakeRange(0, kPasswordText.length)];
    self.passwordTextField.attributedPlaceholder = passwordAttrStr;
    
    self.passwordTextField.font = kHXBFont_PINGFANGSC_REGULAR(15);
    [self addSubview:self.waterView];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.signInButton];
    [self addSubview:self.signUpbutton];
    
    [self addSubview:self.phoneImageView];
    [self addSubview:self.passwordImageView];
    
//    [self addSubview:self.isPhoneNumberLabel];
    [self addSubview:self.forgetPasswordButton];
    [self addSubview:self.userAgreementBtn];
    [self addSubview:self.phoneline];
    [self addSubview:self.passwordline];
    [self addSubview:self.password_eye_btn];
    [self addSubview:self.partingLine];
    
    kWeakSelf
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.waterView.mas_bottom).offset(kScrAdaptationH(64));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(21));
        make.width.equalTo(@(kScrAdaptationW(13)));
        make.height.offset(kScrAdaptationH(19));
    }];
    [self.passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneImageView.mas_bottom).offset(kScrAdaptationH(43));
        make.left.equalTo(@(kScrAdaptationW(21)));
        make.width.equalTo(@(kScrAdaptationW(14)));
        make.height.equalTo(@(kScrAdaptationH(18)));
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.phoneImageView);
        make.left.equalTo(weakSelf.phoneImageView.mas_right).offset(kScrAdaptationW(14));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
    }];
    [self.phoneline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneImageView.mas_bottom).offset(kScrAdaptationH(15));;
        make.left.equalTo(weakSelf.phoneImageView.mas_left);
        make.right.equalTo(weakSelf.phoneTextField.mas_right);
        make.height.equalTo(@0.5);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.passwordImageView);
        make.right.left.equalTo(weakSelf.phoneTextField);
        make.width.height.centerX.equalTo(weakSelf.phoneTextField);
    }];
    [self.password_eye_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.passwordTextField);
        make.right.equalTo(weakSelf.phoneTextField.mas_right);
        make.width.equalTo(@(kScrAdaptationW(20)));
        make.height.equalTo(@(kScrAdaptationH(12)));
    }];
    
    [self.passwordline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordImageView.mas_bottom).offset(kScrAdaptationH(15));;
        make.left.equalTo(weakSelf.passwordImageView.mas_left);
        make.right.equalTo(weakSelf.passwordTextField.mas_right);
        make.height.equalTo(@0.5);
    }];
    [self.signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordline.mas_bottom).offset(kScrAdaptationH(50));
        make.right.equalTo(weakSelf).offset(-20);
        make.left.equalTo(weakSelf).offset(20);
        make.height.equalTo(@(kScrAdaptationH(41)));
    }];
    [self.signUpbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.signInButton.mas_bottom).offset(kScrAdaptationH(10));
        make.right.equalTo(@(kScrAdaptationW(-20)));
        make.height.equalTo(@(kScrAdaptationH(15)));
    }];
    
//    [self.isPhoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf).offset(kScrAdaptationH(80));
//        make.width.equalTo(weakSelf);
//    }];
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
    
//    self.signInButton.backgroundColor = [UIColor hxb_randomColor];
//    self.signUpbutton.backgroundColor = [UIColor hxb_randomColor];
//    self.passwordTextField.backgroundColor = [UIColor hxb_randomColor];
//    self.phoneTextField.backgroundColor = [UIColor hxb_randomColor];
//    self.isPhoneNumberLabel.backgroundColor = [UIColor hxb_randomColor];
//    self.forgetPasswordButton.backgroundColor = [UIColor hxb_randomColor];
    
}

- (void)passwordEyeBtnClick
{
    self.passwordTextField.secureTextEntry = self.password_eye_btn.selected;
    self.password_eye_btn.selected = !self.password_eye_btn.selected;
}

///设置子控件
- (void)setUPSubViews_SetUP {
    //赋值
//    self.phoneNumberLabel.text = kPhoneText;//手机号
//    self.passwordLabel.text = kPasswordText;//密码
////    self.phoneNumberLabel.textColor = [UIColor redColor];
//    self.passwordLabel.textColor = [UIColor redColor];
    
    self.phoneTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.phoneTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.phoneTextField.clearsOnBeginEditing = NO;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //button 的设置
    [self.signInButton setTitle:kSignInText forState:UIControlStateNormal];
    self.signInButton.layer.cornerRadius = kScrAdaptationW(4);
    self.signInButton.layer.masksToBounds = YES;
    self.signInButton.backgroundColor = RGB(245, 81, 81);
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
///判断 未填写那些资料 （密码、手机号）
- (BOOL) notFillInThoseInformation {
    //电话号码未填写
    if (!self.phoneTextField.text.length) {
        NSLog(@"%@",kPhoneText_Nil);
        [HxbHUDProgress showMessageCenter:kPhoneText_Nil inView:self];
        return true;
    }
    ///填写的不是手机号码
    if (![NSString isMobileNumber:self.phoneTextField.text]) {
        NSLog(@"填写正确的手机号");
        [HxbHUDProgress showMessageCenter:@"填写正确的手机号" inView:self];
        return YES;
    }
    if (!self.passwordTextField.text.length) {
        NSLog(@"%@",kPassword_Nil);
        [HxbHUDProgress showMessageCenter:kPassword_Nil inView:self];
        return true;
    }
    NSString * message = [NSString isOrNoPasswordStyle:self.passwordTextField.text];
    if (message.length > 0) {
        [HxbHUDProgress showTextWithMessage:message];
        return YES;
    }
    return false;
}
///点击了忘记密码按钮
- (void)clickForgetPasswordButton: (UIButton *)button {
    if (self.forgetPasswordButtonBlock) self.forgetPasswordButtonBlock();
}


#pragma mark - textField 的代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return true;
}
///当textField 的值将要改变的时候调用
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    //1、textField 输入string后的值
    NSString *str = nil;
    if (string.length) {
        str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    else if(!string.length) {
        NSInteger length = self.phoneTextField.text.length;
        NSRange range = NSMakeRange(length - 1, 1);
        NSMutableString *strM = self.phoneTextField.text.mutableCopy;
        [strM deleteCharactersInRange:range];
        str = strM.copy;
    }
    if (str.length > 20) {//防止了重复请求数据 以及\n换行的错误
        [self firstResponderChenge];
        return false;
    }
    
    //是否展示清除按钮
//    UITextFieldViewMode model = str.length ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
//    textField.clearButtonMode = model;
    
    //如果是号码textField 那么就直接返回true
    if (textField == self.passwordTextField) return true;
    
    //如果是号密码的textField 那么就判断，是否超多了11位，如果超过了，就直接取消第一相应，并调到密码的第一相应
    [self isPhoneTextFieldLenthOutdo11WithStr:str];
    //是否为电话号码
    [self showISMobileNumberViewWithString: str];
    
    //点击了删除按钮
    if ([string isEqual: @""]) return true;
    return true;
}

///停止编辑的时候要判断有没有手势密码。（有 输入，没有就去设置）
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == self.phoneTextField) {
        
    }
    return true;
}

///电话的number是否为超出了11位
- (void) isPhoneTextFieldLenthOutdo11WithStr: (NSString *)phoneText {
    if(phoneText.length > 11) {
        [self firstResponderChenge];
    }
}
- (void)firstResponderChenge {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField becomeFirstResponder];
}
///展示是否为电话号码
- (void)showISMobileNumberViewWithString:(NSString *)str {
    BOOL isTrue = [NSString isMobileNumber:str];
    NSLog(@"电话号码-- %d",isTrue);
    if (!isTrue) {//不是真的，提示输入正确的密码
//        self.isPhoneNumberLabel.text = kPhoneText_Error;
        return;
    }
//    self.isPhoneNumberLabel.text = @"";
    ///请求手机号是否存在
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


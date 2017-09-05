//
//  HXBSendSmscodeView.m
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSendSmscodeView.h"
#import "SVGKImage.h"
#import "HXBCustomTextField.h"
#import "HXBFinBaseNegotiateView.h"
#import "HXBSignInWaterView.h"
static NSString *const kSmscode_ConstLableTitle = @"验证码";
static NSString *const kPassword_constLableTitle = @"设置登录密码";
static NSString *const kSetPassWordButtonTitle = @"确认设置登录密码";
static NSString *const kSendSmscodeAgainTitle = @"再次发送";
static NSString *const kSendSmscodeTitle = @"发送验证码";

@interface HXBSendSmscodeView () <UITextFieldDelegate>
/// 倒计时秒数
@property (nonatomic, assign) NSInteger totalTimeNumber;
@property (nonatomic, assign) NSInteger timeNumber;
///展示手机号的label
@property (nonatomic, strong) UILabel       *phonNumberLabel;
///验证码的textField
@property (nonatomic, strong) UITextField   *smscode_TextField;
///验证码
//@property (nonatomic, strong) UILabel       *smscode_constLabel;
@property (nonatomic, strong) UIImageView *smscode_constImageView;
///发送按钮
@property (nonatomic, strong) UIButton      *sendButton;
/**
 下划线
 */
@property (nonatomic, strong) UIView *codeLine;
///定时器
@property (nonatomic, strong) NSTimer       *timer;
///密码输入框
@property (nonatomic, strong) UITextField   *password_TextField;
///输入密码说明
//@property (nonatomic, strong) UILabel       *password_constLable;
@property (nonatomic, strong) UIImageView *passwordImageView;
///眼睛按钮
@property (nonatomic, strong) UIButton    *eyeButton;

@property (nonatomic, strong) UIView *passwordLine;
///确认设置密码按钮
@property (nonatomic, strong) UIButton      *setPassWordButton;
/**
 邀请码
 */
@property (nonatomic, strong) HXBCustomTextField *inviteCodeTextField;


//@property (nonatomic,strong) UITextField *inviteCodeTextField;
/**
 用户协议
 */
@property (nonatomic, strong) HXBFinBaseNegotiateView *negotiateView;
//@property (nonatomic,strong) UIButton *negotiateButton;
/// 密码是否合格 （字符，数字不能有特殊字符）
@property (nonatomic, assign) BOOL isPasswordQualified;
///点击了确认
@property (nonatomic, copy) void(^clickSetPassWordButtonBlock)(NSString *password, NSString *smscode,NSString *inviteCode);
///点击了发送短信验证码按钮
@property (nonatomic, copy) void(^clickSendSmscodeButtonBlock)();
///点击了服务协议
@property (nonatomic, copy) void(^clickAgreementSignUPBlock)();
///波浪视图
@property (nonatomic, strong) HXBSignInWaterView *waterView;

@end

@implementation HXBSendSmscodeView
- (void)setType:(HXBSignUPAndLoginRequest_sendSmscodeType)type {
    _type = type;
    switch (type) {
        case HXBSignUPAndLoginRequest_sendSmscodeType_forgot:
        {
            [self.inviteCodeTextField setHidden:true];
            [self.negotiateView setHidden:true];
            [self.setPassWordButton setTitle:@"确认登录密码" forState:UIControlStateNormal];
            [self.setPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.passwordLine.mas_bottom).offset(kScrAdaptationH(50));
                make.left.equalTo(self).offset(kScrAdaptationW(20));
                make.right.equalTo(self).offset(kScrAdaptationW(-20));
                make.height.offset(kScrAdaptationH(41));
            }];
        }
            break;
        case HXBSignUPAndLoginRequest_sendSmscodeType_signup:
        {
            [self.setPassWordButton setTitle:@"注册" forState:UIControlStateNormal];
            [self.setPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.inviteCodeTextField.mas_bottom).offset(kScrAdaptationH(50));
                make.left.equalTo(self).offset(kScrAdaptationW(20));
                make.right.equalTo(self).offset(kScrAdaptationW(-20));
                make.height.offset(kScrAdaptationH(41));
            }];
            [self.negotiateView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.setPassWordButton.mas_bottom).offset(kScrAdaptationH(10));
                make.left.right.equalTo(self).offset(kScrAdaptationW(65));
                make.right.equalTo(self).offset(kScrAdaptationW(-80));
                make.height.offset(kScrAdaptationH(14));
            }];
        }
            break;
        default:
            break;
    }
}
- (void)setPhonNumber:(NSString *)phonNumber {
    _phonNumber = phonNumber;
    NSString *str = [NSString hiddenStr:phonNumber MidWithFistLenth:3 andLastLenth:4];
    NSString *strLabel = [NSString stringWithFormat:@"已向手机%@发送短息",str];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:strLabel];
    // 设置字体和设置字体的范围
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:RGB(253, 54, 54)
                    range:[strLabel rangeOfString:str]];
    self.phonNumberLabel.attributedText = attrStr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUP];
        self.totalTimeNumber = 60;
        self.timeNumber = self.totalTimeNumber;
    }
    return self;
}

- (void)setUP {
    [self creatSubView];
    [self layoutSubView_sendSmscode];
    [self setSubView];
    [self addButtonTarget];
}

- (void)didMoveToSuperview {
    [self clickSendButton:self.sendButton];
}
- (HXBSignInWaterView *)waterView
{
    if (!_waterView) {
        _waterView = [[HXBSignInWaterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(111))];
    }
    return _waterView;
}
- (NSTimer *) timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

///创建对象
- (void)creatSubView {
    self.phonNumberLabel = [[UILabel alloc]init];
    self.smscode_TextField = [[UITextField alloc]init];
    self.smscode_constImageView = [[UIImageView alloc]init];
    self.sendButton = [[UIButton alloc]init];
    self.password_TextField = [[UITextField alloc]init];
    self.passwordImageView = [[UIImageView alloc]init];
    self.eyeButton = [[UIButton alloc]init];
    self.setPassWordButton = [[UIButton alloc]init];
    self.inviteCodeTextField = [[HXBCustomTextField alloc]init];
    self.negotiateView = [[HXBFinBaseNegotiateView alloc]init];
    self.codeLine = [[UIView alloc] init];
    self.passwordLine = [[UIView alloc] init];
    
    [self addSubview : self.phonNumberLabel];
    [self addSubview : self.smscode_TextField];
    [self addSubview : self.smscode_constImageView];
    [self addSubview : self.sendButton];
    [self addSubview : self.password_TextField];
    [self addSubview : self.passwordImageView];
    [self addSubview : self.eyeButton];
    [self addSubview : self.setPassWordButton];
    [self addSubview:self.inviteCodeTextField];
    [self addSubview:self.negotiateView];
    [self addSubview:self.codeLine];
    [self addSubview:self.passwordLine];
    [self addSubview:self.waterView];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    
    self.password_TextField.placeholder = @"8-20位数组大小写字母组成";
    self.password_TextField.delegate = self;
    self.inviteCodeTextField.placeholder = @"请输入邀请码";
    self.inviteCodeTextField.keyboardType = UIKeyboardTypeDefault;
    self.inviteCodeTextField.delegate = self;
    self.inviteCodeTextField.leftImage = [UIImage imageNamed:@"invitation_code"];
    
    self.negotiateView.negotiateStr = @"红小宝注册协议";
    kWeakSelf
    [self.negotiateView clickNegotiateWithBlock:^{
        NSLog(@"点击了红小宝注册协议");
        if (weakSelf.clickAgreementSignUPBlock) weakSelf.clickAgreementSignUPBlock();
    }];
    [self.negotiateView clickCheckMarkWithBlock:^(BOOL isSelected) {
        if (isSelected) {
            weakSelf.setPassWordButton.enabled = YES;
            weakSelf.setPassWordButton.backgroundColor = COR29;
        }else
        {
            weakSelf.setPassWordButton.enabled = NO;
            weakSelf.setPassWordButton.backgroundColor = kHXBColor_Font0_5;
            [weakSelf.setPassWordButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }
    }];
}

- (void)layoutSubView_sendSmscode {
    kWeakSelf
    [self.phonNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.waterView.mas_bottom).offset(kScrAdaptationH(30));
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.smscode_constImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phonNumberLabel.mas_bottom).offset(kScrAdaptationH(45));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.width.offset(kScrAdaptationW750(36));
        make.height.offset(kScrAdaptationH750(38));
    }];
    [self.codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.smscode_constImageView.mas_bottom).offset(kScrAdaptationH(17));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.offset(0.5);
    }];
    [self.smscode_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.sendButton.mas_left);
        make.centerY.height.equalTo(weakSelf.smscode_constImageView);
        make.left.equalTo(weakSelf.smscode_constImageView.mas_right).offset(kScrAdaptationW(10));
    }];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.smscode_constImageView);
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.width.equalTo(@(kScrAdaptationW(80)));
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
    [self.passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.codeLine.mas_bottom).offset(kScrAdaptationH(27));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.width.offset(kScrAdaptationW750(36));
        make.height.offset(kScrAdaptationH750(45));
    }];
    [self.password_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(weakSelf.passwordImageView);
        make.left.equalTo(weakSelf.passwordImageView.mas_right).offset(kScrAdaptationW(10));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
    }];
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.passwordImageView);
        make.right.equalTo(weakSelf.password_TextField.mas_right);
        make.width.offset(kScrAdaptationW(20));
        make.height.offset(kScrAdaptationH(12));
    }];
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordImageView.mas_bottom).offset(kScrAdaptationH(17));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.offset(0.5);
    }];
    
    
    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordLine.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.offset(kScrAdaptationH(60));
    }];
}

///设置
- (void)setSubView {
//    self.password_TextField.delegate = self;
    self.password_TextField.secureTextEntry = true;
//    self.smscode_TextField.delegate = self;
    
    self.phonNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    self.phonNumberLabel.textColor = RGB(51, 51, 51);
    
    self.smscode_TextField.font = kHXBFont_PINGFANGSC_REGULAR(15);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:kSmscode_ConstLableTitle];
    // 设置字体和设置字体的范围
    self.smscode_TextField.delegate = self;
    self.smscode_TextField.keyboardType = UIKeyboardTypeNumberPad;
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:COR10
                    range:NSMakeRange(0, kSmscode_ConstLableTitle.length)];
    self.smscode_TextField.attributedPlaceholder = attrStr;
    
    
    self.password_TextField.font = kHXBFont_PINGFANGSC_REGULAR(15);
    NSMutableAttributedString *passwordattrStr = [[NSMutableAttributedString alloc] initWithString:kPassword_constLableTitle];
    // 设置字体和设置字体的范围
    [passwordattrStr addAttribute:NSForegroundColorAttributeName
                    value:COR10
                    range:NSMakeRange(0, kPassword_constLableTitle.length)];
    self.password_TextField.attributedPlaceholder = passwordattrStr;
    
    self.smscode_constImageView.svgImageString = @"security_code";
    self.smscode_constImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.sendButton.backgroundColor = RGB(222, 222, 222);
    self.sendButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.layer.cornerRadius = kScrAdaptationW(4);
    self.sendButton.layer.masksToBounds = YES;
    
    self.codeLine.backgroundColor = RGB(221, 221, 221);
    self.passwordLine.backgroundColor = RGB(221, 221, 221);
    
    self.passwordImageView.svgImageString = @"password";
    self.passwordImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.eyeButton setImage:[SVGKImage imageNamed:@"password_eye_close.svg"].UIImage forState:UIControlStateNormal];
    [self.eyeButton setImage:[SVGKImage imageNamed:@"password_eye_open.svg"].UIImage forState:UIControlStateSelected];
    
    self.setPassWordButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
    [self.setPassWordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setPassWordButton.backgroundColor = RGB(245, 81, 81);
    self.setPassWordButton.layer.cornerRadius = kScrAdaptationW(4);
    self.setPassWordButton.layer.masksToBounds = YES;
}


///事件
- (void) addButtonTarget {
    [self.sendButton addTarget:self action:@selector(clickSendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.eyeButton addTarget:self action:@selector(clickEyeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.setPassWordButton addTarget:self action:@selector(clickSetPassWordButton:) forControlEvents:UIControlEventTouchUpInside];
}
///点击了眼睛的按钮
- (void)clickEyeButton: (UIButton *)button {
    self.eyeButton.selected = !self.eyeButton.selected;
    self.password_TextField.secureTextEntry = !self.eyeButton.selected;
}

///点击了发送按钮
- (void)clickSendButton: (UIButton *)button {
    [self setSendButtonStatus];
    self.sendButton.backgroundColor = RGB(222, 222, 222);
    if (self.clickSendSmscodeButtonBlock) self.clickSendSmscodeButtonBlock();
    
}

- (void) setSendButtonStatus {
    self.sendButton.userInteractionEnabled = false;
    [self.timer fire];
}

///点击了确定设置按钮
- (void)clickSetPassWordButton: (UIButton *)button {
    [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_registSuccess];
    if (self.smscode_TextField.text.length == 0) {
        [HxbHUDProgress showTextWithMessage:@"请输入验证码"];
    } else if (self.smscode_TextField.text.length != 6) {
        [HxbHUDProgress showTextWithMessage:@"请输入正确的验证码"];
    } else {
        if([self isPasswordQualifiedFunWithStr:self.password_TextField.text]) {
            if (self.inviteCodeTextField.text.length == 0) {
                [HxbHUDProgress showTextWithMessage:@"请输入邀请码"];
            } else {
                //合格 请求数据
                if (self.clickSetPassWordButtonBlock)
                    self.clickSetPassWordButtonBlock(self.password_TextField.text,self.smscode_TextField.text,self.inviteCodeTextField.text);
            }
        }else {
            NSString * message = [NSString isOrNoPasswordStyle:self.password_TextField.text];
            [HxbHUDProgress showTextWithMessage:message];
            NSLog(@"🌶密码不合格");
            //        [HxbHUDProgress showTextWithMessage:@"🌶密码不合格"];
        }
    }
}

- (void)addTime {
    self.timeNumber --;
    
    [self.sendButton setTitle:[NSString stringWithFormat:@"%@s",@(self.timeNumber).description] forState:UIControlStateNormal];
    if (self.timeNumber <= 0) {
        [self.sendButton setTitle:kSendSmscodeAgainTitle forState:UIControlStateNormal];
        [self.sendButton setBackgroundColor:RGB(245, 81, 81)];
        [self deleteTimer];
        self.timeNumber = self.totalTimeNumber;
        self.sendButton.userInteractionEnabled = true;
    }
}
///销毁定时器
- (void)deleteTimer {
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
    self.timer = nil;
}

#pragma mark - textField delegate
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.smscode_TextField) {
        if (textField.text.length > 5 && ![string isEqualToString: @""]) {
            return NO;
        }
    }
    if ([NSString isChinese:string] || [NSString isIncludeSpecialCharact:string] || [string isEqualToString:@" "]) {
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.4 animations:^{
        self.y = - 90;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.4 animations:^{
        self.y = 0;
    }];

}



- (BOOL)isPasswordQualifiedFunWithStr: (NSString *)password {
    ///判断字符串是否包含数字
    BOOL isContentNumber = [NSString isStringContainNumberWith:password];
    ///判断是否有中文字符
    BOOL isContentChiness = [NSString isChinese:password];
    ///判断字符串是否包含特殊字符
    BOOL isContentSpecialCharact = [NSString isIncludeSpecialCharact:password];
    ///判断是否有字母
    BOOL isContentCar = [NSString isStringCOntainStringWith:password];
    
    return isContentNumber && (!isContentChiness) && (!isContentSpecialCharact) && isContentCar;
}

///点击了确认设置密码按钮
- (void)clickSetPassWordButtonFunc:(void (^)(NSString *password, NSString *smscode,NSString *inviteCode))clickSetPassWordButtonBlock {
    self.clickSetPassWordButtonBlock = clickSetPassWordButtonBlock;
}

///点击了发送短信验证码按钮
- (void)clickSendSmscodeButtonWithBlock: (void(^)())clickSendSmscodeButtonBlock {
    self.clickSendSmscodeButtonBlock = clickSendSmscodeButtonBlock;
}

///点击了服务协议
- (void)clickAgreementSignUPWithBlock:(void (^)())clickAgreementSignUPBlock {
    self.clickAgreementSignUPBlock = clickAgreementSignUPBlock;
}
#pragma make UITextFieldDelegate

@end

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

static NSString *const kSmscode_ConstLableTitle = @"请输入验证码";
static NSString *const kPassword_constLableTitle = @"密码为8-20位数字与字母组合";
static NSString *const kSetPassWordButtonTitle = @"确认设置登录密码";
static NSString *const kSendSmscodeAgainTitle = @"获取验证码";
static NSString *const kSendSmscodeTitle = @"发送验证码";

@interface HXBSendSmscodeView () <UITextFieldDelegate>
/// 倒计时秒数
@property (nonatomic, assign) NSInteger totalTimeNumber;
@property (nonatomic, assign) NSInteger timeNumber;
///展示手机号的label
@property (nonatomic, strong) UILabel       *phonNumberLabel;
///验证码的textField
@property (nonatomic, strong) HXBCustomTextField   *smscode_TextField;
///发送按钮
@property (nonatomic, strong) UIButton      *sendButton;

///定时器
@property (nonatomic, strong) NSTimer       *timer;
///密码输入框
@property (nonatomic, strong) HXBCustomTextField   *password_TextField;

///确认设置密码按钮
@property (nonatomic, strong) UIButton      *setPassWordButton;

@property (nonatomic, strong) HXBCustomTextField *inviteCodeTextField;
@property (nonatomic, assign) BOOL isSelect;
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


@end

@implementation HXBSendSmscodeView
- (void)setType:(HXBSignUPAndLoginRequest_sendSmscodeType)type {
    _type = type;
    switch (type) {
        case HXBSignUPAndLoginRequest_sendSmscodeType_forgot:
        {
            [self.inviteCodeTextField setHidden:true];
            [self.negotiateView setHidden:true];
            [self.setPassWordButton setTitle:@"确认重置密码" forState:UIControlStateNormal];
            [self.setPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.password_TextField.mas_bottom).offset(kScrAdaptationH(50));
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
    NSString *strLabel = [NSString stringWithFormat:@"已向手机%@发送短信",str];
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
    self.smscode_TextField = [[HXBCustomTextField alloc]init];
    
    self.smscode_TextField.isGetCode = YES;
    self.smscode_TextField.number = 1;
    _isSelect = YES;
    self.sendButton = [[UIButton alloc]init];
    self.password_TextField = [[HXBCustomTextField alloc]init];
    self.password_TextField.number = 2;
    self.setPassWordButton = [[UIButton alloc]init];
    self.inviteCodeTextField = [[HXBCustomTextField alloc]init];
    self.inviteCodeTextField.number = 3;
    self.negotiateView = [[HXBFinBaseNegotiateView alloc]init];
    
    self.smscode_TextField.leftImage = [UIImage imageNamed:@"security_code"];
    self.password_TextField.leftImage = [UIImage imageNamed:@"password"];
    self.inviteCodeTextField.leftImage = [UIImage imageNamed:@"invitation_code"];
    self.password_TextField.secureTextEntry = YES;
    self.password_TextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.smscode_TextField.delegate = self;
    self.password_TextField.delegate = self;
    self.inviteCodeTextField.delegate = self;
    self.smscode_TextField.limitStringLength = 6;
    self.password_TextField.limitStringLength = 20;
    self.inviteCodeTextField.limitStringLength = 1000;
    
    kWeakSelf
    self.smscode_TextField.block = ^(NSString *text) {
        if (_type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot ) {
            if (text.length > 0 && _password_TextField.text.length > 0 && _isSelect) {
                weakSelf.setPassWordButton.backgroundColor = COR29;
                weakSelf.setPassWordButton.userInteractionEnabled = YES;
            } else {
                weakSelf.setPassWordButton.backgroundColor = COR12;
                weakSelf.setPassWordButton.userInteractionEnabled = NO;
            }
        } else {
            if (text.length > 0 && _password_TextField.text.length > 0 && _inviteCodeTextField.text.length > 0 && _isSelect) {
                weakSelf.setPassWordButton.backgroundColor = COR29;
                weakSelf.setPassWordButton.userInteractionEnabled = YES;
            } else {
                weakSelf.setPassWordButton.backgroundColor = COR12;
                weakSelf.setPassWordButton.userInteractionEnabled = NO;
            }
        }
    };
    self.password_TextField.block = ^(NSString *text) {
        if (_type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot ) {
            if (text.length > 0 && _smscode_TextField.text.length > 0 && _isSelect) {
                weakSelf.setPassWordButton.backgroundColor = COR29;
                weakSelf.setPassWordButton.userInteractionEnabled = YES;
            } else {
                weakSelf.setPassWordButton.backgroundColor = COR12;
                weakSelf.setPassWordButton.userInteractionEnabled = NO;
            }
        } else {
            if (text.length > 0 && _smscode_TextField.text.length > 0 && _inviteCodeTextField.text.length > 0 && _isSelect) {
                weakSelf.setPassWordButton.backgroundColor = COR29;
                weakSelf.setPassWordButton.userInteractionEnabled = YES;
            } else {
                weakSelf.setPassWordButton.backgroundColor = COR12;
                weakSelf.setPassWordButton.userInteractionEnabled = NO;
            }
        }
        
    };
    self.inviteCodeTextField.block = ^(NSString *text) {
        if (text.length > 0 && _password_TextField.text.length > 0 && _smscode_TextField.text.length > 0 && _isSelect) {
            weakSelf.setPassWordButton.backgroundColor = COR29;
            weakSelf.setPassWordButton.userInteractionEnabled = YES;
        } else {
            weakSelf.setPassWordButton.backgroundColor = COR12;
            weakSelf.setPassWordButton.userInteractionEnabled = NO;
        }
    };
    
    [self addSubview : self.phonNumberLabel];
    [self addSubview : self.smscode_TextField];
    [self addSubview : self.sendButton];
    [self addSubview : self.password_TextField];
    [self addSubview : self.setPassWordButton];
    [self addSubview : self.inviteCodeTextField];
    [self addSubview : self.negotiateView];
   
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    
    self.password_TextField.placeholder = @"密码为8-20位数字与字母组合";
    self.inviteCodeTextField.placeholder = @"请输入邀请码";
    self.inviteCodeTextField.keyboardType = UIKeyboardTypeASCIICapable;
    

    
    self.negotiateView.negotiateStr = @"红小宝注册协议";
    [self.negotiateView clickNegotiateWithBlock:^{
        NSLog(@"点击了红小宝注册协议");
        if (weakSelf.clickAgreementSignUPBlock) weakSelf.clickAgreementSignUPBlock();
    }];
    [self.negotiateView clickCheckMarkWithBlock:^(BOOL isSelected) {
        _isSelect = isSelected;
        if (isSelected) {
            if (_type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot ) {
                if (_password_TextField.text.length > 0 && _smscode_TextField.text.length > 0) {
                    weakSelf.setPassWordButton.backgroundColor = COR29;
                    weakSelf.setPassWordButton.userInteractionEnabled = YES;
                } else {
                    weakSelf.setPassWordButton.backgroundColor = COR12;
                    weakSelf.setPassWordButton.userInteractionEnabled = NO;
                }
            } else {
                if (_password_TextField.text.length > 0 && _smscode_TextField.text.length > 0 && _inviteCodeTextField.text.length > 0) {
                    weakSelf.setPassWordButton.backgroundColor = COR29;
                    weakSelf.setPassWordButton.userInteractionEnabled = YES;
                } else {
                    weakSelf.setPassWordButton.backgroundColor = COR12;
                    weakSelf.setPassWordButton.userInteractionEnabled = NO;
                }
            }
            weakSelf.setPassWordButton.userInteractionEnabled = YES;
            weakSelf.setPassWordButton.backgroundColor = COR29;
        } else {
            weakSelf.setPassWordButton.userInteractionEnabled = NO;
            weakSelf.setPassWordButton.backgroundColor = kHXBColor_Font0_5;
            [weakSelf.setPassWordButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }
    }];
}

- (void)layoutSubView_sendSmscode {
    kWeakSelf
    [self.phonNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(140));
        make.centerX.equalTo(weakSelf);
    }];
    [self.smscode_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phonNumberLabel.mas_bottom).offset(kScrAdaptationH(10));
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.offset(kScrAdaptationH(60));
    }];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.smscode_TextField);
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.width.equalTo(@(kScrAdaptationW(80)));
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];

    [self.password_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.smscode_TextField.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.offset(kScrAdaptationH(60));
    }];
    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.password_TextField.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.offset(kScrAdaptationH(60));
    }];
}

///设置
- (void)setSubView {
    self.password_TextField.delegate = self;
    self.password_TextField.secureTextEntry = true;
    self.smscode_TextField.delegate = self;
    
    self.phonNumberLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    self.phonNumberLabel.textColor = RGB(51, 51, 51);
    
//    self.smscode_TextField.font = kHXBFont_PINGFANGSC_REGULAR(15);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:kSmscode_ConstLableTitle];
    // 设置字体和设置字体的范围
    self.smscode_TextField.delegate = self;
    self.smscode_TextField.keyboardType = UIKeyboardTypeNumberPad;
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:COR10
                    range:NSMakeRange(0, kSmscode_ConstLableTitle.length)];
    self.smscode_TextField.attributedPlaceholder = attrStr;
    
    
    NSMutableAttributedString *passwordattrStr = [[NSMutableAttributedString alloc] initWithString:kPassword_constLableTitle];
    // 设置字体和设置字体的范围
    [passwordattrStr addAttribute:NSForegroundColorAttributeName
                    value:COR10
                    range:NSMakeRange(0, kPassword_constLableTitle.length)];
    self.password_TextField.attributedPlaceholder = passwordattrStr;
    
    self.sendButton.backgroundColor = RGB(222, 222, 222);
    self.sendButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.layer.cornerRadius = kScrAdaptationW(4);
    self.sendButton.layer.masksToBounds = YES;

    self.setPassWordButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
    [self.setPassWordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setPassWordButton.backgroundColor = COR12;
    self.setPassWordButton.userInteractionEnabled = NO;
    self.setPassWordButton.layer.cornerRadius = kScrAdaptationW(4);
    self.setPassWordButton.layer.masksToBounds = YES;
}


///事件
- (void) addButtonTarget {
    [self.sendButton addTarget:self action:@selector(clickSendButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.eyeButton addTarget:self action:@selector(clickEyeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.setPassWordButton addTarget:self action:@selector(clickSetPassWordButton:) forControlEvents:UIControlEventTouchUpInside];
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
            if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
                //合格 请求数据
                if (self.clickSetPassWordButtonBlock) {
                    self.clickSetPassWordButtonBlock(self.password_TextField.text,self.smscode_TextField.text,self.inviteCodeTextField.text);
                }
            } else {
                if (self.inviteCodeTextField.text.length == 0) {
                    [HxbHUDProgress showTextWithMessage:@"请输入邀请码"];
                } else {
                    //合格 请求数据
                    if (self.clickSetPassWordButtonBlock)
                        self.clickSetPassWordButtonBlock(self.password_TextField.text,self.smscode_TextField.text,self.inviteCodeTextField.text);
                }
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
//        [self.sendButton setBackgroundColor:RGB(245, 81, 81)];
        [self.sendButton setBackgroundColor:[UIColor whiteColor]];
        [self.sendButton setTitleColor:COR29 forState:(UIControlStateNormal)];
        self.sendButton.layer.borderWidth = kXYBorderWidth;
        self.sendButton.layer.borderColor = COR29.CGColor;
        [self deleteTimer];
        self.timeNumber = self.totalTimeNumber;
        self.sendButton.userInteractionEnabled = true;
    } else {
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.sendButton.layer.borderWidth = 0;
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
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
    } else {
        if (kScreenWidth == 320 ) {
            [UIView animateWithDuration:0.4 animations:^{
                self.y = -75;
            }];
        } else {
            if (textField.superview == _inviteCodeTextField) {
                [UIView animateWithDuration:0.4 animations:^{
                    self.y = -45;
                }];
            }
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (kScreenWidth == 320) {
        [UIView animateWithDuration:0.4 animations:^{
            self.y = 0;
        }];
    } else {
        if (textField.superview == _inviteCodeTextField) {
            [UIView animateWithDuration:0.4 animations:^{
                self.y = 0;
            }];
        }
    }
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

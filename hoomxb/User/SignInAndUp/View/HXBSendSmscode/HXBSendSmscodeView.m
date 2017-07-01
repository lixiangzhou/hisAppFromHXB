//
//  HXBSendSmscodeView.m
//  hoomxb
//
//  Created by HXB on 2017/6/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSendSmscodeView.h"

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
@property (nonatomic, strong) UILabel       *smscode_constLabel;
///发送按钮
@property (nonatomic, strong) UIButton      *sendButton;
///定时器
@property (nonatomic, strong) NSTimer       *timer;
///密码输入框
@property (nonatomic, strong) UITextField   *password_TextField;
///输入密码说明
@property (nonatomic, strong) UILabel       *password_constLable;
///眼睛按钮
@property (nonatomic, strong) UIButton      *eyeButton;
///确认设置密码按钮
@property (nonatomic, strong) UIButton      *setPassWordButton;

/**
 邀请码const
 */
@property (nonatomic,strong) UILabel *inviteCodeLabel_const;
/**
 邀请码
 */
@property (nonatomic,strong) UITextField *inviteCodeTextField;
/**
 用户协议
 */
@property (nonatomic,strong) UIButton *negotiateButton;
/// 密码是否合格 （字符，数字不能有特殊字符）
@property (nonatomic, assign) BOOL isPasswordQualified;
///点击了确认
@property (nonatomic, copy) void(^clickSetPassWordButtonBlock)(NSString *password, NSString *smscode,NSString *inviteCode);
///点击了发送短信验证码按钮
@property (nonatomic, copy) void(^clickSendSmscodeButtonBlock)();
@end

@implementation HXBSendSmscodeView
- (void)setType:(HXBSignUPAndLoginRequest_sendSmscodeType)type {
    _type = type;
    switch (type) {
        case HXBSignUPAndLoginRequest_sendSmscodeType_forgot:
            [self.inviteCodeTextField setHidden:true];
            [self.inviteCodeLabel_const setHidden:true];
            [self.negotiateButton setHidden:true];
            break;
            
        default:
            break;
    }
}
- (void)setPhonNumber:(NSString *)phonNumber {
    _phonNumber = phonNumber;
    self.phonNumberLabel.text = phonNumber;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    self.smscode_TextField = [[UITextField alloc]init];
    self.smscode_constLabel = [[UILabel alloc]init];
    self.sendButton = [[UIButton alloc]init];
    self.password_TextField = [[UITextField alloc]init];
    self.password_constLable = [[UILabel alloc]init];
    self.eyeButton = [[UIButton alloc]init];
    self.setPassWordButton = [[UIButton alloc]init];
    self.inviteCodeLabel_const = [[UILabel alloc]init];
    self.inviteCodeTextField = [[UITextField alloc]init];
    self.negotiateButton = [[UIButton alloc]init];
    
    [self addSubview : self.phonNumberLabel];
    [self addSubview : self.smscode_TextField];
    [self addSubview : self.smscode_constLabel];
    [self addSubview : self.sendButton];
    [self addSubview : self.password_TextField];
    [self addSubview : self.password_constLable];
    [self addSubview : self.eyeButton];
    [self addSubview : self.setPassWordButton];
    [self addSubview:self.inviteCodeLabel_const];
    [self addSubview:self.inviteCodeTextField];
    [self addSubview:self.negotiateButton];
    
    
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    NSString *str = [NSString hiddenStr:self.phonNumber MidWithFistLenth:3 andLastLenth:4];
    self.phonNumberLabel.text = [NSString stringWithFormat:@"已向手机%@发送短息，请输入验证码完成注册",str];
    self.smscode_constLabel.text = @"验证码";
    self.password_constLable.text = @"登录密码";
    self.password_TextField.placeholder = @"8-20位数组大小写字母组成";
    self.inviteCodeLabel_const.text = @"邀请码";
    self.inviteCodeTextField.placeholder = @"选填";
 
    [self.setPassWordButton setTitle:@"注册并同意用户协议" forState:UIControlStateNormal];
   
    [self.negotiateButton setTitle:@"用户协议" forState:UIControlStateNormal];
    [self.negotiateButton addTarget:self action:@selector(clickNegotiateButton:) forControlEvents:UIControlEventTouchUpInside];
}
//用户协议
- (void)clickNegotiateButton: (UIButton *)button {
    [HxbHUDProgress showTextWithMessage:@"还没接口"];
}
- (void)layoutSubView_sendSmscode {
    kWeakSelf
    [self.phonNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kScrAdaptationH(80));
        make.height.offset(kScrAdaptationH(40));
        make.left.right.equalTo(weakSelf);
    }];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phonNumberLabel.mas_bottom).offset(kScrAdaptationH(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.width.equalTo(@(kScrAdaptationW(40)));
    }];
    [self.smscode_constLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.smscode_TextField);
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.width.offset(kScrAdaptationW(50));
        make.height.equalTo(weakSelf.smscode_TextField);
    }];
    [self.smscode_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.sendButton.mas_left).offset(kScrAdaptationW(-10));
        make.centerY.height.equalTo(weakSelf.sendButton);
        make.left.equalTo(weakSelf.smscode_constLabel.mas_right).offset(kScrAdaptationW(10));
    }];
    
    [self.password_constLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.smscode_TextField.mas_bottom).offset(kScrAdaptationH(20));
        make.height.left.equalTo(weakSelf.smscode_constLabel);
        make.width.offset(kScrAdaptationW(50));
    }];
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.password_constLable);
        make.right.equalTo(weakSelf.sendButton);
        make.width.height.offset(kScrAdaptationW(10));
    }];
    [self.password_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(weakSelf.password_constLable);
        make.left.equalTo(weakSelf.password_constLable.mas_right);
        make.right.equalTo(weakSelf.eyeButton).offset(kScrAdaptationW(-10));
    }];
    [self.inviteCodeLabel_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.password_constLable.mas_bottom).offset(kScrAdaptationH(10));
        make.left.equalTo(weakSelf.password_constLable);
        make.height.equalTo(weakSelf.password_constLable);
    }];
    [self.inviteCodeLabel_const sizeToFit];
    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf.inviteCodeLabel_const);
        make.left.equalTo(weakSelf.inviteCodeLabel_const.mas_right).offset(kScrAdaptationW(0));
        make.right.equalTo(weakSelf);
    }];
    [self.setPassWordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(kScrAdaptationH(-50));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.offset(kScrAdaptationH(40));
    }];
    [self.negotiateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.setPassWordButton.mas_bottom).offset(kScrAdaptationH(6));
        make.height.left.right.equalTo(weakSelf.setPassWordButton);
    }];
    self.phonNumberLabel.backgroundColor = [UIColor hxb_randomColor];
    self.smscode_TextField.backgroundColor = [UIColor hxb_randomColor];
    self.smscode_constLabel.backgroundColor = [UIColor hxb_randomColor];
    self.sendButton.backgroundColor = [UIColor hxb_randomColor];
    self.password_TextField.backgroundColor = [UIColor hxb_randomColor];
    self.password_constLable.backgroundColor = [UIColor hxb_randomColor];
    self.eyeButton.backgroundColor = [UIColor hxb_randomColor];
    self.setPassWordButton.backgroundColor = [UIColor hxb_randomColor];
    self.negotiateButton.backgroundColor = [UIColor hxb_randomColor];
}

///设置
- (void)setSubView {
    self.password_TextField.delegate = self;
    self.password_TextField.secureTextEntry = true;
    self.smscode_TextField.delegate = self;
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
    if (self.clickSendSmscodeButtonBlock) self.clickSendSmscodeButtonBlock();
    
}

- (void) setSendButtonStatus {
    self.sendButton.userInteractionEnabled = false;
    [self.timer fire];
}

///点击了确定设置按钮
- (void)clickSetPassWordButton: (UIButton *)button {
    if([self isPasswordQualifiedFunWithStr:self.password_TextField.text]) {
        //合格 请求数据
        if (self.clickSetPassWordButtonBlock) self.clickSetPassWordButtonBlock(self.password_TextField.text,self.smscode_TextField.text,nil);
    }else {
        NSLog(@"🌶密码不合格");
        [HxbHUDProgress showTextWithMessage:@"🌶密码不合格"];
    }
}

- (void)addTime {
    self.timeNumber --;
    [self.sendButton setTitle:@(self.timeNumber).description forState:UIControlStateNormal];
    if (self.timeNumber <= 0) {
        [self.sendButton setTitle:kSendSmscodeAgainTitle forState:UIControlStateNormal];
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
    return true;
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
@end

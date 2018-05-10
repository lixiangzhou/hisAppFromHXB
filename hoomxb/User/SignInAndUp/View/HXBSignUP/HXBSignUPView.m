//
//  HXBSignUPView.m
//  hoomxb
//
//  Created by HXB on 2017/6/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPView.h"
#import "HxbSignUpViewController.h"
#import "SVGKit/SVGKImage.h"
#import "HXBSignInWaterView.h"//波浪式图
static NSString *const kNextButtonTitle = @"下一步";
static NSString *const kHavedAccountTitle = @"我有账户，去登录";
static NSString *const kPhoneTitle = @"请输入您登录的手机号";
@interface HXBSignUPView()  <
UITextFieldDelegate
>
///已有账户的button
@property (nonatomic, strong) UIButton *havedAccountButton;
///手机号
@property (nonatomic, strong) HXBCustomTextField *phoneTextField;
@property (nonatomic, strong) UILabel *checkMobileLabel;
///下一步button
@property (nonatomic, strong) UIButton *nextButton;
///点击了下一步的button
@property (nonatomic, copy) void(^clickNextButtonBlock)(NSString *mobile);
///请求 手机好校验
@property (nonatomic, copy) void(^checkMobileBlock)(NSString *mobile);
///点击了已有账号，去登陆按钮
@property (nonatomic, copy) void(^clickHaveAccountButtonBlock)();
///波浪视图
@property (nonatomic, strong) HXBSignInWaterView *waterView;
/**
 判断输入是否应该去请求防止412
 */
@property (nonatomic, copy) NSString *phoneText;
@end

@implementation HXBSignUPView

#pragma mark - setter 

- (void)setCheckMobileStr:(NSString *)checkMobileStr {
    _checkMobileStr = checkMobileStr;
    self.checkMobileLabel.text = checkMobileStr;
}


- (void)signUpClick
{
    
}

#pragma mark - getter 


- (HXBCustomTextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[HXBCustomTextField alloc]init];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.delegate = self;
        _phoneTextField.leftImage = [UIImage imageNamed:@"mobile_number"];
        NSMutableAttributedString *phoneAttrStr = [[NSMutableAttributedString alloc] initWithString:kPhoneTitle];
        [phoneAttrStr addAttribute:NSForegroundColorAttributeName
                             value:COR10
                             range:NSMakeRange(0, kPhoneTitle.length)];
        _phoneTextField.attributedPlaceholder = phoneAttrStr;
    }
    return _phoneTextField;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc]init];
        [_nextButton setTitle:kNextButtonTitle forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(clickNextButton:) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.layer.cornerRadius = kScrAdaptationW(4);
        _nextButton.layer.masksToBounds = YES;
        _nextButton.backgroundColor = COR26;
        _nextButton.userInteractionEnabled = NO;
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
    }
    return _nextButton;
}


- (UIButton *)havedAccountButton {
    if (!_havedAccountButton) {
        _havedAccountButton = [[UIButton alloc]init];
        [_havedAccountButton setTitle:kHavedAccountTitle forState:UIControlStateNormal];
        [_havedAccountButton setTitleColor:COR10 forState:UIControlStateNormal];
        [_havedAccountButton addTarget:self action:@selector(clickHavedAccountButton:) forControlEvents:UIControlEventTouchUpInside];
        _havedAccountButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    }
    return _havedAccountButton;
}
- (UILabel *)checkMobileLabel {
    if (!_checkMobileLabel) {
        _checkMobileLabel = [[UILabel alloc]init];
        _checkMobileLabel.textColor = [UIColor blueColor];
    }
    return _checkMobileLabel;
}

- (HXBSignInWaterView *)waterView
{
    if (!_waterView) {
        _waterView = [[HXBSignInWaterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH(111))];
    }
    return _waterView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUP];
    }
    return self;
}

- (void)setUP {
    [self addSubview:self.phoneTextField];
    [self addSubview:self.nextButton];
    [self addSubview:self.havedAccountButton];
    [self addSubview:self.checkMobileLabel];
    [self addSubview:self.waterView];
    kWeakSelf
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.waterView.mas_bottom).offset(kScrAdaptationH(50));
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.offset(kScrAdaptationH(60));
    }];
    _phoneTextField.limitStringLength = 11;
    _phoneTextField.block = ^(NSString *text) {
        if (text.length == 11) {
            if (weakSelf.checkMobileBlock) {
                //判断是否为手机号，不是不让图验
                if (![weakSelf.phoneText isEqualToString:text]) {
                    weakSelf.checkMobileBlock(text);
                }
            }
        }
        if (text.length > 0) {
            weakSelf.nextButton.backgroundColor = COR29;
            weakSelf.nextButton.userInteractionEnabled = YES;
        } else {
            weakSelf.nextButton.backgroundColor = COR26;
            weakSelf.nextButton.userInteractionEnabled = NO;
        }
        weakSelf.phoneText = text;
    };
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneTextField.mas_bottom).offset(kScrAdaptationH(50));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.offset(kScrAdaptationH(41));
    }];
    [self.havedAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nextButton.mas_bottom).offset(kScrAdaptationH(10));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.offset(kScrAdaptationW(15));
    }];

    self.checkMobileLabel.backgroundColor = [UIColor hxb_randomColor];
}

///点击了nextButton
- (void)clickNextButton:(UIButton *)sender{
    if (self.clickNextButtonBlock) self.clickNextButtonBlock(self.phoneTextField.text);
}
///点击了已有账号登录按钮
- (void)clickHavedAccountButton: (UIButton *)button {
    if (self.clickHaveAccountButtonBlock) {
        self.clickHaveAccountButtonBlock();
    }
}

- (void)setIsHiddenLoginBtn:(BOOL)isHiddenLoginBtn {
    _isHiddenLoginBtn = isHiddenLoginBtn;
    self.havedAccountButton.hidden = isHiddenLoginBtn;
}

//事件的传递
- (void)signUPClickNextButtonFunc:(void (^)(NSString *mobile))clickNextButtonBlock {
    self.clickNextButtonBlock = clickNextButtonBlock;
}
//手机号校验
- (void)checkMobileWithBlockFunc:(void (^)(NSString *mobile))checkMobileBlock {
    self.checkMobileBlock = checkMobileBlock;
}
///点击了已有账号按钮
- (void)clickHaveAccountButtonFunc:(void (^)())clickHaveAccountButtonBlock {
    self.clickHaveAccountButtonBlock = clickHaveAccountButtonBlock;
}
@end

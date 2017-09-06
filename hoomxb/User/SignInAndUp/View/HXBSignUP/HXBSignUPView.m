//
//  HXBSignUPView.m
//  hoomxb
//
//  Created by HXB on 2017/6/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBSignUPView.h"
#import "HxbSignUpViewController.h"
#import "SVGKImage.h"
#import "HXBSignInWaterView.h"//波浪式图
static NSString *const kNextButtonTitle = @"下一步";
static NSString *const kHavedAccountTitle = @"已有账户，去登录";
static NSString *const kPhoneTitle = @"手机号";
@interface HXBSignUPView()  <
UITextFieldDelegate
>
///已有账户的button
@property (nonatomic, strong) UIButton *havedAccountButton;
///手机号
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UILabel *checkMobileLabel;
///手机号
//@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIImageView *phoneImageView;
/**
 手机号分割线
 */
@property (nonatomic, strong) UIView *phoneLine;
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

- (UIView *)phoneLine
{
    if (!_phoneLine) {
        _phoneLine = [[UIView alloc] init];
        _phoneLine.backgroundColor = RGB(221, 221, 221);
    }
    return _phoneLine;
}
- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.delegate = self;
        _phoneTextField.font = kHXBFont_PINGFANGSC_REGULAR(15);
        NSMutableAttributedString *phoneAttrStr = [[NSMutableAttributedString alloc] initWithString:kPhoneTitle];
        // 设置字体和设置字体的范围
        [phoneAttrStr addAttribute:NSForegroundColorAttributeName
                             value:COR10
                             range:NSMakeRange(0, kPhoneTitle.length)];
        _phoneTextField.attributedPlaceholder = phoneAttrStr;
    }
    return _phoneTextField;
}
//- (UILabel *)phoneLabel {
//    if (!_phoneLabel) {
//        _phoneLabel = [[UILabel alloc]init];
//        _phoneLabel.textColor = COR1;
//        _phoneLabel.text = kPhoneTitle;
//    }
//    return _phoneLabel;
//}
- (UIImageView *)phoneImageView
{
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_number"]];
        _phoneImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _phoneImageView;
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

- (void) setUP {
    [self addSubview:self.phoneImageView];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.nextButton];
    [self addSubview:self.havedAccountButton];
    [self addSubview:self.checkMobileLabel];
    [self addSubview:self.phoneLine];
    [self addSubview:self.waterView];
    kWeakSelf
    [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.waterView.mas_bottom).offset(kScrAdaptationH(50));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.width.offset(kScrAdaptationW750(36));
        make.height.offset(kScrAdaptationH750(45));
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.phoneImageView);
        make.left.equalTo(weakSelf.phoneImageView.mas_right).offset(kScrAdaptationW(15));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
    }];
    [self.phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneImageView.mas_bottom).offset(kScrAdaptationH(15));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.offset(0.5);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneLine.mas_top).offset(kScrAdaptationH(50));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.offset(kScrAdaptationH(41));
    }];
//    [self.checkMobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.phoneTextField.mas_bottom).offset(kScrAdaptationH(10));
//        make.height.offset(kScrAdaptationH(20));
//        make.left.right.equalTo(weakSelf.phoneTextField);
//    }];
    [self.havedAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nextButton.mas_bottom).offset(kScrAdaptationH(10));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.offset(kScrAdaptationW(15));
    }];


//    self.phoneTextField.backgrqoundColor = [UIColor hxb_randomColor];
//    self.havedAccountButton.backgroundColor = [UIColor hxb_randomColor];
//    self.nextButton.backgroundColor = [UIColor hxb_randomColor];
    self.checkMobileLabel.backgroundColor = [UIColor hxb_randomColor];
}

#pragma mark - textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![self.phoneTextField isEqual:textField]) return true;
    
    //删除按钮
    self.phoneTextField.clearButtonMode = textField.text.length > 0? UITextFieldViewModeAlways : UITextFieldViewModeNever;
   
    //如果到达11 个字符就请求数据
    NSString *str = nil;
    if (string.length) {
        str = [NSString stringWithFormat:@"%@%@",self.phoneTextField.text,string];
    }else {
        NSInteger length = self.phoneTextField.text.length;
        NSRange range = NSMakeRange(length - 1, 1);
        NSMutableString *strM = self.phoneTextField.text.mutableCopy;
        [strM deleteCharactersInRange:range];
        str = strM.copy;
    }
    
    if (str.length == 11) {
        if (self.checkMobileBlock) {
            //判断是否为手机号，不是不让图验
            if (![NSString isMobileNumber:str]) {
                [HxbHUDProgress showMessageCenter:@"手机号不正确" inView:self];
                return YES;
            }
            self.checkMobileBlock(str);
        }
    }
    if (str.length != 11) {
        self.checkMobileLabel.text = @"";
    }
    UITextFieldViewMode model = str.length > 0? UITextFieldViewModeAlways : UITextFieldViewModeNever;
    self.phoneTextField.clearButtonMode = model;
    
    if (str.length) {
        self.nextButton.backgroundColor = COR29;
        self.nextButton.userInteractionEnabled = YES;
    }else
    {
        self.nextButton.backgroundColor = COR26;
        self.nextButton.userInteractionEnabled = NO;
    }
    
    return str.length <= 11;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField == _phoneTextField) {
        self.nextButton.backgroundColor = COR26;
        self.nextButton.userInteractionEnabled = NO;
    }
    return YES;
}


- (void)textFieldDidChange1:(UITextField *)textField{
   
}

///点击了nextButton
- (void)clickNextButton:(UIButton *)sender{
    //判断是否为手机号，不是不让图验
    if (![NSString isMobileNumber:self.phoneTextField.text]) {
        [HxbHUDProgress showMessageCenter:@"手机号格式不正确" inView:self];
        return;
    }
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
    if (_isHiddenLoginBtn) {
        self.havedAccountButton.hidden = YES;
    } else {
        self.havedAccountButton.hidden = NO;
    }
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

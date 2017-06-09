//
//  HXBBasePasswordView.m
//  hoomxb
//
//  Created by HXB on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBasePasswordView.h"
@interface HXBBasePasswordView () <UITextFieldDelegate>
///密码输入框
@property (nonatomic, strong) UITextField *password_TextField;
///输入密码说明
@property (nonatomic, strong) UILabel *password_constLable;
///眼睛按钮
@property (nonatomic, strong) UIButton *eyeButton;
/// 用户输入的密码
@property (nonatomic, strong) NSMutableString *passwordStr;
/// 隐藏的密码的string
@property (nonatomic, strong) NSMutableAttributedString *hiddenPasswordStr;
/// 密码是否合格 （字符，数字不能有特殊字符）
@property (nonatomic, assign) BOOL isPasswordQualified;
@property (nonatomic, copy) void(^layoutSubViewBlock)(UILabel *password_constLable,UITextField *password_TextField , UIButton *eyeButton);
@property (nonatomic, assign) UIEdgeInsets password_constLableEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets password_TextFieldEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets eyeButtonEdgeInsets;
@property (nonatomic, assign) NSInteger password_constW;
@property (nonatomic, assign) NSInteger eyeButtonW;
@end


@implementation HXBBasePasswordView

- (instancetype)initWithFrame:(CGRect)frame layoutSubView_WithPassword_constLableEdgeInsets: (UIEdgeInsets)password_constLableEdgeInsets andPassword_TextFieldEdgeInsets: (UIEdgeInsets)Password_TextFieldEdgeInsets andEyeButtonEdgeInsets: (UIEdgeInsets)eyeButtonEdgeInsets andPassword_constW: (NSInteger)password_constW andEyeButtonW: (NSInteger)eyeButtonW
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
        [self setSubView];
        [self addButtonTarget];
        self.password_constLableEdgeInsets = password_constLableEdgeInsets;
        self.password_TextFieldEdgeInsets = password_constLableEdgeInsets;
        self.eyeButtonEdgeInsets = eyeButtonEdgeInsets;
        self.password_constW = password_constW;
        self.eyeButtonW = eyeButtonW;
        self.password_TextField.secureTextEntry = true;
        [self show];
    }
    return self;
}

- (void) show {
    if (self.layoutSubViewBlock) {
        self.layoutSubViewBlock(self.password_constLable, self.password_TextField, self.eyeButton);
    }else {
        [self hxb_layoutSubView];
    }
}

- (void)setHiddenPasswordImage:(UIImage *)hiddenPasswordImage {
    _hiddenPasswordImage = hiddenPasswordImage;
    _eyeButton.imageView.image = hiddenPasswordImage;
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.password_TextField.placeholder = placeholder;
}
- (void)setPasswordConstTitle:(NSString *)passwordConstTitle {
    _passwordConstTitle = passwordConstTitle;
    self.password_constLable.text = passwordConstTitle;
}
- (NSString *)passwordString {
    if (self.hiddenImage) {
        return self.passwordStr;
    }
    return self.password_TextField.text;
}
///创建对象
- (void)creatSubView {
    self.hiddenPasswordStr = [[NSMutableAttributedString alloc]init];
    self.passwordStr = [[NSMutableString alloc]init];

    self.password_TextField = [[UITextField alloc]init];
    self.password_constLable = [[UILabel alloc]init];
    self.eyeButton = [[UIButton alloc]init];

    [self addSubview : self.password_TextField];
    [self addSubview : self.password_constLable];
    [self addSubview : self.eyeButton];
}

///布局
- (void)hxb_layoutSubView {
    kWeakSelf
    
    [self.password_constLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(kScrAdaptationH(weakSelf.password_constLableEdgeInsets.bottom));
        make.top.equalTo(weakSelf).offset(kScrAdaptationH(weakSelf.password_constLableEdgeInsets.top));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(weakSelf.password_constLableEdgeInsets.left));
        make.width.equalTo(@(kScrAdaptationW(weakSelf.password_constW)));
    }];
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.password_constLable);
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(0));
        make.width.height.offset(kScrAdaptationW(weakSelf.eyeButtonW));
    }];
    [self.password_TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.password_constLable.mas_right);
        make.top.equalTo(weakSelf).offset(kScrAdaptationH(0));
        make.bottom.equalTo(weakSelf).offset(kScrAdaptationH(0));
        make.right.equalTo(weakSelf.eyeButton.mas_left).offset(kScrAdaptationW(0));
    }];
    
    self.password_TextField.backgroundColor = [UIColor hxb_randomColor];
    self.password_constLable.backgroundColor = [UIColor hxb_randomColor];
    self.eyeButton.backgroundColor = [UIColor hxb_randomColor];
}
///设置
- (void)setSubView {
    self.password_TextField.delegate = self;
}


///事件
- (void) addButtonTarget {
    [self.eyeButton addTarget:self action:@selector(clickEyeButton:) forControlEvents:UIControlEventTouchUpInside];
}

///点击了眼睛的按钮
- (void)clickEyeButton: (UIButton *)button {
    self.eyeButton.selected = !self.eyeButton.selected;
    
    if(!self.hiddenImage) {
        self.password_TextField.secureTextEntry = !self.eyeButton.selected;
        return;
    }
    
    if (self.eyeButton.selected) {
        self.password_TextField.text = self.passwordStr;
    }else {
        self.password_TextField.attributedText = self.hiddenPasswordStr;
    }
}

#pragma mark - textField delegate
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return false;
    }
    if (![textField isEqual: self.password_TextField]) {
        return true;
    }
    if (!self.hiddenImage) return true;
    if (!string.length){//删除字符
        NSRange range = NSMakeRange(self.passwordStr.length - 1, 1);
        [self.passwordStr deleteCharactersInRange: range];
        [self.hiddenPasswordStr deleteCharactersInRange:range];
        return true;
    }
    [self.passwordStr appendString:string];
    //添加图片
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = self.hiddenImage;
    NSAttributedString *picAttr = [NSAttributedString attributedStringWithAttachment:attach];
    [self.hiddenPasswordStr appendAttributedString:picAttr];
    
    //显示 字符
    if (self.eyeButton.selected) {
        self.password_TextField.text = self.passwordStr;
    }else {
        self.password_TextField.attributedText = self.hiddenPasswordStr;
    }
    return false;
}
///6-20位数字和字母组成 密码
+ (BOOL)isPasswordQualifiedFunWithStr: (NSString *)password {
    return [self checkPassWordWithString:password];
}
///6-20位数字和字母组成 密码
+ (BOOL)checkPassWordWithString: (NSString *)str
{
    if ([NSString isIncludeSpecialCharact:str]) return NO;
    
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:str]) {
        return YES ;
    }else{
        return NO;
    }
}

@end

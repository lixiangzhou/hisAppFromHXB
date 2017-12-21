//
//  HBAlertPasswordView.m
//  TestPassward
//
//  Created by JING XU on 17/5/21.
//  Copyright © 2017年 HB. All rights reserved.
//

#import "HBAlertPasswordView.h"

@interface HBAlertPasswordView ()
<UITextFieldDelegate>

/** 密码的TextField */
@property (nonatomic, strong) UITextField *passwordTextField;
/** 黑点的个数 */
@property (nonatomic, strong) NSMutableArray *pointArr;
/** 输入安全密码的背景View */
//@property (nonatomic, strong) UIView *BGView;

@end

// 密码点的大小
#define kPointSize CGSizeMake(kScrAdaptationW750(22), kScrAdaptationW750(22))
// 密码个数
#define kPasswordCount 6
// 每一个密码框的高度
#define kBorderHeight self.height
// 每一个密码框的高度
#define kBorderWidth (self.width / kPasswordCount)

#define kBorderColor COR12

// 宏定义屏幕的宽和高
//#define HB_ScreenW [UIScreen mainScreen].bounds.size.width
//#define HB_ScreenH [UIScreen mainScreen].bounds.size.height

@implementation HBAlertPasswordView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 背景颜色
        self.backgroundColor = [UIColor clearColor];
        // 密码框
        UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0 , kPasswordCount * kBorderWidth, self.height)];
        passwordTextField.backgroundColor = [UIColor whiteColor];
        // 输入的文字颜色为白色
        passwordTextField.textColor = [UIColor clearColor];
        // 输入框光标的颜色为白色
        passwordTextField.tintColor = [UIColor whiteColor];
        passwordTextField.delegate = self;
        passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        passwordTextField.layer.borderColor = kBorderColor.CGColor;
        passwordTextField.layer.borderWidth = kXYBorderWidth;
        passwordTextField.layer.cornerRadius = kScrAdaptationW750(8);
        passwordTextField.layer.masksToBounds = YES;
        [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:passwordTextField];
        // 页面出现时弹出键盘
        [passwordTextField becomeFirstResponder];
        self.passwordTextField = passwordTextField;
        
        // 生产分割线
        for (NSInteger i = 0; i < kPasswordCount - 1; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(passwordTextField.frame) + (i + 1) * kBorderWidth, CGRectGetMinY(passwordTextField.frame), 1, kBorderHeight)];
            lineView.backgroundColor = kBorderColor;
            [self addSubview:lineView];
        }
        
        self.pointArr = [NSMutableArray array];
        
        // 生成中间的点
        for (NSInteger i = 0; i < kPasswordCount; i++) {
            UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(passwordTextField.frame) + (kBorderWidth - kPointSize.width) / 2 + i * kBorderWidth, CGRectGetMinY(passwordTextField.frame) + (kBorderHeight - kPointSize.height) / 2, kPointSize.width, kPointSize.height)];
            pointView.backgroundColor = COR6;
            pointView.layer.cornerRadius = kPointSize.width / 2;
            pointView.layer.masksToBounds = YES;
            // 先隐藏
            pointView.hidden = YES;
            [self addSubview:pointView];
            // 把创建的黑点加入到数组中
            [self.pointArr addObject:pointView];
        }
        
        // 监听键盘的高度
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"变化%@", string);
    if ([string isEqualToString:@"\n"]) {
        // 按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        // 判断是不是删除键
        return YES;
    } else if (textField.text.length >= kPasswordCount) {
        // 输入的字符个数大于6
//        NSLog(@"输入的字符个数大于6,忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 清除密码(old)
 */
- (void)clearUpPassword {
    
    self.passwordTextField.text = @"";
    [self textFieldDidChange:self.passwordTextField];
}

/**
 清除密码(new)
 */
- (void)setIsCleanPassword:(BOOL)isCleanPassword {
    _isCleanPassword = isCleanPassword;
    if (isCleanPassword) {
        self.passwordTextField.text = @"";
        [self textFieldDidChange:self.passwordTextField];
    }
}

/**
 重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField {
//    NSLog(@"%@", textField.text);
    for (UIView *pointView in self.pointArr) {
        pointView.hidden = YES;
    }
    for (NSInteger i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.pointArr objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kPasswordCount) {
        NSLog(@"输入完毕,密码为%@", textField.text);
    }
    if ([self.delegate respondsToSelector:@selector(sureActionWithAlertPasswordView:password:)]) {
        [self.delegate sureActionWithAlertPasswordView:self password:self.passwordTextField.text];
    }
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self endEditing:YES];
}

#pragma mark - 按钮的执行方法
// 取消按钮
- (void)cancelButtonAction {
    
    [self removeFromSuperview];
}

// 确定按钮
- (void)sureButtonAction {
    
    if ([self.delegate respondsToSelector:@selector(sureActionWithAlertPasswordView:password:)]) {
        [self.delegate sureActionWithAlertPasswordView:self password:self.passwordTextField.text];
    }
}

#pragma mark - 键盘的出现和收回的监听方法
- (void)keyboardWillShow:(NSNotification *)notification {
    if (self.keyboardWillShowBlock) {
        self.keyboardWillShowBlock(notification);
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if (self.keyboardWillHideBlock) {
        self.keyboardWillHideBlock(notification);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

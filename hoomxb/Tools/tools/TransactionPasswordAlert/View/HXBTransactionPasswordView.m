//
//  HXBTransactionPasswordView.m
//  测试
//
//  Created by HXB-C on 2017/12/19.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

// 密码点的大小
#define kPointSize CGSizeMake(kScrAdaptationW750(22), kScrAdaptationW750(22))
// 密码个数
#define kPasswordCount 6
// 每一个密码框的高度
#define kBorderHeight self.passwordView.height
// 每一个密码框的高度
#define kBorderWidth (self.passwordView.width / kPasswordCount)

#define kBorderColor COR12

#define kHXBCloseBtnWith kScrAdaptationW750(100)

#import "HXBTransactionPasswordView.h"
#import "HBAlertPasswordView.h"
#import "HXBRootVCManager.h"
#import "IQKeyboardManager.h"
#import "HXBModifyTransactionPasswordViewController.h"

@interface HXBTransactionPasswordView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIButton *forgetButton;

@property (nonatomic, strong) UILabel *tileLabel;

@property (nonatomic, strong) UIView *segmentingLine;

@property (nonatomic, strong) UIView *passwordView;

@property (nonatomic, strong) UIView *contentView;

/** 黑点的个数 */
@property (nonatomic, strong) NSMutableArray *pointArr;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *backgroundButton;

@end

@implementation HXBTransactionPasswordView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        [self setupTextfile];
        [self setUI];
    }
    return self;
}


#pragma mark - UI

- (void)setUI {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self addSubview:self.backgroundButton];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.closeButton];
    [self.contentView addSubview:self.tileLabel];
    [self.contentView addSubview:self.segmentingLine];
    [self.contentView addSubview:self.passwordView];
    [self.contentView addSubview:self.forgetButton];
    
    [self.backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.contentView.mas_top);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH750(388));
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.segmentingLine.mas_top);
        make.width.offset(kHXBCloseBtnWith);
    }];
    [self.tileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.segmentingLine.mas_top);
    }];
    [self.segmentingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kScrAdaptationH750(114));
        make.height.offset(kHXBDivisionLineHeight);
        make.left.right.equalTo(self.contentView);
    }];
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom).offset(kScrAdaptationH750(30));
        make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-38));
    }];
}

- (void)setupTextfile {
    // 背景颜色
    self.backgroundColor = [UIColor clearColor];
    // 密码框
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0 , kPasswordCount * kBorderWidth, kScrAdaptationH750(100))];
    passwordTextField.hidden = YES;
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    //设置密码输入框
    self.passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, kScrAdaptationH750(165), kScrAdaptationW750(650), kScrAdaptationH750(100))];
    self.passwordView.centerX = self.contentView.centerX;
    self.passwordView.layer.borderColor = kBorderColor.CGColor;
    self.passwordView.layer.borderWidth = kXYBorderWidth;
    self.passwordView.layer.cornerRadius = kScrAdaptationW750(8);
    self.passwordView.layer.masksToBounds = YES;
    
    // 生产分割线
    for (NSInteger i = 0; i < kPasswordCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * kBorderWidth, 0, 1, kBorderHeight)];
        lineView.backgroundColor = kBorderColor;
        [self.passwordView addSubview:lineView];
    }
    
    // 生成中间的点
    self.pointArr = [NSMutableArray array];
    for (NSInteger i = 0; i < kPasswordCount; i++) {
        UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake((kBorderWidth - kPointSize.width) / 2 + i * kBorderWidth, (kBorderHeight - kPointSize.height) / 2, kPointSize.width, kPointSize.height)];
        pointView.backgroundColor = COR6;
        pointView.layer.cornerRadius = kPointSize.width / 2;
        pointView.layer.masksToBounds = YES;
        // 先隐藏
        pointView.hidden = YES;
        [self.passwordView addSubview:pointView];
        // 把创建的黑点加入到数组中
        [self.pointArr addObject:pointView];
    }
    
    // 监听键盘的高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Action
- (void)closePasswordView {
    [self endEditing:YES];
}

- (void)forgetPassword {
    [self closePasswordView];
    HXBModifyTransactionPasswordViewController *modifyTransactionPasswordVC = [[HXBModifyTransactionPasswordViewController alloc] init];
    modifyTransactionPasswordVC.title = @"修改交易密码";
    [[HXBRootVCManager manager].topVC.navigationController pushViewController:modifyTransactionPasswordVC animated:YES];
}

- (void)showInView:(UIView *)view {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].enable = NO;
    [view addSubview:self];
    [self.passwordTextField becomeFirstResponder];
}

/**
 清除密码(old)
 */
- (void)clearUpPassword {
    self.passwordTextField.text = @"";
    [self textFieldDidChange:self.passwordTextField];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
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
 重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField {
    for (UIView *pointView in self.pointArr) {
        pointView.hidden = YES;
    }
    for (NSInteger i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.pointArr objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kPasswordCount) {
        NSLog(@"输入完毕,密码为%@", textField.text);
        if (self.getTransactionPasswordBlock) {
            self.getTransactionPasswordBlock(textField.text);
        }
    }
}

#pragma mark - Setter / Getter / Lazy


- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton addTarget:self action:@selector(closePasswordView) forControlEvents:(UIControlEventTouchUpInside)];
        [_closeButton setImage:[UIImage imageNamed:@"Alert_Close"] forState:(UIControlStateNormal)];
        _closeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _closeButton.imageEdgeInsets = UIEdgeInsetsMake(0, kScrAdaptationW750(50), 0, kHXBCloseBtnWith-kScrAdaptationW750(80));
    }
    return _closeButton;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [[UIButton alloc] init];
        [_forgetButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        [_forgetButton setTitle:@"忘记密码？" forState:(UIControlStateNormal)];
        [_forgetButton setTitleColor:COR25 forState:(UIControlStateNormal)];
        _forgetButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    }
    return _forgetButton;
}

- (UILabel *)tileLabel {
    if (!_tileLabel) {
        _tileLabel = [[UILabel alloc] init];
        _tileLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(34);
        _tileLabel.textColor = COR6;
        _tileLabel.text = @"请输入您的交易密码";
        _tileLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tileLabel;
}

- (UIView *)segmentingLine {
    if (!_segmentingLine) {
        _segmentingLine = [[UIView alloc] init];
        _segmentingLine.backgroundColor = COR12;
    }
    return _segmentingLine;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrAdaptationH750(388))];
        _contentView.backgroundColor = kHXBColor_BackGround;
    }
    return _contentView;
}


- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.hidden = YES;
        [_passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (UIButton *)backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [[UIButton alloc] init];
        [_backgroundButton addTarget:self action:@selector(closePasswordView) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backgroundButton;
}


#pragma mark - Helper


#pragma mark - 键盘的出现和收回的监听方法
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(kScrAdaptationH750(388) + keyboardRect.size.height);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    // 获取键盘隐藏动画时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.contentView.y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - Public
- (void)dealloc {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enable = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

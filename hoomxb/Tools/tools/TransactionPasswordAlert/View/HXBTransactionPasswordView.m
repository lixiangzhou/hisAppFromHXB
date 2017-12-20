//
//  HXBTransactionPasswordView.m
//  测试
//
//  Created by HXB-C on 2017/12/19.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define kHXBCloseBtnWith kScrAdaptationW750(100)

#import "HXBTransactionPasswordView.h"
#import "HBAlertPasswordView.h"
#import "HXBRootVCManager.h"
#import "IQKeyboardManager.h"
#import "HXBModifyTransactionPasswordViewController.h"

@interface HXBTransactionPasswordView ()<HBAlertPasswordViewDelegate>

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UIButton *forgetButton;

@property (nonatomic, strong) UILabel *tileLabel;

@property (nonatomic, strong) UIView *segmentingLine;

@property (nonatomic, strong) HBAlertPasswordView *passwordViwe;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *backgroundButton;

@end

@implementation HXBTransactionPasswordView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)dealloc {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enable = YES;
}

#pragma mark - UI

- (void)setUI {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self addSubview:self.backgroundButton];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.closeButton];
    [self.contentView addSubview:self.tileLabel];
    [self.contentView addSubview:self.segmentingLine];
    [self.contentView addSubview:self.passwordViwe];
    [self.contentView addSubview:self.forgetButton];
    
    [self.backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
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
        make.top.equalTo(self.passwordViwe.mas_bottom).offset(kScrAdaptationH750(30));
        make.right.equalTo(self.contentView).offset(kScrAdaptationW750(-38));
    }];
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

+ (HXBTransactionPasswordView *)show {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].enable = NO;
    HXBTransactionPasswordView *passwordViwe = [[self alloc] init];
    [[HXBRootVCManager manager].topVC.view addSubview:passwordViwe];
    return passwordViwe;
}

#pragma mark - HBAlertPasswordViewDelegate

- (void)sureActionWithAlertPasswordView:(HBAlertPasswordView *)alertPasswordView password:(NSString *)password {
    if (self.getTransactionPasswordBlock) {
        self.getTransactionPasswordBlock(password);
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

- (HBAlertPasswordView *)passwordViwe {
    if (!_passwordViwe) {
        _passwordViwe = [[HBAlertPasswordView alloc] initWithFrame:CGRectMake(kScrAdaptationW750(50), kScrAdaptationH750(165), kScrAdaptationW750(650), kScrAdaptationH750(100))];
        _passwordViwe.delegate = self;
        kWeakSelf
        _passwordViwe.keyboardWillShowBlock = ^(NSNotification *notification) {
            CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            [UIView animateWithDuration:duration animations:^{
                weakSelf.contentView.y = weakSelf.contentView.y - (frame.size.height + weakSelf.contentView.height);
            }];
        };
        _passwordViwe.keyboardWillHideBlock = ^(NSNotification *notification) {
            CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            [UIView animateWithDuration:duration animations:^{
                weakSelf.contentView.y = [UIScreen mainScreen].bounds.size.height;
            } completion:^(BOOL finished) {
                [weakSelf removeFromSuperview];
            }];

        };
    }
    return _passwordViwe;
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
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScrAdaptationH750(388))];
        _contentView.backgroundColor = kHXBColor_BackGround;
    }
    return _contentView;
}

- (UIButton *)backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [[UIButton alloc] init];
        [_backgroundButton addTarget:self action:@selector(closePasswordView) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backgroundButton;
}

#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end

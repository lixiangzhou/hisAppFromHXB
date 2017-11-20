//
//  HXBBaseUrlSettingView.m
//  hoomxb
//
//  Created by lxz on 2017/11/16.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseUrlSettingView.h"

@interface HXBBaseUrlSettingView ()
@property (nonatomic, weak) UITextField *textField;
@end

@implementation HXBBaseUrlSettingView

+ (void)attatchToWindow {
    HXBBaseUrlSettingView *view = [self settingView];
    view.alpha = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [KeyWindow addSubview:view];
    });
}

+ (instancetype)settingView {
    static HXBBaseUrlSettingView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [HXBBaseUrlSettingView new];
    });
    return view;
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    UITextField *textField = [UITextField new];
    textField.text = [HXBBaseUrlManager manager].baseUrl;
    textField.placeholder = @"例如：http://192.168.1.36:3100";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:textField];
    self.textField = textField;
    
    CGFloat padding = 50;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.left.equalTo(@(padding));
        make.right.equalTo(@(-padding));
        make.height.equalTo(@30);
    }];
    
    // -------------------------------
    UIButton *btn = [UIButton new];
    [btn setTitle:@"确定修改" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = 0.5;
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [HXBBaseUrlManager manager].baseUrl = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        [textField resignFirstResponder];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        }];
    }];
    
    [self addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textField.mas_bottom).offset(30);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
        make.centerX.equalTo(self);
    }];
    
}

#pragma mark - Helper
- (void)show {
    [KeyWindow bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self.textField becomeFirstResponder];
    }];
}

@end

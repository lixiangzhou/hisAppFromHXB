//
//  HXBAccount_AlterLoginPassword_View.m
//  hoomxb
//
//  Created by HXB on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAccount_AlterLoginPassword_View.h"
#import "HXBBasePasswordView.h"///密码的View
@interface HXBAccount_AlterLoginPassword_View ()
///原始的密码的textField
@property (nonatomic,strong) UITextField *password_Original;
///新密码的textField
@property (nonatomic,strong) HXBBasePasswordView *password_New;
///确认修改密码
@property (nonatomic,strong) UIButton *alterButton;

////点击了确认修改密码
@property (nonatomic,copy) void(^clickAlterButtonBlock)();
@end

@implementation HXBAccount_AlterLoginPassword_View
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPView];
    }
    return self;
}

///设置UI
- (void)setUPView {
    kWeakSelf
    self.password_New = [[HXBBasePasswordView alloc]init];
    self.password_Original = [[UITextField alloc]init];
    self.alterButton = [[UIButton alloc]init];
    
    [self addSubview: self.password_Original];
    [self addSubview:self.password_New];
    [self addSubview:self.alterButton];
    
    [self.password_Original mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(kScrAdaptationH(40));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW(20));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
    [self.password_New mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.password_Original).offset(kScrAdaptationH(20));
        make.left.right.height.equalTo(weakSelf.password_Original);
    }];
    [self.alterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.password_New).offset(kScrAdaptationH(20));
        make.centerX.equalTo(weakSelf);
        make.height.equalTo(@(kScrAdaptationH(40)));
        make.width.equalTo(@(kScrAdaptationW(80)));
    }];
    
    self.password_Original.placeholder = @"原始登录密码";
    
    [self.alterButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.alterButton addTarget:self action:@selector(clickAlterButton:) forControlEvents:UIControlEventTouchUpInside];
}
///点击了确认修改按钮
- (void)clickAlterButton: (UIButton *)button {
    NSLog(@"点击了确认修改按钮");
    if (self.clickAlterButtonBlock) self.clickAlterButtonBlock();
}
- (void)clickAlterButtonWithBlock:(void (^)())clickAlterButtonBlock {
    self.clickAlterButtonBlock = clickAlterButtonBlock;
}
@end

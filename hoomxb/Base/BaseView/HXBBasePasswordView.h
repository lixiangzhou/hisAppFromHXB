//
//  HXBBasePasswordView.h
//  hoomxb
//
//  Created by HXB on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

///密码的view
@interface HXBBasePasswordView : UIView

///隐藏密码的展位符
@property (nonatomic,strong) UIImage *hiddenImage;

///眼睛的image
@property (nonatomic,strong) UIImage *hiddenPasswordImage;

///placeholder
@property (nonatomic,copy) NSString *placeholder;

///password constTitle
@property (nonatomic,copy) NSString *passwordConstTitle;

/// 密码
@property (nonatomic,copy) NSString *passwordString;


///6-20位数字和字母组成 密码
+ (BOOL)isPasswordQualifiedFunWithStr: (NSString *)password;

/// 初始化 并且 布局子控件
- (instancetype)initWithFrame:(CGRect)frame
layoutSubView_WithPassword_constLableEdgeInsets: (UIEdgeInsets)password_constLableEdgeInsets
andPassword_TextFieldEdgeInsets: (UIEdgeInsets)Password_TextFieldEdgeInsets
       andEyeButtonEdgeInsets: (UIEdgeInsets)eyeButtonEdgeInsets
           andPassword_constW: (NSInteger)password_constW
                andEyeButtonW: (NSInteger)eyeButtonW;
@end

//
//  UITextField+HxbTextField.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UITextField+HxbTextField.h"

@implementation UITextField (HxbTextField)

+ (UITextField *)hxb_lineTextFieldWithFrame:(CGRect)frame{
    UITextField *textField = [[self alloc]initWithFrame:frame];
    textField.font = [UIFont systemFontOfSize:22];
    textField.tintColor = COR11;
    textField.textColor = COR6;
    //        _phoneTextField.rightView = self.textFieldRightImageView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightView.hidden = YES;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, textField.height - 1, textField.width, 0.5)];
    lineView.backgroundColor = COR11;
    [textField addSubview:lineView];
    return textField;
}


@end

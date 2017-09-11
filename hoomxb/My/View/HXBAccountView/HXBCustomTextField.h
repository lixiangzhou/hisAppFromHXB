//
//  HXBCustomTextField.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^isLimitText)(NSString *text);

@interface HXBCustomTextField : UIView


@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, strong) UIImage *rightImage;
@property (nonatomic, assign) BOOL isHidenLine;
@property (nonatomic, assign) BOOL secureTextEntry;
@property(nonatomic) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL isIDCardTextField;
@property (nonatomic, assign) BOOL isGetCode;
@property(nullable, nonatomic,weak)   id<UITextFieldDelegate> delegate;
@property (nonatomic, copy) NSString * _Nullable typeTextField;
@property (nonatomic, assign) int number; // 必须要设置
@property (nonatomic, assign) int limitStringLength;

/**
 block
 */
@property (nonatomic, copy) isLimitText block;
/**
 背景按钮点击
 */
@property (nonatomic, copy) void(^btnClick)();

@end

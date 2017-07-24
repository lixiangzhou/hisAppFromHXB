//
//  HXBLeftLabelTextView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBLeftLabelTextView : UIView

/**
 leftStr
 */
@property (nonatomic, copy) NSString *leftStr;

/**
 text
 */
@property (nonatomic, copy) NSString *text;
/**
 placeholder
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 是否限制输入2位小数
 */
@property (nonatomic, assign) BOOL isDecimalPlaces;

/**
 键盘类型
 */
@property(nonatomic) UIKeyboardType keyboardType;
@end

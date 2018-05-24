//
//  HXBLeftLabelTextView.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBLeftLabelTextView.h"

@interface HXBLeftLabelTextView()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UIImageView *leftImage;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation HXBLeftLabelTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.leftImage];
        [self addSubview:self.leftLabel];
        [self addSubview:self.textField];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.centerY.equalTo(self);
        make.width.offset(kScrAdaptationW750(27));
        make.height.offset(kScrAdaptationH750(37));
    }];
//    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(kScrAdaptationW750(30));
//        make.centerY.equalTo(self);
//        make.width.offset(kScrAdaptationW750(150));
//    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self.leftImage.mas_right).offset(kScrAdaptationW(10));
        make.right.equalTo(self).offset(kScrAdaptationW750(-30));
    }];
}

- (void)setLeftStr:(NSString *)leftStr
{
    _leftStr = leftStr;
    self.leftLabel.text = leftStr;
    self.leftLabel.hidden = YES;
    self.leftImage.image = [UIImage imageNamed:leftStr];
    [self.leftLabel sizeToFit];
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}

- (NSString *)text
{
    return self.textField.text;
}

- (void)setText:(NSString *)text
{
    self.textField.text = text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)setIsDecimalPlaces:(BOOL)isDecimalPlaces
{
    _isDecimalPlaces = isDecimalPlaces;
    if (isDecimalPlaces) {
        self.textField.delegate = self;
    }
}

#pragma mark - 懒加载
- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _leftLabel.textColor = COR6;
    }
    return _leftLabel;
}

- (UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] init];
        _leftImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImage;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kHXBFont_PINGFANGSC_REGULAR_750(40);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textColor = COR6;
    }
    return _textField;
}

//参数一：range,要被替换的字符串的range，如果是新键入的那么就没有字符串被替换，range.lenth=0,第二个参数：替换的字符串，即键盘即将键入或者即将粘贴到textfield的string
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSMutableString *str = textField.text.mutableCopy;
    if (string.length) {
        [str insertString:string atIndex:range.location];
        NSLog(@"str = %@", str);
    } else {
        NSMutableString *strM = textField.text.mutableCopy;
        NSInteger length = strM.length;
        NSRange range = NSMakeRange(length - 1, 1);

        if (range.location > 0 && range.location + range.length <= length) {
            [strM deleteCharactersInRange:range];
        }
        str = strM.copy;
    }

    if (range.location == 0 && [string isEqualToString:@"0"]) return NO;
    if (range.location == 0 && [string isEqualToString:@"."]) return NO;
    
    if (range.location == 0 && string.length == 0) str = [NSMutableString stringWithString:@""]; // 删除最后一位的时候，把输入框清空
    if (str.length > 0) {
        self.haveStr(YES);
    } else {
        self.haveStr(NO);
    }
    if ([str containsString:@"."]) {
        NSString *intString = [str componentsSeparatedByString:@"."].firstObject;
        if (intString.length > 9) {
            return NO;
        }
        NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return [NSString checkBothDecimalPlaces:checkStr];
        
    } else {
        if (str.length > 9) {
            return NO;
        }
    }
    
    



    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.haveStr(NO);
    return YES;
}

@end

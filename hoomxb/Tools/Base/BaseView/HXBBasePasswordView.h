//
//  HXBBasePasswordView.h
//  hoomxb
//
//  Created by HXB on 2017/6/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

///密码的view
@interface HXBBasePasswordView : UIView

///隐藏密码的展位符
@property (nonatomic,copy) NSString *hiddenStr;

///眼睛的image
@property (nonatomic,strong) UIImage *hiddenPasswordImage;

///placeholder
@property (nonatomic,copy) NSString *passwordTextFiled_Placeholder;

///password constTitle
@property (nonatomic,copy) NSString *passwordConstTitle;

///6-20位数字和字母组成 密码
+ (BOOL)isPasswordQualifiedFunWithStr: (NSString *)password;

///布局子控件
- (void)layoutSubView_WithBlock: (void(^)(UILabel *password_constLable,UITextField *password_TextField , UIButton *eyeButton)) layoutSubViewBlock;
@end

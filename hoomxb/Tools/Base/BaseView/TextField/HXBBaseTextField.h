//
//  HXBBaseTextField.h
//  hoomxb
//
//  Created by HXB on 2017/6/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseTextField : UIView

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *button;

/**
 
 左边textField，右边button
 * @param space lien距离两边的距离
 * @param lienHeight 线的高度
 * @param rightButtonWidth 左边的button
 */
- (instancetype)initWithFrame:(CGRect)frame andBottomLienSpace: (CGFloat)space
          andBottomLienHeight: (CGFloat)lienHeight
               andRightButtonW: (CGFloat) rightButtonWidth;

- (void) lienColorWithRed:(CGFloat)red andGreen: (CGFloat)green andBlue: (CGFloat)blue andAlpha: (CGFloat)alpha;
- (void)show;
@end


//
//  HXBRechargeView.h
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBRechargeView : UIView


@property (nonatomic,assign) BOOL isEndEditing;

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *button;
///placeholder
@property (nonatomic,copy)NSString *placeholder;
///点击了一键购买
- (void)clickBuyButtonFunc:(void(^)())clickBuyButtonBlock;
@end

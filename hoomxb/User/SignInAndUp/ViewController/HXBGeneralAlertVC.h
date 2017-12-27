//
//  HXBGeneralAlertVC.h
//  hoomxb
//
//  Created by hxb on 2017/11/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  通用弹窗 默认三个按键(有❌号)

#import <UIKit/UIKit.h>

@interface HXBGeneralAlertVC : UIViewController

- (instancetype)initWithMessageTitle:(NSString *)messageTitle andSubTitle:(NSString *)subTitle andLeftBtnName:(NSString *)leftBtnName andRightBtnName:(NSString *)rightBtnName isHideCancelBtn:(BOOL)isHideCancelBtn isClickedBackgroundDiss:(BOOL)isClickedBackgroundDiss;

/**
 取消按钮
 */
@property (nonatomic, copy) void(^cancelBtnClickBlock)();
/**
 leftBtnBlock
 */
@property (nonatomic, copy) void(^leftBtnBlock)();
/**
 rightBtnBlock
 */
@property (nonatomic, copy) void(^rightBtnBlock)();


@end

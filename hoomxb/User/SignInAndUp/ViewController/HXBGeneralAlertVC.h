//
//  HXBGeneralAlertVC.h
//  hoomxb
//
//  Created by hxb on 2017/11/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  通用弹窗 默认三个按键(有❌号)

#import <UIKit/UIKit.h>

@interface HXBGeneralAlertVC : UIViewController

/**
 是否需要内部自动dismiss,默认是YES内部自动帮你释放
 */
@property (nonatomic, assign) BOOL isAutomaticDismiss;

/**
  通用弹窗

 @param messageTitle 标题
 @param subTitle 描述
 @param leftBtnName 左按钮文字
 @param rightBtnName 右按钮文字
 @param isHideCancelBtn 是否隐藏叉号
 @param isClickedBackgroundDiss 点击背景弹窗是否消失
 @return return value description
 */
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

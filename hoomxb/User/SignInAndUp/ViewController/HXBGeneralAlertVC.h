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
 messagetitle
 */
@property (nonatomic, copy)NSString *messageTitle;

/**
 子标题
 */
@property (nonatomic, copy) NSString *subTitle;

/**
 左按钮名字
 */
@property (nonatomic, copy)NSString *leftBtnName;
/**
 右按钮名字
 */
@property (nonatomic, copy)NSString *rightBtnName;
/**
 有无叉号
 */
@property (nonatomic, assign)BOOL isHideCancelBtn;
/**
 点击背景是否diss页面
 */
@property (nonatomic, assign)BOOL isClickedBackgroundDiss;


- (void)leftBtnWithBlock:(void (^)())leftBtnBlock;
- (void)rightBtnWithBlock:(void (^)())rightBtnBlock;
- (void)cancelBtnWithBlock:(void (^)())cancelBtnClickBlock;//点击叉号block

@end

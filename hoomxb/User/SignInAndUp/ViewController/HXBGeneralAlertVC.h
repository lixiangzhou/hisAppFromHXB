//
//  HXBGeneralAlertVC.h
//  hoomxb
//
//  Created by hxb on 2017/11/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//  通用弹窗 三键

#import <UIKit/UIKit.h>

@interface HXBGeneralAlertVC : UIViewController

@property (nonatomic, copy) NSString *type;//标识
/**
 messagetitle
 */
@property (nonatomic, copy) NSString *messageTitle;

/**
 子标题
 */
@property (nonatomic, copy) NSString *subTitle;

- (void)leftBtnWithBlock:(void (^)())leftBtnBlock;
- (void)rightBtnWithBlock:(void (^)())rightBtnBlock;
- (void)cancelBtnWithBlock:(void (^)())cancelBtnClickBlock;

@end

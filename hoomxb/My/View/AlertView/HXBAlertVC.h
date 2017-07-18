//
//  HXBAlertVC.h
//  hoomxb
//
//  Created by HXB-C on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBAlertVC : UIViewController

/**
 messagetitle
 */
@property (nonatomic, copy) NSString *messageTitle;

/**
 是否是验证码
 */
@property (nonatomic, assign) BOOL isCode;

/**
 确认按钮
 */
@property (nonatomic, copy) void(^sureBtnClick)(NSString *pwd);

///**
// 确认按钮
// */
@property (nonatomic, copy) void(^forgetBtnClick)();



@end

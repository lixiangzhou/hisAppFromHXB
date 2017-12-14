//
//  HXBXYAlertViewController.h
//  hoomxb
//
//  Created by HXB on 2017/8/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@interface HXBXYAlertViewController : UIViewController

- (instancetype) initWithTitle:(NSString *)title
                       Massage:(NSString *)massage
                         force:(int)force   // 是否强制更新，强制，只展示一个按钮，
          andLeftButtonMassage:(NSString *)leftButtonMassage
         andRightButtonMassage:(NSString *)rightButtonMassage;

@property (nonatomic, assign) BOOL isCenterShow;
@property (nonatomic, assign) BOOL isHIddenLeftBtn;
@property (nonatomic, assign) BOOL isHiddenTitle;

/**
 是否需要内部自动dismiss,默认是YES内部自动帮你释放
 */
@property (nonatomic, assign) BOOL isAutomaticDismiss;

///点击了左边按钮
@property (nonatomic,copy) void(^clickXYLeftButtonBlock)();
///点击了右边按钮
@property (nonatomic,copy) void(^clickXYRightButtonBlock)();

@end
